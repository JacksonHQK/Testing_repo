output "ec2_ssm_output" {
  value       = "${aws_ssm_maintenance_window_target.scan_target_group.id}"
  description = "Target ID"
}
