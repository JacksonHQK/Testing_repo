#------Create an IAM role callded "ec2_role_for_ssm" and attached a policy
resource "aws_iam_role" "ec2_role_for_ssm" {
  name = "mytest_MaintanceWindowRole"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

#------Attach AmazonEC2RoleforSSM policy into ec2_role_for_ssm
resource "aws_iam_role_policy_attachment" "ec2_role_for_ssm" {
  role       = "${aws_iam_role.ec2_role_for_ssm.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}

#------------Provides an IAM instance profile called ssm_ec2_role
resource "aws_iam_instance_profile" "ssm_ec2_role" {
  name = "mytest_ManagedInstanceRoleforSSM"
  role = "${aws_iam_role.ec2_role_for_ssm.name}"
}

#-------Create IAM role called "maintenance_window_role"
resource "aws_iam_role" "maintenance_window_role" {
  name = "mytest_maintenance_window_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "ec2.amazonaws.com",
          "ssm.amazonaws.com"
        ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "maintenance_window_role" {
  role       = "${aws_iam_role.maintenance_window_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonSSMMaintenanceWindowRole"
}

