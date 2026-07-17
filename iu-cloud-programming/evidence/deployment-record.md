# Deployment Record

- Deployment date: 2026-07-17
- AWS region: `eu-central-1`
- Website URL: https://d216eikm4r4k38.cloudfront.net
- CloudFront distribution ID: `EZW53YPRFUFEA`
- CloudFront status: `Deployed`
- HTTPS verification: `200 OK`
- Content type: `text/html; charset=utf-8`

The website is served through Amazon CloudFront from the private Amazon S3 origin provisioned by Terraform.

## Live verification

- HTTPS response: `HTTP/1.1 200 OK`
- CloudFront headers: `X-Cache`, `Via`, `X-Amz-Cf-Pop`, and `X-Amz-Cf-Id` present
- HTTP-to-HTTPS redirect: `HTTP/1.1 301 Moved Permanently`
- Redirect target: `https://d216eikm4r4k38.cloudfront.net/`
- S3 Public Access Block: all four settings are `true`
- Direct S3 object request: `HTTP/1.1 403 Forbidden`
- CloudFront distribution status: `Deployed`
- Cache verification: four consecutive requests returned `X-Cache: Hit from cloudfront`
