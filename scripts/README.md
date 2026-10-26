# Comandos y scripts del laboratorio

Estos archivos recopilan los comandos usados de forma interactiva. No son evidencia de una ejecucion automatica ni deben ejecutarse de principio a fin en un servidor ya configurado. Los bloques de instalacion y promocion son para un servidor nuevo; la promocion y el renombrado reinician Windows.

- 01-servidor.ps1: preparacion, AD, usuarios y NPS; ejecutar por etapas.
- 02-validacion.ps1: consultas de comprobacion del servidor.
- 03-respaldo-nps.ps1: exportacion privada y creacion de una copia de documentacion sin campos con nombres de secretos. La revision posterior es obligatoria antes de publicar.
- comandos-cisco.txt: comprobaciones y depuracion temporal. Las configuraciones finales por dispositivo estan en ../configs/.

Las pruebas RADIUS reciben la contrasena como argumento visible en IOS. No guardar ni publicar esa linea con la contrasena real. Las claves se introducen localmente y no estan en este repositorio. Los comandos de exportacion deben ejecutarse otra vez tras cambiar las IP.
