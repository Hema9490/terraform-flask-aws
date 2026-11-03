variable "aws_region" {
  description = "AWS region to deploy in (ap-southeast-2 = Sydney)"
  type        = string
  default     = "ap-southeast-2"
}

variable "instance_type" {
  description = "EC2 size. Pick a free-tier eligible type shown in your AWS account."
  type        = string
  default     = "t3.micro"
}

variable "project_name" {
  description = "Name prefix for created resources"
  type        = string
  default     = "terraform-flask-aws"
}