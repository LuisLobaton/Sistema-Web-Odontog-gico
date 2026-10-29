# Infraestructura como Código - Sistema de Citas Odontológicas

## 1. Descripción del proyecto

Infraestructura en AWS definida mediante Terraform para un sistema web de citas y gestión odontológica del Centro Dental San José, ubicado en Trujillo, Perú.

El objetivo es contar con una infraestructura organizada, segura y preparada para soportar el crecimiento de usuarios.

## 2. Tecnologías utilizadas

- AWS
- Terraform
- Amazon VPC
- Amazon EC2
- EC2 Auto Scaling
- Amazon RDS
- PostgreSQL
- Security Groups

## 3. Arquitectura prevista

La infraestructura contempla:

- Una VPC con direccionamiento privado.
- Dos subredes públicas en distintas zonas de disponibilidad.
- Dos subredes privadas para los componentes internos.
- Internet Gateway y tabla de rutas públicas.
- Instancias EC2 para el backend.
- Auto Scaling para ajustar la capacidad del backend.
- Amazon RDS PostgreSQL con configuración Multi-AZ.
- Grupos de seguridad para controlar el tráfico de red.
- Tenemos en cuenta que el balanceador de carga, los permisos IAM y otros componentes todavía deben completarse.

## 4. Puertos utilizados

- Puerto 443: para las conexiones HTTPS hacia el balanceador de carga.
- Puerto 3000: para la comunicación entre el balanceador y el backend desarrollado en Node.js.
- Puerto 5432: para la conexión del backend con PostgreSQL.

La base de datos estará en una subred privada y no tendrá acceso público. Las reglas de seguridad deben permitir únicamente las conexiones necesarias entre los componentes.

## 5. Archivos Terraform

- `main.tf`: VPC, subredes, Internet Gateway y rutas.
- `variables.tf`: variables configurables.
- `security_groups.tf`: grupos de seguridad.
- `compute.tf`: plantilla EC2 y Auto Scaling.
- `database.tf`: base de datos PostgreSQL.
- `outputs.tf`: valores de salida.

## 6. Comprobación de la configuración

Para ordenar el formato de los archivos:

```bash
terraform fmt
```

Para comprobar la configuración:

```bash
terraform validate
```

Para preparar el directorio de trabajo y descargar los proveedores necesarios:

```bash
terraform init
```

## 7. Despliegue de la infraestructura

Antes de crear los recursos en AWS, se debe revisar la configuración de red,
 las reglas de seguridad, los permisos y los costos de los servicios.

Cuando la configuración esté completa y revisada, se podrá comprobar el plan 
de Terraform antes de decidir si se realiza el despliegue.

## 8. Eliminación de recursos

Si se realizan pruebas en AWS, se debe comprobar qué recursos se han creado y 
si alguno continúa generando costos.

Cuando ya no se necesite la infraestructura de prueba, se podrá utilizar 
`terraform destroy` para eliminar los recursos administrados por Terraform. 
Antes de hacerlo, se debe revisar qué se eliminará y guardar cualquier información necesaria.