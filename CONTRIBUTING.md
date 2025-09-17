\# Contributing



\## PR flow

1\) Create a small branch: `feature/<slug>` or `chore/<slug>`

2\) Local checks:

&nbsp;  - `terraform fmt -recursive`

&nbsp;  - `terraform init`

&nbsp;  - `terraform validate`

&nbsp;  - `terraform plan -no-color -lock=false -refresh=false`

3\) Open a PR. CI re-runs fmt/validate/plan and posts the plan in the Job Summary.

4\) Get review and merge. No apply in CI.



\## Commit style

Clear, descriptive messages. Conventional Commits (`feat:`, `fix:`, `chore:`) are welcome.



\## Secrets

Do \*\*not\*\* commit secrets. We’ll add gated `apply` later with protected env + OIDC.



