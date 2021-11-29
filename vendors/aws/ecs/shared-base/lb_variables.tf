variable "access_logs_bucket" {
    description = "s3 bucket name to send access logs to"
    default = ""
}

variable "access_logs_enabled" {
    description = "boolean to enable/disable sending access logs to s3 bucket"
    default = false
}

variable "access_logs_prefix" {
  description = "access log s3 key prefix"
  default = ""
}
