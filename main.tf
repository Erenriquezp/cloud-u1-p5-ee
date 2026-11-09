# Configuracion del proveedor de AWS
provider "aws" {
  region = "us-east-1" # Region donde se desplegaran los recursos
}

# Buscar la AMI mas reciente de Windows Server 2025 Base publicada por Amazon
data "aws_ami" "windows" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["Windows_Server-2025-English-Full-Base-*"]
  }
}

# Crear el Security Group
resource "aws_security_group" "mi-sg-windows" {
  name        = "mi-security-group-windows"
  description = "Security Group para mi instancia Windows con Terraform"
  vpc_id      = "vpc-0a144b21b34dcee32"

  # Regla de entrada para RDP (escritorio remoto)
  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Regla de entrada para HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Regla de salida: todo el trafico (Windows necesita DNS y HTTPS)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Declaracion de la instancia Windows
resource "aws_instance" "mi_instancia_windows" {
  ami           = data.aws_ami.windows.id # Windows Server 2025 Base
  instance_type = "t3.medium"             # Tipo usado en el taller 3
  key_name      = "mi-segunda-llaves-ee"  # Par de llaves para descifrar la contrasena

  tags = {
    Name = "MiInstanciaWindowsTerraform" # Etiqueta para identificar la instancia
  }

  vpc_security_group_ids = [aws_security_group.mi-sg-windows.id] # Asignar el Security Group
}

# Datos para conectarse por RDP al terminar el apply
output "instance_id" {
  value = aws_instance.mi_instancia_windows.id
}

output "public_dns" {
  value = aws_instance.mi_instancia_windows.public_dns
}
