#----------------------Set up maintenance window
resource "aws_ssm_maintenance_window" "scan_maintenance_window" {
  name     = "${var.maintenance_window_name}"
  schedule = "cron(${var.cron_schedule})"
  duration = "${var.window_duration}"
  cutoff   = "${var.window_cutoff}"
}

#-----------------------Assign target for the window
resource "aws_ssm_maintenance_window_target" "scan_target_group" {
  window_id     = "${aws_ssm_maintenance_window.scan_maintenance_window.id}"
  resource_type = "INSTANCE"

  targets {
    key    = "tag:Patch Group"
    values = ["${var.patching_group_name}"]
  }
}

#-----------------------Assign a task to your target
resource "aws_ssm_maintenance_window_task" "scan_maintenance_task" {
  window_id        = "${aws_ssm_maintenance_window.scan_maintenance_window.id}"
  name             = "scan-maintenance-window-task"
  description      = "This is a maintenance window task - scanning Windows server"
  task_type        = "RUN_COMMAND"
  task_arn         = "AWS-RunPatchBaseline"
  service_role_arn = "${aws_iam_role.maintenance_window_role.arn}"
  max_concurrency  = "${var.max_concurrency}"
  max_errors       = "${var.max_errors}"
  priority         = 1

  targets {
    key    = "WindowTargetIds"
    values = ["${aws_ssm_maintenance_window_target.scan_target_group.id}"]
  }

  task_parameters {
    name   = "Operation"  //"Operation"
    values = ["Install"]     //"Install/Scan"
  }

  logging_info {
    s3_bucket_name = "${aws_s3_bucket.ssm_log_bucket.id}"
    s3_region      = "${data.aws_region.current.name}"
  }
}

//resource "aws_ssm_maintenance_window_task" "task_scan_patches" {
//  window_id        = "${aws_ssm_maintenance_window.scan_window.id}"
//  task_type        = "RUN_COMMAND"
//  task_arn         = "AWS-ApplyPatchBaseline"
//  priority         = 1
//  service_role_arn = "${aws_iam_role.ssm_maintenance_window.arn}"
//  max_concurrency  = "${var.max_concurrency}"
//  max_errors       = "${var.max_errors}"
//
//  targets {
//    key    = "WindowTargetIds"
//    values = ["${aws_ssm_maintenance_window_target.target_scan.*.id}"]
//  }
//
//
//
//  task_parameters {
//    name   = "Operation"
//    values = ["Scan"]
//  }
//
//  logging_info {
//    s3_bucket_name = "${aws_s3_bucket.ssm_patch_log_bucket.id}"
//    s3_region      = "${var.aws_region}"
//  }
//}
