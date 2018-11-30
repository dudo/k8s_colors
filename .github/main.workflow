workflow "Create image" {
  on = "push"
  resolves = ["docker push"]
}

action "docker build" {
  uses = "actions/docker/cli@6495e70"
  args = "build -t dudo/colors:$GITHUB_SHA ."
}

action "docker login" {
  uses = "actions/docker/login@6495e70"
  needs = ["docker build"]
  secrets = ["DOCKER_PASSWORD", "DOCKER_USERNAME"]
}

action "docker push" {
  uses = "actions/docker/cli@6495e70"
  needs = ["docker login"]
  args = "push dudo/colors:$GITHUB_SHA"
}
