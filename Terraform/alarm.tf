/*locals {
  instance_ids = module.ec2-instance[*].id
  instance-gid = { for instance_id in local.instance_ids : instance_id => instance_id }

}

resource "aws_cloudwatch_metric_alarm" "cpu_alarm" {
  for_each = local.instance-gid
  alarm_name = "${data.aws_instances.example[each.value].tags.Name}-cpu"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This metric checks the disk usage"
  alarm_actions       = ["arn:aws:sns:us-east-1:175939439604:sample"]
  dimensions          = { InstanceId = each.value }
}

/*dimensions = {
    path    = "/"
    host    = "ip-${data.aws_instance.my_instance.private_ip}"
    device  = "nvme0n1p1"
    fstype  = "ext4"
  }*/


data "aws_instances" "example" {
  instance_tags = {
    "Name" = data.aws_instances.example[*].tags.Name
  }
}

locals {
  instance_ids   = module.ec2-instance[*].id
  instance_gids  = { for index, instance_id in local.instance_ids : index => instance_id }
  instance_names  = { for index, instance_id in local.instance_ids : index => data.aws_instances.example.instances[instance_id].tags.Name }
}

resource "aws_cloudwatch_metric_alarm" "cpu_alarm" {
  for_each            = local.instance_gids
  alarm_name          = "${local.instance_names[each.key]}-cpu}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This metric checks the disk usage"
  alarm_actions       = ["arn:aws:sns:us-east-1:175939439604:sample"]
  dimensions = {
    InstanceId = each.value.instance_id
  }
}


output "cpu_alarm_names" {
  value = aws_cloudwatch_metric_alarm.cpu_alarm[*].alarm_name
}
