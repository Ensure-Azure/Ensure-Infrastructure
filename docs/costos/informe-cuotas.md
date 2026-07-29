# Informe de Cuotas — Centinela

**Región:** East US
**Fecha:** 23 de julio de 2026
**Responsable:** Julio (Seguridad, QA y Documentación)

## 1. Capacidad de cómputo

| Recurso | Límite | En uso | Disponible |
|---|---|---|---|
| Total Regional vCPUs | 4 | 0 | 4 |
| Dedicated vCPUs | 0 | 0 | No aplica — no se requiere para este proyecto |

## 2. Almacenamiento (Storage)

| Recurso | Límite | En uso | Disponible |
|---|---|---|---|
| Standard Storage | 50,000 | 0 | 50,000 |
| Premium Storage | 50,000 | 0 | 50,000 |
| StandardSSD/StandardSSDS | 50,000 | 0 | 50,000 |
| UltraSSD Storage | 1,000 | 0 | 1,000 |
| Premium V2 Storage | 1,000 | 0 | 1,000 |

## 3. Document Intelligence

- Disponible en East US: **Sí**
- Es el único servicio de inteligencia artificial usado en el proyecto (verificación documental en semana 3).

## 4. Servicios con cuota en cero relevantes

Ninguno que afecte el diseño de Centinela. "Dedicated vCPUs" muestra 0, pero corresponde a hosting dedicado empresarial, no requerido por este proyecto.

## Conclusión

La región East US tiene capacidad suficiente en cómputo, almacenamiento y el servicio de reconocimiento documental para soportar la arquitectura planeada de Centinela en las semanas 1, 2 y 3. No se identifican bloqueos que condicionen decisiones de arquitectura.

## Nota pendiente
Confirmar formalmente con el equipo que **East US** es la región oficial adoptada — esta verificación se basó en la ubicación real de un recurso desplegado (VM), no en una decisión documentada previamente.