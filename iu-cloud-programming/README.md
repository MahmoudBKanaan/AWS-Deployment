# Secure and Globally Distributed Static Website on AWS Using Terraform

This IU Cloud Programming project deploys one static HTML page from a private Amazon S3 bucket and distributes it globally through Amazon CloudFront. Terraform provisions the complete environment.

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

## Included resources

- One private S3 bucket and one `index.html` object
- S3 Public Access Block and Object Ownership controls
- S3 SSE-S3 encryption and versioning
- One CloudFront Origin Access Control
- One CloudFront distribution
- One source-restricted S3 bucket policy
- Terraform configuration files

## Prerequisites

- AWS CLI version 2
- Terraform CLI
- An authenticated AWS CLI session using a dedicated project identity or temporary credentials

Never place credentials in this directory, Terraform files, screenshots, or Git.

## Deployment

```text
aws sts get-caller-identity
terraform init
terraform fmt -recursive
terraform validate
terraform plan -out=tfplan
terraform apply tfplan
terraform output -raw website_url
```

CloudFront deployment can take several minutes.

## Verification

- Open the `website_url` output and confirm HTTP `200` over HTTPS.
- Confirm HTTP redirects to HTTPS.
- Confirm all S3 Public Access Block settings are enabled.
- Confirm direct S3 access to `index.html` returns HTTP `403 Access Denied`.
- Confirm the CloudFront distribution status is `Deployed`.
- Run `terraform plan` and confirm there are no unexpected changes.

Store sanitized screenshots and command output in `evidence/`.

## Secure removal after assessment

Keep the environment available until the tutor confirms it is no longer required. Then run:

```text
terraform plan -destroy
terraform destroy
```

Confirm that CloudFront, the Origin Access Control, all S3 object versions, the bucket policy, and the bucket are removed. Check AWS billing for unexpected continuing charges.

## Documentation

- `PROJECT-STATUS.md` records progress.
- `DELIVERABLES.md` records portfolio outputs and submission checks.
- `HUMAN-ACTIONS.md` records actions that require the student or tutor.
- `SECURITY-NOTES.md` records security controls and evidence-handling rules.
- `environment/tool-versions.txt` records sanitized tool versions.
