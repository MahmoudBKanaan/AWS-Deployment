# Security Notes

## Implemented controls

- The S3 bucket is private and all four Public Access Block settings are enabled.
- S3 Object Ownership is `BucketOwnerEnforced`, disabling ACL-based access.
- The HTML object is encrypted at rest with SSE-S3 (AES-256).
- S3 versioning is enabled.
- CloudFront uses Origin Access Control with SigV4 request signing.
- The S3 bucket policy grants `s3:GetObject` only to the CloudFront service principal and restricts access to the specific distribution ARN.
- CloudFront redirects HTTP viewers to HTTPS.
- Terraform provides a reproducible configuration and controlled destruction process.
- No EC2, containers, serverless functions, APIs, databases, load balancers, custom DNS, custom certificates, WAF, CI/CD, React, Node.js, or backend application is deployed.

## Credential rules

- Never use the AWS root account for Terraform operations.
- Never create root access keys.
- Prefer temporary credentials or an AWS CLI login flow.
- Never write credentials, access keys, secret keys, or session tokens into Terraform files, `.env` files, documentation, screenshots, Git, or ZIP submissions.
- Do not submit Terraform state because it can contain sensitive infrastructure data.
- Review command output and screenshots for account IDs, ARNs, usernames, email addresses, and tokens before submission.

## Evidence rules

- Demonstrate successful HTTPS delivery without exposing query strings or browser credentials.
- Demonstrate S3 `403 Access Denied` through the direct origin URL.
- Demonstrate Public Access Block without exposing unrelated account details.
- Redact account IDs and identity information when they are not essential to the assessment evidence.
- Store only sanitized evidence in `evidence/`.

## Removal

The S3 bucket uses `force_destroy = true` so Terraform can remove the current object and all versioned copies during teardown. Do not destroy the environment before the tutor confirms it is no longer needed. After `terraform destroy`, verify that no project resources or continuing charges remain.
