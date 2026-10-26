# Direccionamiento basado en la matricula

Matricula 20242388: se toman los ultimos dos digitos, 88, para construir 192.168.88.0/24. No se recibio otra regla de conversion del docente.

| Elemento | Red provisional anterior | Red final |
|---|---|---|
| R1 Fa0/0 | 192.168.50.1/24 | 192.168.88.1/24 |
| SW1 Vlan10 | 192.168.50.2/24 | 192.168.88.2/24 |
| SRV1 | 192.168.50.10/24 | 192.168.88.10/24 |
| Gateway | 192.168.50.1 | 192.168.88.1 |
| DNS SRV1 | 192.168.50.10 | 192.168.88.10 |
| Servidor RADIUS | 192.168.50.10 | 192.168.88.10 |

## Migracion realizada

1. Mantener las consolas de administracion abiertas y cambiar las IP de R1 y SW1.
2. Actualizar IP, mascara, gateway y DNS del servidor.
3. Cambiar las direcciones de los clientes R1 y SW1 en NPS.
4. Retirar de R1 la referencia antigua con los puertos exactos: no radius-server host 192.168.50.10 auth-port 1812 acct-port 1813. Mantener solo el nuevo servidor y su clave compartida.
5. En SW1 actualizar address ipv4 dentro de radius server NPS.
6. Reiniciar IAS: inicialmente seguia enlazado a la antigua IP. Get-NetUDPEndpoint verifico que paso a escuchar en ::ffff:192.168.88.10.
7. Registrar DNS mediante ipconfig /registerdns, reiniciar Netlogon y comprobar el registro A. El operador confirmo la consulta correcta.
8. Repetir test aaa en ambos equipos: se recibio User was successfully authenticated.
9. Guardar configuraciones y actualizar respaldos, diagramas y documentos.

Las capturas antiguas de 192.168.50.0/24 no representan el direccionamiento final. No se editaron para hacerlas pasar por capturas nuevas.
