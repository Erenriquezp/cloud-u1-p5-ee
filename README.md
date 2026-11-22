# cloud-u1-p5-ee

Talleres de Terraform en AWS (`us-east-1`), uno por carpeta. Computación Grid y Cloud, U1.

| Carpeta | Taller | Qué crea |
|---|---|---|
| [`taller8-ec2/`](taller8-ec2/main.tf) | 8 (2026-11-05) | Una instancia EC2 y un security group (SSH 22 y HTTP 80 de entrada, HTTP 80 de salida) |
| [`taller12-efs/`](taller12-efs/main.tf) | 12 (2026-11-17) | Dos instancias EC2 (`count`) y dos security groups para Amazon EFS: el de las instancias (SSH 22 y HTTP 80 de entrada, NFS 2049 hacia el SG del EFS) y el del EFS (NFS 2049 solo desde el SG de las instancias). Usa `variables.tf` y `outputs.tf` |

La tarea 4 (instancia Windows) está en la rama [`tarea-4-windows`](../../tree/tarea-4-windows).

## Uso
1. Iniciar el Learner Lab y configurar la CLI: `aws configure` (key, secret, **session token**, `us-east-1`).
2. Entrar a la carpeta del taller: `cd taller12-efs`
3. `terraform init`
4. `terraform plan`
5. `terraform apply`
6. `terraform destroy` al terminar (luego *End Lab*).

Cada carpeta es un proyecto aparte con su propio estado.

## Qué se sube y qué no
- Sí: los `.tf`, `.terraform.lock.hcl`, `.gitignore`, `README.md`.
- No: `.terraform/`, `*.tfstate*`, `*.tfvars`, llaves `.pem`, `notas/`.
