variable "use_localstack" {
  description = "value to determine if localstack is being used"
  type = bool
  default     = true
}

variable "aws_region" {
  description = "value to determine the region to deploy to"
  type = string
  default     = "us-east-1"
}