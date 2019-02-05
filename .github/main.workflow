workflow "Docker Build and Push" {
  on = "push"
  resolves = [
    "GitHub Push elk",
    "Docker Push mongo",
    "Docker Push loki",
  ]
}

action "Docker Login" {
  uses = "actions/docker/login@aea64bb1b97c42fa69b90523667fef56b90d7cff"
  secrets = [
    "DOCKER_PASSWORD",
    "DOCKER_USERNAME",
  ]
}

action "Docker Build elk" {
  uses = "actions/docker/cli@aea64bb1b97c42fa69b90523667fef56b90d7cff"
  args = "build --build-arg FLUENTD_VERSION=v1.3-onbuild-1 -t zcong/fluentd-elk ./fluentd/efk/"
  needs = ["Docker Login"]
}

action "GitHub Push elk" {
  uses = "actions/docker/cli@aea64bb1b97c42fa69b90523667fef56b90d7cff"
  args = "push zcong/fluentd-elk"
  needs = ["Docker Build elk"]
}

action "Docker Build mongo" {
  uses = "actions/docker/cli@aea64bb1b97c42fa69b90523667fef56b90d7cff"
  needs = ["Docker Login"]
  args = "build --build-arg FLUENTD_VERSION=v1.3-onbuild-1 -t zcong/fluentd-mongo ./fluentd/mongo/"
}

action "Docker Push mongo" {
  uses = "actions/docker/cli@aea64bb1b97c42fa69b90523667fef56b90d7cff"
  needs = ["Docker Build mongo"]
  args = "push zcong/fluentd-mongo"
}

action "Docker Build loki" {
  uses = "actions/docker/cli@aea64bb1b97c42fa69b90523667fef56b90d7cff"
  needs = ["Docker Login"]
  args = "build --build-arg FLUENTD_VERSION=v1.3-onbuild-1 -t zcong/fluentd-loki ./fluentd/loki/"
}

action "Docker Push loki" {
  uses = "actions/docker/cli@aea64bb1b97c42fa69b90523667fef56b90d7cff"
  needs = ["Docker Build loki"]
  args = "push zcong/fluentd-loki"
}
