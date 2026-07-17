# Tutor Feedback Matrix

No tutor feedback was available when this package was created. No comment, requested correction, approval, or test result has been invented.

| Feedback date | Tutor feedback | Related artifact | Action taken | Verification |
|---|---|---|---|---|
| Not available | No feedback received | Not applicable | No tutor-driven change recorded | Not applicable |

## Project corrections recorded independently

| Issue | Correction | Evidence |
|---|---|---|
| Nested Git repository prevented staging | Removed nested repository metadata and retained one repository at the project root | Git staging subsequently completed |
| Assignment and knowledge-base files were at risk of inclusion | Explicitly excluded them from the portfolio package | Final manifest and exclusion scan |
| Terraform plan output was redirected from the wrong directory | Re-ran the command from `iu-cloud-programming` and stored the readable plan under `evidence/` | `test-results.md` and genuine screenshots |
| CloudFront could serve cached content after an update | Applied the object change, created an invalidation, and verified the updated live page | `16-repeatable-redeployment.png` |
