# Video y entrega individual

Autor: Axel Enrique Vasquez Peña · Matricula: 20242388.

El video debe ser una demostracion real realizada por el estudiante. Duracion maxima: 10 minutos. Mostrar fecha y hora, cara y voz. No dedicar tiempo a instalar o configurar desde cero.

## Guion sugerido: 9 minutos y 30 segundos

| Tiempo | Demostracion |
|---|---|
| 0:00-0:35 | Identificacion, matricula, fecha y hora; mostrar la cara y explicar el objetivo |
| 0:35-1:10 | Topologia GNS3 y direccionamiento 192.168.88.0/24 |
| 1:10-2:00 | SRV1: grupos y usuarios AD; servicios NTDS, DNS e IAS; clientes y politicas NPS |
| 2:00-3:50 | R1: usuarios 0, 5 y 10, show privilege y comandos permitidos/bloqueados |
| 3:50-5:40 | SW1: mismas pruebas; sin enable en las pruebas de permisos |
| 5:40-6:35 | Acceso fallido y eventos 6272/6273; explicar politica y cliente |
| 6:35-7:50 | NPS detenido: respaldo adminlocal en ambos equipos; restaurar IAS y comprobar Running |
| 7:50-8:50 | SSHv2, lineas consola/AUX/VTY, logs AAA y RADIUS capturados; apagar cualquier debug |
| 8:50-9:30 | Mostrar repositorio y archivos; cerrar explicando resultados y limites |

Ensayar antes. No mostrar contrasenas, claves compartidas, hashes ni XML privado en el video. Usar show ip ssh para acreditar el servicio; aclarar que el acceso por VTY esta bloqueado. Presentar AUX como configurado, no como probado.

## Publicacion

1. Subir el video a YouTube y comprobar que el docente puede abrirlo.
2. Reemplazar la primera linea del README por el enlace real del video.
3. Incorporar capturas nuevas de la red final y el XML NPS publico despues de revisarlo.
4. Codigo confirmado: A2. Autor: Axel Enrique Vasquez Peña.
5. Crear el TXT con nombre AxelEnriqueVasquezPena_20242388_A2.txt, usando el nombre y el codigo confirmados.

Contenido del TXT:

```text
Repositorio: https://github.com/axelenriquevasquezpena-max/seguridad-redes-20242388
Video: https://youtu.be/5hFR0Tdk6CM
```

## Pendientes actuales

- Codigo de asignacion confirmado: A2.
- Video proporcionado por el autor y enlazado: https://youtu.be/5hFR0Tdk6CM. Contenido y duracion no auditados.
- XML NPS publico final no aportado para revision.
- Capturas finales de privilegios, eventos y respaldo en la nueva red pendientes.

El repositorio documenta trabajo y evidencia reales; no equivale a una entrega terminada mientras estos elementos esten pendientes. La responsabilidad de presentar y explicar individualmente el laboratorio corresponde al estudiante.
