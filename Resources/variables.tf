variable "VPC_CIDR" {
  type = string
}

variable "COMPANY_NAME" {
  type = string
}

variable "PUBLIC_SUBNET_1_CIDIR" {
  type = string
}

variable "PUBLIC_SUBNET_2_CIDIR" {
  type = string
}

variable "PRIVATE_SUBNET_2_CIDIR" {
  type = string
}

variable "PRIVATE_SUBNET_1_CIDIR" {
  type = string
}

variable "AZ_1" {
  type = string
}


variable "AZ_2" {
  type = string
}

variable "REGION" {
  type = string
}

variable "AMI_ID" {
  type = string
}

variable "INSTANCE_TYPE" {
    type = string
}

variable "ECR_NAME" {
  type = list(string)
  default = [ "null" ]
}

variable "TAGS" {
  type = map(string)
  default = {}
}

variable "IMAGE_MUTABILITY" {
  type = string
  default = "MUTABLE"
}

variable "ENCRYPT_TYPE" {
  type = string
  default = "KMS"
}

variable "ACCESS_KEY" {
  type = string
}

variable "SECRET_ACCESS_KEY" {
  type = string
}



