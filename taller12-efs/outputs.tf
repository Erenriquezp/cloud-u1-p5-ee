# Lo que imprimimos en la consola, que es lo que se va a mostrar al usuario al final de la ejecución del plan de terraform.
# Se imprime lo que no tenemos, por ejemplo la intance id

output "ids_intancias" {
  description = "IDs de las instancias creadas"
  value       = aws_instance.mi_instancia_efs[*].id
}

output "cantidad_instancias" {
  description = "Cantidad de instancias creadas"
  value       = length(aws_instance.mi_instancia_efs)
}

output "ip_publica_instancias" {
  description = "Dirección IP pública de las instancias"
  value       = aws_instance.mi_instancia_efs[*].public_ip
}

output "zonas_disponibilidad" {
  description = "Zonas de disponibilidad de las instancias"
  value       = aws_instance.mi_instancia_efs[*].availability_zone
}