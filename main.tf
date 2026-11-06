# Configuracion del proveedor de AWS
provider "aws" {
  region = "us-east-1" #region donde se desplegaran los recursos
}

# Crear el Security Group
resource "aws_security_group" "mi-sg" {
  name = "mi-security-group" # Nombre
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
  # Regla de salida para HTTP
  egress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
}

# Declaracion de los recursos AWS
resource "aws_instance" "mi_instancia_2" {
  ami = "ami-0c230065b91270bc6" # ID de la imagen 
  instance_type = "t2.micro" # Tipo
  key_name = "mi-primera-llaves-ee" # Nombre del par de llaves
  tags = {
    Name = "MiInstanciaTerraform2" # Etiqueta para identificar la instancia
  }
  vpc_security_group_ids = [ aws_security_group.mi-sg.id ] # Asignar el Security Group
}