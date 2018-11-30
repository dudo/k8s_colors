workflow "Create image" {
  on = "push"
  resolves = [
    "docker push",
  ]
}

action "docker build" {
  uses = "actions/docker/cli@6495e70"
  args = "[\"build\", \"-t\", \"base\", \".\"]"
}

action "docker tag" {
  uses = "actions/docker/tag@6495e70"
  needs = ["docker build"]
  env = {
    IMAGE_NAME = "dudo/colors"
  }
  args = "[\"base\", $IMAGE_NAME]"
}

action "docker login" {
  uses = "actions/docker/login@6495e70"
  needs = ["docker tag"]
  secrets = ["DOCKER_PASSWORD", "DOCKER_USERNAME"]
}

action "docker push" {
  uses = "actions/docker/cli@6495e70"
  needs = ["docker login"]
  args = "[\"push\", \"$IMAGE_NAME\"]"
  env = {
    IMAGE_NAME = "dudo/colors"
  }
}
