# Configuracion del proveedor de AWS
provider "aws" {
  region = var.region
}


# Crear el Security Group
resource "aws_security_group" "mi-sg-efs-instancias" {
  name = "mi-security-group-terraform-efs-instancias" # Nombre
  description = "Security Group para mi instancia Terraform"
  vpc_id = "vpc-0a144b21b34dcee32"
  # Regla de entrada para SSH
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  # Permitir salida hacia el Security Group de EFS
  egress {
    from_port       = 2049
    to_port         = 2049
    protocol        = "tcp"
    security_groups = [aws_security_group.mi-sg-terraform-efs.id]
  }
}


# Crear el segundo Security Group
resource "aws_security_group" "mi-sg-terraform-efs" {
  name = "mi-security-group-terraform-efs" # Nombre
  description = "Security Group para mi instancia Terraform"
  vpc_id = "vpc-0a144b21b34dcee32"
  # Permitir NFS únicamente desde las instancias autorizadas
  ingress {
    from_port = 2049
    to_port = 2049
    protocol = "tcp"
    security_groups = [aws_security_group.mi-sg-efs-instancias.id]
  }

  # Permitir salida hacia cualquier destino
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


# Declaracion de los recursos AWS
resource "aws_instance" "mi_instancia_efs" {
  ami = var.ami_id
  instance_type = var.tipo_instancia
  key_name = var.nombre_llave
  security_groups = [aws_security_group.mi-sg-efs-instancias.name]
  count = var.cantidad_instancias
  tags = {
    Name = "Mi Instancia EFS Terraform-${count.index + 1}" # Etiqueta para identificar la instancia
  }
  vpc_security_group_ids = [aws_security_group.mi-sg-efs-instancias.id] # Asignar el Security Group
}