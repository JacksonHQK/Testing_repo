// S3 Bucket For Logs
resource "aws_s3_bucket" "ssm_log_bucket" {
  bucket        = "${var.ssm_logs_bucket_name}-ssm-patch-logs"
  force_destroy = true

  tags {
    Name        = "${var.ssm_logs_bucket_name}"
    Environment = "${var.patch_operating_system}"
  }
}
data "aws_region" "current" {}