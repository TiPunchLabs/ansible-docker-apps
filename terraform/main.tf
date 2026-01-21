resource "github_repository" "repo" {
  name        = var.repository_name
  description = var.repository_description
  visibility  = var.visibility
}
