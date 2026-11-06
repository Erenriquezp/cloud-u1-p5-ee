# cloud-u1-p5-ee

Terraform: instancia Amazon EC2 + security group en `us-east-1` (clase 06, taller 8).

## Uso
1. Iniciar el Learner Lab y configurar la CLI: `aws configure` (key, secret, **session token**, `us-east-1`).
2. `terraform init`
3. `terraform plan`
4. `terraform apply`
5. `terraform destroy` al terminar (luego *End Lab*).

## Qué se sube y qué no
- Sí: `main.tf`, `.gitignore`, `README.md`, `.terraform.lock.hcl` (si existe).
- No: `.terraform/`, `*.tfstate*`, `*.tfvars`, llaves `.pem`.
