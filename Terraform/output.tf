output "vpc_id" {
  value = module.VPC.vpc_id
}

output "vpc_public_subnets" {
  value = module.VPC.public_subnets
}

output "vpc_private_subnets" {
  value = module.VPC.private_subnets
}
output "sample01" {
  value = module.ec2-instance[0].public_ip
}
output "testserver" {
  value = module.ec2-instance[1].public_ip
}
output "instance_id" {
   value = [for instance in module.ec2-instance: instance.id]
}
/*output "instance_name"{
   value = [for instance in module.ec2-instance: instance.tags.Name]
}*/
output "sns_topic_arn" {
  value = aws_sns_topic.sample.arn
}
