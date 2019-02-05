workflow "New workflow" {
  on = "push"
  resolves = ["GitHub Push elk"]
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
