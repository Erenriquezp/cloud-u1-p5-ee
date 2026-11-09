# cloud-u1-t4-windows-ee

Terraform: instancia Amazon EC2 con Windows Server 2025 + security group en `us-east-1` (tarea 4, réplica del taller 8).

## Uso
1. Iniciar el Learner Lab y configurar la CLI: `aws configure` (key, secret, **session token**, `us-east-1`).
2. `terraform init`
3. `terraform plan`
4. `terraform apply` y confirmar con `yes`.
5. Esperar unos 4 minutos a que Windows genere la contraseña.
6. En la consola de EC2: instancia → **Connect** → **RDP client** → **Download remote desktop file**.
7. **Get password** → subir `mi-segunda-llaves-ee.pem` → **Decrypt password**.
8. Abrir el `.rdp`, entrar como `Administrator` y pegar la contraseña.
9. `terraform destroy` al terminar (luego *End Lab*).

## Diferencias con el taller 8

| Parte | Taller 8 (Linux) | Tarea 4 (Windows) |
|---|---|---|
| AMI | ID fijo de Linux | Windows Server 2025 Base, buscada con `data "aws_ami"` |
| Tipo de instancia | `t2.micro` | `t3.medium` |
| Par de llaves | `mi-primera-llaves-ee` | `mi-segunda-llaves-ee` |
| Acceso remoto | SSH (22) | RDP (3389) |
| Salida del security group | Solo TCP 80 | Todo el tráfico |

## Qué se sube y qué no
- Sí: `main.tf`, `.gitignore`, `.gitattributes`, `README.md`, `.terraform.lock.hcl`.
- No: `.terraform/`, `*.tfstate*`, `*.tfvars`, llaves `.pem`, archivos `.rdp`.
