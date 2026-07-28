# deploy.sh

Es el comando:

"Quiero crear o desplegar el entorno de Centinela."
Su flujo sería:

deploy.sh
   │
   ├── Cargar configuración
   │
   ├── Validar Azure CLI
   │
   ├── Validar login
   │
   ├── Seleccionar suscripción
   │
   ├── Crear Resource Group
   │
   ├── Crear red
   │
   ├── Crear Storage
   │
   ├── Crear Queue
   │
   ├── Crear Identity
   │
   └── Crear aplicación
   │
   ▼
Infraestructura lista

Aquí es donde se coordina todo.

# verify.sh

Este significa:

"Comprueba que el entorno está correctamente desplegado."


Su función es comprobar cosas como:

Resource Group
      │
      ├── ¿Existe?
      │
      ▼
VNet
      │
      ├── ¿Existe?
      │
      ▼
Subnets
      │
      ├── ¿Existen?
      │
      ▼
Storage
      │
      ├── ¿Existe?
      │
      ▼
Queue
      │
      ├── ¿Existe?
      │
      ▼
Managed Identity
      │
      └── ¿Existe?

Podríamos tener:

./scripts/verify.sh

Y obtener:

=================================
CENTINELA INFRASTRUCTURE VERIFY
=================================

[OK] Azure authentication
[OK] Subscription
[OK] Resource Group
[OK] Virtual Network
[OK] App Subnet
[OK] Data Subnet
[OK] Storage Account
[OK] Blob Container
[OK] Queue
[OK] Managed Identity

Infrastructure verification completed.

El verify.sh también puede usar funciones de lib/.

Por ejemplo:

source ./lib/common.sh
source ./lib/network.sh
source ./lib/storage.sh

Y luego:

verify_resource_group
verify_network
verify_storage

# shutdown.sh

Su objetivo es:

Apagar recursos que estén generando costos, pero mantener la infraestructura.

Ejecutas:

./scripts/shutdown.sh

La idea es:

ANTES

Azure
│
├── App Service       RUNNING
├── Storage            ACTIVE
├── Queue              ACTIVE
└── Network            ACTIVE

Después:

DESPUÉS

Azure
│
├── App Service       STOPPED
├── Storage            EXISTE
├── Queue              EXISTE
└── Network            EXISTE

Es decir:

shutdown
    │
    ▼
No destruye la infraestructura
    │
    ▼
Reduce costos cuando sea posible

Esto es importante porque shutdown no significa eliminar.

Por ejemplo:

az webapp stop

puede detener una aplicación.

Pero:

az group delete

elimina el entorno.

# destroy.sh

Este es el comando destructivo.

Significa:

"Elimina completamente el entorno."

Se ejecutaría:

./scripts/destroy.sh

Y podría eliminar:

Resource Group
    │
    ├── VNet
    ├── Subnets
    ├── Storage
    ├── Queue
    ├── Identity
    └── App Service

Por eso debe tener mucho cuidado.