# Human Actions

The following actions require the student, tutor, examination system, or authenticated AWS session.

## Before deployment

- [x] Install AWS CLI version 2
- [x] Install Terraform CLI
- [ ] Secure the AWS root account with MFA
- [ ] Create an AWS budget and billing alert
- [ ] Authenticate using temporary credentials or a dedicated project identity
- [ ] Run `aws sts get-caller-identity` and verify the intended account and role without recording the account ID in submitted evidence
- [ ] Confirm that no credentials exist in the repository

## Deployment and verification

- [ ] Run `terraform init`
- [ ] Run `terraform fmt -recursive`
- [ ] Run `terraform validate`
- [ ] Run and review `terraform plan -out=tfplan`
- [ ] Run `terraform apply tfplan`
- [ ] Wait for CloudFront status `Deployed`
- [ ] Test the HTTPS website URL
- [ ] Test HTTP-to-HTTPS redirection
- [ ] Verify all S3 Public Access Block settings
- [ ] Verify direct S3 access returns `403 Access Denied`
- [ ] Run `terraform plan` and confirm no unexpected changes
- [ ] Capture sanitized screenshots in `evidence/`

## Portfolio and submission

- [ ] Create the architecture diagram
- [ ] Complete Portfolio Part 1 and request tutor feedback
- [ ] Complete Portfolio Part 2 and request tutor feedback
- [ ] Incorporate all tutor feedback
- [ ] Complete the abstract and final documentation
- [ ] Replace `{SubmissionDate}` and `{TutorName}`
- [ ] Complete the electronic affidavit
- [ ] Test all links and inspect all PDFs
- [ ] Submit through PebblePad/myCampus

## After assessment

- [ ] Obtain confirmation that the live environment is no longer required
- [ ] Review `terraform plan -destroy`
- [ ] Run `terraform destroy`
- [ ] Confirm all project resources and object versions are removed
- [ ] Check AWS billing for continuing charges
- [ ] Remove unused project credentials
