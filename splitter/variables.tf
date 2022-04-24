variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "project_values" {
  description = "Project values"
  type = object({
    project = string
    team    = string
    owner   = string
  })
  default = {
    project = "splitter"
    team    = "endurance"
    owner   = "joseph-cooper"
  }
}
