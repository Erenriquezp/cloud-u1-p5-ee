# Define un conjunto de variables para ser ingresado por el usuario en el archivo de variables.tf
# Region donde se desplegarán los recuros
variable "region" {
  description = "The AWS region"
  type        = string
  default     = "us-east-1"
}

variable "ami_id" {
  description = "The AMI ID to use for the EC2 instance"
  type        = string
  default     = "ami-00f43ee0e98d52529"
}

variable "tipo_instancia" {
  description = "The instance type for the EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "nombre_llave" {
  description = "The name of the key pair"
  type        = string
  default     = "mi-primera-llaves-ee"
}

variable "cantidad_instancias" {
  description = "The number of EC2 instances to create"
  type        = number
  default     = 2
}