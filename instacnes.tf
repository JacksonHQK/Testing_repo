resource "aws_instance" "app1" {
  ami                     = "${var.aws_ami_windows}"
  instance_type           = "${var.app_inst_type}"
  subnet_id               = "${var.subnet_id}"
  key_name                = "${var.key_name}"
  vpc_security_group_ids  = "${var.security_groups_id}"
  monitoring = true
  count                   = "${var.ec2_instance_count}"
  user_data               = <<-EOF
                #!/bin/bash cd /tmp curl https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm -o amazon-ssm-agent.rpm yum install -y amazon-ssm-agent.rpm
                EOF
  iam_instance_profile    = "${aws_iam_instance_profile.ssm_ec2_role.name}"

  tags                    = "${local.common_tags_Windows}"
}

resource "aws_instance" "app2" {
  ami                     = "${var.aws_ami_linux}"
  instance_type           = "${var.app_inst_type}"
  subnet_id               = "${var.subnet_id}"
  key_name                = "${var.key_name}"
  vpc_security_group_ids  = "${var.security_groups_id}"
  monitoring = true
  count                   = "${var.ec2_instance_count}"
  user_data               = <<-EOF
                #!/bin/bash cd /tmp curl https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm -o amazon-ssm-agent.rpm yum install -y amazon-ssm-agent.rpm
                EOF
  iam_instance_profile    = "${aws_iam_instance_profile.ssm_ec2_role.name}"

  tags                    = "${local.common_tags_Linux}"
}
