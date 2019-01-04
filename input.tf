variable "ssm_logs_bucket_name" {
  description = "name of S3 log bucket"
  default     = "hqk-ssm-logs-bucket-name"
}

variable "patch_operating_system" {
  description = "Enviroment [in CAPITAL]"
  default     = "WINDOWS"
}

variable "aws_ami_windows" {
  description = "AMIs"
  default     = "ami-03b3182648d0d0bfb"
}

variable "aws_ami_linux" {
  description = "AMIs"
  default     = "ami-08589eca6dcc9b39c"
}

variable "app_inst_type" {
  description = "AMIs"
  default     = "t2.micro"
}

variable "ec2_instance_count" {
  description = "Number of created EC2 instances"
  default     = "1"
}

variable "subnet_id" {
  description = "Subnet_ID"
  default     = "subnet-64b38103"
}

variable "key_name" {
  description = "keypair_name"
  default     = "instance_keypair_07112018"
}

variable "security_groups_id" {
  description = "security_groups_id"
  type    = "list"
  default = ["sg-0095eb5df98a46245","sg-04b2d5062ea6ecc46"]
}

variable "maintenance_window_name" {
  description = "Name of the test Maintenance Window"
  default = "mytest_Maintenance_Window"
}

variable "cron_schedule" {
  default     = "/10 * * * ? *"
  description = "Cron scheduler for the maintenance window (in form: '0 0 1 * * ?'). Default: 12am, every Sunday"
//  https://docs.aws.amazon.com/systems-manager/latest/userguide/reference-cron-and-rate-expressions.html#reference-cron-and-rate-expressions-intro
}

variable "window_duration" {
  description = "Duration of Maintenance Window in hours"
  default = "8"
}

variable "window_cutoff" {
  description = "Number of hour before the end of Maintenance Window that the system should stop scheduling new task for execution"
  default = "1"
}

variable "patching_group_name" {
  description = "Name of the patching group"
  default = "Custome-PatchBaselineWindow"
}

variable "max_concurrency" {
  description = "Maximum number of executed instances"
  default = "1"
}

variable "max_errors" {
  description = "Maximum number of error instances"
  default = "1"
}

variable "priority" {
  description = "Name of the patching group"
  default = "Window"
}

variable "auto_approval_delay" {
  description = "No. of delay days before approving"
  default = "0"
}

variable "compliance_level_approval" {
  description = "Compliance Level [in CAPITAL]"
  default = "CRITICAL"
}

variable "product_approval_rule" {
  description = "Product Approval Rules: Windows version"
  type    = "list"
  default = ["WindowsServer2016"]
}

variable "classification_approval_rule" {
  description = "Classification Approval Rule: CriticalUpdates/DefinitionUpdates/Drivers"
  type    = "list"
  default = ["CriticalUpdates"]
}

variable "severity_approval_rule" {
  description = "Severity Approval Rule: Critical/Important/Low/Moderate/Unspecified"
  type    = "list"
  default = ["Critical"]
}


locals {
  common_tags_Windows = {
    Name          = "Windows managed instance"
    "Patch Group" = "${var.patching_group_name}"
    Platform      = "windows"
  }

  common_tags_Linux = {
    Name          = "Linux managed instance"
    "Patch Group" = "${var.patching_group_name}"
    Platform      = "linux"
  }

}