module "s3-bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.14.0"
  bucket  = var.bucket_name
  tags    = var.s3_tag
}
