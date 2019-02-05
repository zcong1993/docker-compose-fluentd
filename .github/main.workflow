workflow "New workflow" {
  on = "push"
  resolves = ["Docker Tag"]
}

action "Docker Registry" {
  uses = "actions/docker/login@aea64bb1b97c42fa69b90523667fef56b90d7cff"
  secrets = [
    "DOCKER_PASSWORD",
    "DOCKER_USERNAME",
  ]
}

action "Docker Tag" {
  uses = "actions/docker/cli@aea64bb1b97c42fa69b90523667fef56b90d7cff"
  needs = ["Docker Registry"]
  args = "build --build-arg FLUENTD_VERSION=v1.3-onbuild-1 -t zcong/fluentd-elk ./fluentd/efk/"
}
