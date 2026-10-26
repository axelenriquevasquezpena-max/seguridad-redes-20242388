# Procedimiento de configuracion

## 1. Red y equipos Cisco

Crear una VLAN 10 llamada ADMINISTRACION en SW1. Asignar Gi0/0 y Gi0/1 como puertos de acceso de esa VLAN. Configurar R1 Fa0/0 con 192.168.88.1/24 y SW1 Vlan10 con 192.168.88.2/24. La configuracion final completa de cada equipo se encuentra en configs/.

R1 fue verificado en Full-duplex a 100 Mb/s. Su configuracion conserva `no cdp log mismatch duplex`, que solo silencia el aviso y no corrige por si mismo un desajuste. SW1 muestra negociacion automatica en el enlace virtual; no se presenta esto como prueba de negociacion fisica.

## 2. Windows Server y Active Directory

Instalar Windows Server 2022 con experiencia de escritorio. Se asignaron 4 GB de memoria, dos procesadores logicos y un disco virtual de 60 GB. Instalar VMware Tools para la integracion del portapapeles y agregar la VM a GNS3 estando apagada, permitiendo que GNS3 gestione su adaptador.

Configurar IPv4 192.168.88.10/24, gateway 192.168.88.1 y DNS 192.168.88.10. Renombrar a SRV1. Instalar AD-Domain-Services con herramientas y crear el bosque seguridad.test, nombre NetBIOS SEGURIDAD, instalando DNS. La contrasena DSRM se introduce de forma interactiva y no se publica.

Crear grupos globales de seguridad Nivel0, Nivel5 y Nivel10. Crear usuario0, usuario5 y usuario10 con contrasenas robustas y agregarlos a sus respectivos grupos. Comprobar con Get-ADGroupMember. Verificar NTDS y DNS en Running y resolver SRV1.seguridad.test a 192.168.88.10.

Los comandos utilizados se registran en scripts/. Los archivos son una recopilacion del procedimiento; no se ejecutaron automaticamente desde este repositorio sobre el laboratorio.

## 3. NPS

Instalar NPAS con herramientas de administracion y registrar NPS en AD con `netsh nps add registeredserver`. Verificar el servicio IAS en Running.

En nps.msc, crear dos clientes RADIUS habilitados:

| Nombre exacto | Direccion final | Clave |
|---|---|---|
| R1 | 192.168.88.1 | Compartida exclusivamente entre NPS y R1 |
| SW1 | 192.168.88.2 | Compartida exclusivamente entre NPS y SW1 |

La clave nunca se incluye en la documentacion publica. NPS utiliza inicialmente la politica de solicitudes de conexion `Use Windows authentication for all users`, observada en los eventos.

## 4. Politicas de red

Crear las politicas en orden Cisco-Nivel10, Cisco-Nivel5 y Cisco-Nivel0, por encima de las denegaciones predeterminadas.

| Propiedad | Valor |
|---|---|
| Tipo de servidor de acceso | Unspecified |
| Windows Groups | SEGURIDAD\Nivel10, SEGURIDAD\Nivel5 o SEGURIDAD\Nivel0, segun politica |
| Client Friendly Name | ^(R1\|SW1)$ |
| Acceso | Grant Access |
| Propiedades Dial-in | Ignorar las propiedades de la cuenta; verificar en Overview |
| Metodo | Unencrypted authentication (PAP, SPAP); sin EAP ni otros metodos |
| Service-Type | Login |
| Framed-Protocol | Eliminado |
| Vendor Specific | Cisco / Cisco-AV-Pair |
| Valor | shell:priv-lvl=10, shell:priv-lvl=5 o shell:priv-lvl=0 |

La barra vertical del patron expresa la alternativa entre R1 y SW1. Cada usuario de prueba pertenece unicamente a su grupo de nivel; la primera politica coincidente es relevante si se agregan membresias adicionales.

## 5. AAA y permisos Cisco

Crear adminlocal con privilegio 15 y enable secret. Configurar listas nombradas de login y autorizacion EXEC con `group radius local`. Aplicarlas exclusivamente a consola y auxiliar y activar `aaa authorization console`.

R1 usa `radius-server host ...`; SW1 usa `radius server NPS`. El origen RADIUS es Fa0/0 en R1 y Vlan10 en SW1. Configurar SSHv2 con RSA de 2048 bits; en R1 la longitud se introdujo en la pregunta interactiva tras `crypto key generate rsa`.

Los comandos de autorizacion local se aplicaron en este orden para conservar show accesible en nivel 0:

```text
privilege exec level 0 show privilege
privilege exec level 5 ping
privilege exec level 10 show interfaces
privilege exec level 0 show
```

La ultima linea corrige el nivel del comando padre show, que IOS puede elevar al asignar show interfaces. Es necesario comprobar los resultados con una sesion nueva y sin ejecutar enable.

No se define nivel 15 por defecto en las lineas. Las VTY mantienen `transport input none`. Deshabilitar `ip http server` e `ip http secure-server`.

## 6. Registros y respaldo

Habilitar login on-success/on-failure log, marcas de tiempo con BOT (UTC-4) y bufer de 65536 bytes. Durante las pruebas activar debug aaa authentication, debug aaa authorization y debug radius; desactivar con undebug all. Revisar eventos 6272 y 6273 de NPS y los mensajes Access-Accept, Access-Reject y Authorization successful de IOS.

Para probar el respaldo, mantener la otra consola abierta, detener IAS, iniciar sesion como adminlocal, comprobar nivel 15 y volver a iniciar IAS aun si falla el acceso. No dejar el servicio detenido.

## 7. Guardado

Guardar configuraciones con copy running-config startup-config. Conservar respaldos privados y exportar copias sin claves ni hashes. Las claves RSA privadas no se publican y el running-config no es una exportacion de esas claves. El archivo VLAN es evidencia adicional de la base de VLAN del switch.
