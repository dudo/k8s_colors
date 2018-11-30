workflow "New workflow" {
  on = "push"
  resolves = ["GitHub Action for Docker"]
}

action "GitHub Action for Docker" {
  uses = "actions/docker/cli@6495e70"
  runs = "f"
}
