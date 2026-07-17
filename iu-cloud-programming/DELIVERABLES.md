# Cloud Programming Portfolio Deliverables

## Project identity

- **Course:** Cloud Programming (DLBSEPCP01_E)
- **Selected assignment:** Task 1 - Host a simple webpage on AWS
- **Project title:** Secure and Globally Distributed Static Website on AWS Using Terraform
- **Objective:** Deploy one static HTML page from a private Amazon S3 bucket and distribute it globally through Amazon CloudFront.

## Submission metadata

Use the following values consistently on title pages, portfolio documents, presentations, abstracts, filenames, and submission records:

| Field | Value |
| --- | --- |
| Surname | Kanaan |
| Full name | Mahmoud |
| Matriculation number | 92133250 |
| Course code | DLBSEPCP01_E |
| Submission date | `{SubmissionDate}` |
| Tutor name | `{TutorName}` |

The brace-enclosed values are placeholders and must be replaced before final submission.

## Approved implementation scope

The submitted AWS environment contains only:

- One private Amazon S3 bucket
- One `index.html` object
- S3 Public Access Block
- S3 Object Ownership controls
- S3 server-side encryption using SSE-S3 (AES-256)
- S3 versioning
- One CloudFront Origin Access Control
- One CloudFront distribution
- One source-restricted S3 bucket policy
- Terraform configuration files

The deployed page is `static-site/index.html`. It is standalone HTML and CSS with no runtime, external asset, React, Node.js, or backend dependency.

## Portfolio Part 1 - Conception phase

Prepare and submit one PDF containing:

- Approximately one A4 page of conceptual text
- The problem and project objective
- The proposed architecture and request flow
- Justification for Amazon S3, Amazon CloudFront, Origin Access Control, and Terraform
- Discussion of high availability, global latency, managed scaling, HTTPS, private storage, and reproducibility
- At least one embedded architecture diagram in PNG or JPEG format

The architecture diagram must show:

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

Terraform provisions the complete environment.
```

### Part 1 files

- [ ] `P1-concept.pdf`
- [ ] `architecture-diagram.png`
- [ ] Tutor feedback received and retained

## Portfolio Part 2 - Development and reflection phase

Prepare an approximately 10-slide composite presentation PDF:

1. Title, student details, course, task, and project title
2. Problem, objective, and requirements
3. Architecture diagram and request flow
4. AWS service selection and excluded-service rationale
5. Terraform design, configuration files, and code hyperlink
6. Security: private bucket, Public Access Block, OAC policy, HTTPS, and encryption
7. Availability, global performance, managed scaling, and CloudFront caching
8. Deployment evidence: successful Terraform apply, deployed distribution, and live page
9. Verification, challenges, reflection, and tutor-feedback changes
10. Results, conclusion, references, and code hyperlink

### Part 2 evidence

- [ ] `terraform init` completed
- [ ] `terraform fmt -recursive` completed
- [ ] `terraform validate` succeeded
- [ ] Terraform plan reviewed
- [ ] Terraform apply completed
- [ ] Website opened through the CloudFront HTTPS URL
- [ ] CloudFront distribution status shown as `Deployed`
- [ ] S3 bucket shown as private
- [ ] First IaC code draft shared through a tutor-accessible restricted link
- [ ] Academic citations and reference list included
- [ ] Tutor feedback received and retained

### Part 2 files

- [ ] `P2-presentation.pdf`
- [ ] First Terraform code draft
- [ ] Readable implementation screenshots

## Portfolio Part 3 - Finalisation phase

### Two-page abstract

Prepare a separate two-page making-of abstract covering:

- Background and objective
- Architecture concept
- Technical implementation
- Security approach
- Availability, performance, and scaling
- Deployment and verification
- Challenges and tutor-feedback changes
- Final result and conclusion

Use A4 pages, 2 cm margins, Arial 11 pt body text, Arial 12 pt headings, Arial 10 pt footnotes, 1.5 line spacing, justified paragraphs, automatic hyphenation, and 6 pt paragraph spacing.

### Final documentation

Prepare an approximately 10-page PDF containing:

1. Introduction, problem, and objective
2. Functional and cloud requirements
3. Architecture diagram and request flow
4. AWS service selection and excluded-service rationale
5. Terraform design and file structure
6. Security configuration
7. Deployment and installation procedure
8. Testing and evidence
9. Tutor feedback, changes, and critical reflection
10. Results, limitations, conclusion, and possible future improvements

Add a cover page, table of contents, figure captions, references, and appendix where required. Confirm with the tutor whether these pages count toward the requested 10-page description.

### Final code and documentation files

- [ ] `abstract.pdf`
- [ ] `final-documentation.pdf`
- [ ] `installation-manual.pdf`, or installation instructions incorporated into the final documentation
- [ ] `static-site/index.html`
- [ ] `terraform/main.tf`
- [ ] `terraform/variables.tf`
- [ ] `terraform/versions.tf`
- [ ] `terraform/outputs.tf`
- [ ] `.terraform.lock.hcl`, generated by `terraform init`
- [ ] `terraform/README.md`
- [ ] Final deployment and verification evidence
- [ ] Results from Portfolio Parts 1 and 2
- [ ] Electronic affidavit completed through myCampus

## Required verification evidence

- [ ] CloudFront website returns HTTP `200` over HTTPS
- [ ] HTTP redirects to HTTPS
- [ ] Response contains CloudFront-related headers
- [ ] CloudFront caching demonstrated where possible
- [ ] All four S3 Public Access Block settings are `true`
- [ ] Direct S3 origin request returns HTTP `403 Access Denied`
- [ ] CloudFront distribution status is `Deployed`
- [ ] `terraform validate` succeeds
- [ ] Post-deployment `terraform plan` reports no unexpected changes
- [ ] Terraform code contains no credentials
- [ ] Restricted code link is accessible to the tutor

## Explicit exclusions

Do not include the following in the submitted implementation:

- EC2 or ECS
- Docker or Docker Compose
- Lambda or API Gateway
- Databases or load balancers
- Route 53 or a custom domain
- A custom ACM certificate
- AWS WAF
- CI/CD services or configuration
- React or Node.js dependencies
- Backend application code

The rationale for these exclusions is documented in `terraform/README.md`.

## Final ZIP structure

```text
Surname-First_Name-Matriculation_CloudProgramming/
|-- 01-Research-and-Development/
|   |-- source-list.pdf
|   +-- research-notes.pdf
|-- 02-Conception-Phase/
|   |-- P1-concept.pdf
|   +-- architecture-diagram.png
|-- 03-Development-Phase/
|   |-- P2-presentation.pdf
|   |-- implementation-screenshots/
|   +-- first-code-draft/
+-- 04-Final-Phase/
    |-- abstract.pdf
    |-- final-documentation.pdf
    |-- installation-manual.pdf
    |-- final-source-code/
    |   |-- static-site/
    |   |   +-- index.html
    |   +-- terraform/
    |       |-- main.tf
    |       |-- variables.tf
    |       |-- versions.tf
    |       |-- outputs.tf
    |       |-- .terraform.lock.hcl
    |       +-- README.md
    +-- final-evidence/
```

## Files that must not be submitted

- `.terraform/`
- Terraform state files (`*.tfstate` and `*.tfstate.*`)
- Terraform plan files (`*.tfplan` or `tfplan`)
- `node_modules/` or React build files
- AWS access keys, secret keys, or session tokens
- Files containing credentials or private account data
- Unnecessary cache, temporary, or editor files
- The copyrighted assignment task PDF
- Work belonging to other students

## File naming

Use the current IU naming convention stated in the assignment brief. The performance-relevant phase submissions follow this general pattern:

```text
Kanaan-Mahmoud_92133250_Cloud Programming_P1_S.pdf
Kanaan-Mahmoud_92133250_Cloud Programming_P2_S.pdf
Kanaan-Mahmoud_92133250_Cloud Programming_P3_S.zip
```

Confirm the current naming requirements in PebblePad before submission.

## Final submission gate

- [ ] Incorporate all tutor feedback
- [ ] Replace `{SubmissionDate}` and `{TutorName}` everywhere they appear
- [ ] Open and inspect every submitted PDF
- [ ] Verify page counts and readable screenshots
- [ ] Test all hyperlinks and the restricted code link
- [ ] Extract the final ZIP into a temporary directory and open its contents
- [ ] Confirm that no credentials, state files, plan files, or excluded technologies are present
- [ ] Retest the live CloudFront URL
- [ ] Complete the electronic affidavit
- [ ] Submit through PebblePad/myCampus
- [ ] Keep AWS resources available until the tutor confirms they are no longer needed
- [ ] After assessment, run and review `terraform plan -destroy`, then run `terraform destroy`
- [ ] Confirm that the CloudFront distribution, Origin Access Control, S3 object versions, bucket policy, and S3 bucket have been removed
- [ ] Check AWS billing for unexpected continuing charges
