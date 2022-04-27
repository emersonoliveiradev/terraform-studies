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
    project = "coda"
    team    = "endurance"
    owner   = "joseph-cooper"
  }
}

variable "instance_values" {
  description = ""
  type = map(
    object({
      instance_type   = string
      instance_number = number
      us-east-1       = string
    })
  )
  default = {
    sdx = {
      instance_type   = "t2.micro"
      instance_number = 1
      us-east-1       = "ami-0f260fe26c2826a3d"
    },
    stg = {
      instance_type   = "t2.micro"
      instance_number = 1
      us-east-1       = "ami-0f260fe26c2826a3d"
    },
    prd = {
      instance_type   = "t2.micro"
      instance_number = 1
      us-east-1       = "ami-0f260fe26c2826a3d"
    }
  }
}
