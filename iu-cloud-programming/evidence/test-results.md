# Test Results

Project: Secure and Globally Distributed Static Website on AWS Using Terraform  
Execution date: 2026-07-17  
AWS region: `eu-central-1`

Every PASS below is supported by command output or a live-system capture. No tutor feedback or unexecuted result is represented as evidence.

| # | Test name | Command or action | Expected result | Actual result | Status | Screenshot | Execution date |
|---:|---|---|---|---|:---:|---|---|
| 01 | Local tool versions | `aws --version`<br>`terraform -version`<br>`git --version` | AWS CLI v2, Terraform 1.6.0 or later, and Git are available. | AWS CLI 2.36.1, Terraform 1.15.8, and Git 2.45.1 were returned. | PASS | [01-tool-versions.png](../../EvidenceScreensshots/01-tool-versions.png) | 2026-07-17 |
| 02 | Terraform formatting and validation | `terraform fmt -check -recursive`<br>`terraform validate` | Formatting check exits successfully and Terraform reports a valid configuration. | Formatting produced no errors; Terraform returned `Success! The configuration is valid.` | PASS | [02-terraform-validate.png](../../EvidenceScreensshots/02-terraform-validate.png) | 2026-07-17 |
| 03 | Initial Terraform plan | `terraform plan -out=tfplan` | Plan contains only the nine approved S3 and CloudFront resources, with no prohibited services. | `Plan: 9 to add, 0 to change, 0 to destroy.` Machine-readable inspection found only the expected resource types and no public ACL values. | PASS | [03-terraform-plan-create.png](../../EvidenceScreensshots/03-terraform-plan-create.png) | 2026-07-17 |
| 04 | Terraform deployment | `terraform apply tfplan` | All nine planned resources are created without errors. | Terraform returned `Apply complete! Resources: 9 added, 0 changed, 0 destroyed.` | PASS | [04-terraform-apply-complete.png](../../EvidenceScreensshots/04-terraform-apply-complete.png) | 2026-07-17 |
| 05 | Live CloudFront website | Open `terraform output -raw website_url` in a modern browser. | The static page loads over HTTPS through CloudFront. | The deployed page loaded at `https://d216eikm4r4k38.cloudfront.net` and returned HTTP 200. | PASS | [05-live-cloudfront-website.png](../../EvidenceScreensshots/05-live-cloudfront-website.png) | 2026-07-17 |
| 06 | CloudFront distribution details | `aws cloudfront get-distribution --id EZW53YPRFUFEA --query "Distribution.{Id:Id,Status:Status,DomainName:DomainName,Enabled:DistributionConfig.Enabled}"` | Distribution is enabled and deployed with the expected domain. | Status was `Deployed`, `Enabled` was `true`, and the domain was `d216eikm4r4k38.cloudfront.net`. | PASS | [06-cloudfront-deployed.png](../../EvidenceScreensshots/06-cloudfront-deployed.png) | 2026-07-17 |
| 07 | S3 index object | `aws s3api head-object --bucket $(terraform output -raw s3_bucket_name) --key index.html` | `index.html` exists with HTML content type, cache metadata, and server-side encryption. | Object size was 5,874 bytes; content type was `text/html; charset=utf-8`; cache control was `public, max-age=300`; encryption was `AES256`. | PASS | [07-s3-index-object.png](../../EvidenceScreensshots/07-s3-index-object.png) | 2026-07-17 |
| 08 | Initial S3 Public Access Block check | `aws s3api get-public-access-block --bucket $(terraform output -raw s3_bucket_name)` | All four Public Access Block settings are `true`. | `BlockPublicAcls`, `IgnorePublicAcls`, `BlockPublicPolicy`, and `RestrictPublicBuckets` were all `true`. | PASS | [08-s3-public-access-block.png](../../EvidenceScreensshots/08-s3-public-access-block.png) | 2026-07-17 |
| 09 | CloudFront HTTPS response | `curl.exe -I $(terraform output -raw website_url)` | HTTP 200 with CloudFront-related response headers. | Returned `HTTP/1.1 200 OK` with `X-Cache`, `Via`, `X-Amz-Cf-Pop`, and `X-Amz-Cf-Id`. | PASS | [09-https-response.png](../../EvidenceScreensshots/09-https-response.png) | 2026-07-17 |
| 10 | HTTP-to-HTTPS redirect | `curl.exe -I http://$(terraform output -raw cloudfront_domain_name)` | HTTP redirects to the equivalent HTTPS URL. | Returned `HTTP/1.1 301 Moved Permanently` with `Location: https://d216eikm4r4k38.cloudfront.net/`. | PASS | [10-http-to-https-redirect.png](../../EvidenceScreensshots/10-http-to-https-redirect.png) | 2026-07-17 |
| 11 | Public Access Block CLI verification | `aws s3api get-public-access-block --bucket $(terraform output -raw s3_bucket_name)` | All four settings remain enabled after deployment. | All four Public Access Block values were `true`. | PASS | [11-public-access-block-cli.png](../../EvidenceScreensshots/11-public-access-block-cli.png) | 2026-07-17 |
| 12 | Direct S3 access denial | `curl.exe -I https://$(terraform output -raw s3_origin_domain)/index.html` | Direct unauthenticated origin access is denied, normally with HTTP 403. | Returned `HTTP/1.1 403 Forbidden` from Amazon S3. | PASS | [12-direct-s3-access-denied.png](../../EvidenceScreensshots/12-direct-s3-access-denied.png) | 2026-07-17 |
| 13 | CloudFront deployment status | `aws cloudfront get-distribution --id $(terraform output -raw cloudfront_distribution_id) --query "Distribution.Status"` | Command returns `Deployed`. | Command returned `Deployed`. | PASS | [13-cloudfront-status.png](../../EvidenceScreensshots/13-cloudfront-status.png) | 2026-07-17 |
| 14 | CloudFront cache hit | Request the website four times and inspect `X-Cache` and `Age` headers. | Repeated requests show `X-Cache: Hit from cloudfront`. | Four consecutive HTTP 200 responses returned `X-Cache: Hit from cloudfront` with nonzero `Age` values. | PASS | [14-cloudfront-cache-hit.png](../../EvidenceScreensshots/14-cloudfront-cache-hit.png) | 2026-07-17 |
| 15 | Terraform post-deployment consistency | `terraform plan` | Terraform reports `No changes. Your infrastructure matches the configuration.` | Terraform returned the exact expected no-change message and found no differences. | PASS | [15-terraform-no-changes.png](../../EvidenceScreensshots/15-terraform-no-changes.png) | 2026-07-17 |
| 16 | Repeatable Terraform redeployment | Edit `site/index.html`; run `terraform plan -out=tfplan`; apply the plan; invalidate CloudFront; verify the live page; run `terraform plan` | Only the HTML object changes, the invalidation completes, the changed content appears, and the final plan reports no changes. | One S3 object was updated in place; invalidation `I22L1B6ZRC0RIIX8HM79OZQ5C1` completed; the new status text was served through CloudFront; the final plan reported no changes. | PASS | [16-repeatable-redeployment.png](../../EvidenceScreensshots/16-repeatable-redeployment.png) | 2026-07-17 |

## Summary

- Tests executed: 16
- Passed: 16
- Failed: 0
- Outstanding test defects: 0
- Credential-pattern scan of generated evidence: passed
