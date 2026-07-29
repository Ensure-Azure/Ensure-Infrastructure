# Centinela Infrastructure

Repositorio encargado de gestionar y automatizar la infraestructura de Azure utilizada por el proyecto Centinela.

La infraestructura se administra mediante scripts versionados y Azure CLI.

---

# Objetivo

Este repositorio permite:

- Configurar el entorno de Azure.
- Desplegar la infraestructura.
- Verificar el estado de los recursos.
- Apagar recursos cuando no estén en uso.
- Destruir el entorno para realizar pruebas de reconstrucción.

---

# Requisitos

Antes de ejecutar los scripts se requiere:

- Git
- Azure CLI
- Bash
- Una suscripción activa de Azure
- Permisos suficientes sobre la suscripción

Verificar Azure CLI:

```bash
az --version
```

## ¿Como Empezar?

Inicia Sesión
```
az login
```

Ver las suscripciones disponibles:

```
az account set --subscription "<SUBSCRIPTION_ID>"
```

