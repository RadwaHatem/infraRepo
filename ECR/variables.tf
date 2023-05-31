variable "ecr_name" {
  type = any
  default = null
}

variable "image_mutability" {
  type = string
  default = "IMMUTABLE"

}

variable "encrypt_type" {
  type = string
  default = "KMS"
}

variable "tags" {
  type = map(string)
  default = {}
}