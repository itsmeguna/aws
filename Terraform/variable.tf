#Region_variable
variable "region" {
  description = "Region"
  type        = string
  default     = ""
}
#VPC_variable
variable "VPC" {
  description = "VPC"
  type        = string
  default     = ""
}

variable "VPC_cidr" {
  description = "VPC_cidr_range"
  type        = string
  default     = ""

}

variable "VPC_az" {
  description = "AZs of VPC"
  type        = list(string)
  default     = []
}

variable "Private_subnet" {
  description = "List of public subnrt"
  type        = list(string)
  default     = []
}

variable "Public_subnet" {
  description = "List of Private subnet"
  type        = list(string)
  default     = []
}

variable "public_subnet_tag" {
  description = "tags for public subnet"
  type        = map(string)
  default     = {}
}

variable "private_subnet_tag" {
  description = "tags for private subnet"
  type        = map(string)
  default     = {}
}

variable "VPC_Tag" {
  description = "Tags for VPC"
  type        = map(string)
  default     = {}
}
#S3_bucket
variable "bucket_name" {
  description = "Bucket Name"
  type        = string
  default     = ""
}

variable "bucket_Key" {
  description = "Bucket_Key"
  type        = string
  default     = ""
}

variable "s3_tag" {
  description = "tag for the s3"
  type        = map(string)
  default     = {}
}
#EC2_variables
/*variable "ec2_instance_count" {
  description = "Multiple_EC2"
  type        = number
}*/
variable "instance_name" {
  description = "name of the instance"
  type        = list(string)
  default     = []
}

variable "instance_type" {
  description = "instance type"
  type        = string
  default     = ""
}

variable "ami" {
  description = "ami"
  type        = string
  default     = ""
}

variable "ec2_tags" {
  description = "tag for ec2"
  type        = map(string)
  default     = {}
}
variable "db_count" {
  description = "count for db"
  type        = number
}

variable "ec2_db_name" {
  description = "name for db"
  type        = map(string)
  default     = {}
}

variable "key_name" {
  description = "Key for ec2_instance"
  type        = string
  default     = ""
}

#security_group_variable
variable "SG" {
  description = "SecurityGroup"
  type        = list(string)
  default     = []
}

variable "SG_tag" {
  description = "Tag for security group"
  type        = map(string)
  default     = {}
}
#SNS 
 variable "SNS_topic_name" {
   description = "sns topic name "
   type= string
 }

#cloudwatchAlarm-CPU
