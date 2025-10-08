# Contributing

- **Branching:** `feature/*`, `fix/*`, `chore/*`
- **Commits:** Conventional Commits (e.g., `feat: add sg rule for ssh ip`)
- **PRs:** Keep them small. Use the PR template. Include risk & rollback.

## Local checks
```bash
terraform fmt -recursive
terraform validate
terraform plan -var-file=terraform.tfvars
