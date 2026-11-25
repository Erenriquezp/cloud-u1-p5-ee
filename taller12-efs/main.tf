# Configuracion del proveedor de AWS
provider "aws" {
  region = var.region
}

# Crear el Security Group
resource "aws_security_group" "mi-sg-efs-instancias-14" {
  name = "mi-security-group-terraform-efs-instancias" # Nombre
  description = "Security Group para mi instancia Terraform"
  vpc_id = "vpc-0a144b21b34dcee32"
}

# Crear el segundo Security Group
resource "aws_security_group" "mi-sg-efs-14" {
  name = "mi-security-group-terraform-efs" # Nombre
  description = "Security Group para mi instancia Terraform"
  vpc_id = "vpc-0a144b21b34dcee32"
}

# Reglas SG Instancias
# Entrada
# SSH
resource "aws_vpc_security_group_ingress_rule" "entrada_ssh_intancias" {
  security_group_id = aws_security_group.mi-sg-efs-instancias-14.id
  ip_protocol = "tcp"
  from_port = 22
  to_port = 22
  cidr_ipv4 = "0.0.0.0/0"
}

# Salida
# EFS 2049
resource "aws_vpc_security_group_egress_rule" "salida-efs" {
  security_group_id = aws_security_group.mi-sg-efs-instancias-14.id
  ip_protocol = "tcp"
  from_port = 2049
  to_port = 2049
  referenced_security_group_id = aws_security_group.mi-sg-efs-14.id
}

# Internet
resource "aws_vpc_security_group_egress_rule" "salida-internet" {
  security_group_id = aws_security_group.mi-sg-efs-instancias-14.id
  ip_protocol = "-1"
  from_port = 0
  to_port = 0
  cidr_ipv4 = "0.0.0.0/0"
}

# Reglas SG EFS
# Entrada
# EFS
resource "aws_vpc_security_group_ingress_rule" "entrada-efs" {
  security_group_id = aws_security_group.mi-sg-efs-14.id
  ip_protocol = "tcp"
  from_port = 2049
  to_port = 2049
  # Destino
  referenced_security_group_id = aws_security_group.mi-sg-efs-instancias-14.id
}

# Salida
# No se requiere reglas de salida


# Declaracion de los recursos AWS
