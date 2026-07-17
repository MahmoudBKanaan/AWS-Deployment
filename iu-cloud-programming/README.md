# Secure and Globally Distributed Static Website on AWS Using Terraform

This IU Cloud Programming project deploys one static HTML page from a private Amazon S3 bucket and distributes it globally through Amazon CloudFront. Terraform provisions the complete environment.

## Objective

Deploy one static HTML page from a private Amazon S3 bucket and distribute it globally through Amazon CloudFront with high availability, low-latency delivery, managed scaling, HTTPS, reproducible Infrastructure as Code, and secure removal after assessment.

## Architecture

```text
Global User
    |
    | HTTPS
    v
Amazon CloudFront
    |
    | Signed request using Origin Access Control
    v
Private Amazon S3 Bucket
    |
    +-- index.html
```

## Services

- One private S3 bucket and one `index.html` object
- S3 Public Access Block and Object Ownership controls
- S3 SSE-S3 encryption and versioning
- One CloudFront Origin Access Control
- One CloudFront distribution
- One source-restricted S3 bucket policy
- Terraform configuration files

## CloudFront price class

The distribution uses `PriceClass_All`. The assignment requires low-latency delivery to visitors around the world, so the distribution is allowed to use all available CloudFront edge-location groups rather than limiting delivery to lower-cost geographic regions. This choice prioritizes the stated global-performance requirement. For a cost-sensitive production workload with a known regional audience, a more limited price class could be evaluated using measured traffic and latency data.

The page has no client-side router. Therefore, the distribution does not rewrite HTTP `403` or `404` responses to `index.html`.

## Prerequisites

- AWS CLI version 2
- Terraform CLI
- An authenticated AWS CLI session using a dedicated project identity or temporary credentials

Never place credentials in this directory, Terraform files, screenshots, or Git.

## Authentication

This project uses the existing AWS CLI profile named `iu-cloud`. In PowerShell, select the profile for the current terminal and verify the caller before running Terraform:

```powershell
$env:AWS_PROFILE = "iu-cloud"
aws sts get-caller-identity
```

Confirm that the returned identity is the intended dedicated project user. Do not copy the account ID, ARN, access keys, secret keys, or session tokens into source files or submitted screenshots. If the profile is unavailable or expired, authenticate through the approved AWS CLI login or credential process before continuing. Never use root access keys.

## Deployment

```powershell
$env:AWS_PROFILE = "iu-cloud"
terraform init
terraform fmt -recursive
terraform validate
terraform plan -out=tfplan
terraform apply tfplan
terraform output -raw website_url
```

CloudFront deployment can take several minutes.

## Testing

Run the following PowerShell commands after CloudFront reaches the `Deployed` state:

```powershell
$env:AWS_PROFILE = "iu-cloud"

# HTTPS response: expect HTTP 200 and CloudFront response headers.
curl.exe -I $(terraform output -raw website_url)

# HTTP request: expect a redirect to HTTPS.
curl.exe -I "http://$(terraform output -raw cloudfront_domain_name)"

# All four Public Access Block values must be true.
aws s3api get-public-access-block --bucket $(terraform output -raw s3_bucket_name)

# Direct origin request: expect HTTP 403 Access Denied.
curl.exe -I "https://$(terraform output -raw s3_origin_domain)/index.html"

# Distribution status: expect Deployed.
aws cloudfront get-distribution `
  --id $(terraform output -raw cloudfront_distribution_id) `
  --query "Distribution.Status"

# Reproducibility check: expect no unexpected changes.
terraform plan
```

Store sanitized screenshots and command output in `evidence/`.

## Update procedure

Edit only `site/index.html`, then review and deploy the detected object change:

```powershell
$env:AWS_PROFILE = "iu-cloud"
terraform fmt -recursive
terraform validate
terraform plan -out=tfplan
terraform apply tfplan
```

The HTML object has `Cache-Control: public, max-age=300`, so edge caches can retain it for up to five minutes. To make an assessed update visible immediately, create a CloudFront invalidation and wait for it to complete:

```powershell
aws cloudfront create-invalidation `
  --distribution-id $(terraform output -raw cloudfront_distribution_id) `
  --paths "/*"
```

## Secure removal after assessment

Keep the environment available until the tutor confirms it is no longer required. Then run:

```powershell
$env:AWS_PROFILE = "iu-cloud"
terraform plan -destroy
terraform destroy
```

Confirm that CloudFront, the Origin Access Control, all S3 object versions, the bucket policy, and the bucket are removed. Check AWS billing for unexpected continuing charges.

## Security summary

- The S3 bucket blocks all public access and uses `BucketOwnerEnforced` ownership.
- The object is encrypted at rest using SSE-S3 with AES-256 and protected by S3 versioning.
- Only the created CloudFront distribution can call `s3:GetObject`, enforced through the `AWS:SourceArn` condition.
- CloudFront signs origin requests with SigV4 through Origin Access Control and redirects viewers from HTTP to HTTPS.
- No credentials are stored or output by Terraform. State and plan files are excluded from Git.
- The deployment contains no server, container, API, database, custom domain, custom certificate, analytics, authentication, or backend application.

## Cost warning

AWS resources can generate charges, and free-tier eligibility must not be assumed. `PriceClass_All` uses CloudFront's complete global edge-location footprint to meet the assignment's worldwide latency requirement. Before deployment, configure an AWS budget and billing alert. Monitor billing while the project remains available for assessment, avoid unnecessary invalidations or traffic, and destroy the environment only after the tutor confirms it is no longer needed.

## Documentation

- `PROJECT-STATUS.md` records progress.
- `DELIVERABLES.md` records portfolio outputs and submission checks.
- `HUMAN-ACTIONS.md` records actions that require the student or tutor.
- `SECURITY-NOTES.md` records security controls and evidence-handling rules.
- `environment/tool-versions.txt` records sanitized tool versions.
