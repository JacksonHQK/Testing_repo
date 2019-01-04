resource "aws_ssm_patch_group" "scan_patch_group" {
  baseline_id = "${aws_ssm_patch_baseline.scan_patch_baseline.id}"
  patch_group = "${var.patching_group_name}"
}


resource "aws_ssm_patch_baseline" "scan_patch_baseline" {
  name        = "${var.patching_group_name}"
  description = "Patch Baseline for Windows"
  operating_system = "${var.patch_operating_system}"

  approval_rule {
    approve_after_days = "${var.auto_approval_delay}"
    compliance_level   = "${var.compliance_level_approval}"

    patch_filter {
      key    = "PRODUCT"
      values = "${var.product_approval_rule}"
    }

    patch_filter {
      key    = "CLASSIFICATION"
      values = "${var.classification_approval_rule}"
    }

    patch_filter {
      key    = "MSRC_SEVERITY"
      values = "${var.severity_approval_rule}"
    }
  }
}
