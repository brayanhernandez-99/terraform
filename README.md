# Terraform pasos iniciales

| Pasos                      | Mac                                      | Windows                             |
| -------------------------- | ---------------------------------------- | ----------------------------------- |
| Instalar Terraform         | `brew install hashicorp/tap/terraform`   | `choco install terraform` o manual  |
| Instalar VS Code           | `brew install --cask visual-studio-code` | `Descarga manual`                   |
| Instalar AWS CLI           | `brew install awscli`                    | `Instalador oficial`                |
| Configurar AWS CLI         | `aws configure`                          | `aws configure`                     |
| Iniciar proyecto Terraform | `terraform init`, `terraform apply`      | `terraform init`, `terraform apply` |

---

## 1. Instalar Terraform

**▶️ En Mac (usando Homebrew):**

```bash
- brew tap hashicorp/tap
- brew install hashicorp/tap/terraform

# Verificar instalación (bash/shell):
- terraform version
```

**▶️ En Windows (usando Chocolatey o manualmente):**

```powershell
# Si tienes Chocolatey instalado:
- choco install terraform

# Si no lo tienes instalado (Chocolatey):
  1. Ve a la página oficial de Terraform https://developer.hashicorp.com/terraform/downloads
  2. Descarga el ZIP para Windows.
  3. Extrae el ejecutable `terraform.exe`.
  4. Añade la carpeta donde está `terraform.exe` al PATH del sistema.

# Verificar instalación (powershell):
- terraform version
```

---

## 2. Instalar un editor de código

**Recomendado:** Visual Studio Code (VS Code) en ambos sistemas.

**▶️ En Mac:**

```bash
# Si no lo tienes instalado:
- brew install --cask visual-studio-code
```

**▶️ En Windows:**

```powershell
# Descarga el instalador desde: Visual Studio Code Download https://code.visualstudio.com/Download
- Luego:
  - Abre VS Code.
  - Instala la extensión "HashiCorp Terraform" desde el Marketplace.
```

---

## 3. Configurar el Proveedor de Infraestructura (AWS, Azure, GCP)

Terraform trabaja con _providers_ para manejar diferentes plataformas.

```hcl
provider "aws" {
  region = "us-east-1"
}
```

> Nota: Antes de usar el provider debes autenticarte.

---

## 4. Autenticación en el Proveedor (AWS)

**▶️ En Mac:**

```bash
# Instalar AWS CLI:
- brew install awscli

# Configurar credenciales:
- aws configure
```

> Nota: Te pedirá Access Key ID, Secret Access Key, región y formato de salida.

**▶️ En Windows:**

```powershell
## Instala AWS CLI para Windows: https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-windows.html
- aws configure
```

---

## Ejemplo Proyecto Terraform

1. Crea un archivo llamado `main.tf` con el siguiente contenido:

```hcl
provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "mi_primer_bucket" {
  bucket = "mi-bucket-de-prueba-terraform"
  acl    = "private"
}
```

2. Ejecuta los siguientes comandos en la carpeta donde esté el `main.tf`:

```bash
- terraform init     # Inicializa el proyecto
- terraform plan     # Muestra el plan de ejecución
- terraform apply    # Aplica la infraestructura
```
