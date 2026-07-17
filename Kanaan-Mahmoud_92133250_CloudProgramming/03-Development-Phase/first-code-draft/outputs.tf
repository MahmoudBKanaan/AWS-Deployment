output "website_url" {
  description = "Public HTTPS URL of the CloudFront website."
  value       = "https://${aws_cloudfront_distribution.site.domain_name}"
}

output "cloudfront_domain_name" {
  description = "CloudFront distribution domain name."
  value       = aws_cloudfront_distribution.site.domain_name
}

output "cloudfront_distribution_id" {
  description = "CloudFront distribution ID."
  value       = aws_cloudfront_distribution.site.id
}

output "s3_bucket_name" {
  description = "Name of the private S3 origin bucket."
  value       = aws_s3_bucket.site.bucket
}

output "s3_origin_domain" {
  description = "Private S3 regional origin domain used for access-denied testing."
  value       = aws_s3_bucket.site.bucket_regional_domain_name
}
