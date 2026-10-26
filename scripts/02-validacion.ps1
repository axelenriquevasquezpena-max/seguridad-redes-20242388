# Consultas de verificacion. Ejecutar dentro de SRV1 como administrador.
Get-ADDomain | Select-Object DNSRoot,NetBIOSName
Get-Service NTDS,DNS,IAS
Get-DnsClientServerAddress -AddressFamily IPv4
Resolve-DnsName SRV1.seguridad.test -Type A -Server 192.168.88.10
Get-NetUDPEndpoint -LocalPort 1812,1813 | Select-Object LocalAddress,LocalPort
foreach ($grupo in "Nivel0","Nivel5","Nivel10") {
    Get-ADGroupMember -Identity $grupo | Select-Object @{Name="Grupo";Expression={$grupo}},Name
}
# Respaldo local: detener IAS manualmente, probar adminlocal y restaurarlo.
# Stop-Service IAS
# Start-Service IAS
# Get-Service IAS
