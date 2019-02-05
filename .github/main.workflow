workflow "New workflow" {
  on = "push"
  resolves = [
    "GitHub Push elk",
    "Docker Push mongo",
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
