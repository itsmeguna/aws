/*data "aws_instances" "example" {
  for_each = { for i, ec2_instance in module.ec2-instance : i => ec2_instance }
  instance_tags = {
    "Name" = data.aws_instances.example[each.key].tags.Name
  }
}
*/

