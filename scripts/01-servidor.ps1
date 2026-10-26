# REFERENCIA POR ETAPAS. No ejecutar completo sobre el dominio existente.
# PowerShell como administrador. IP final: 192.168.88.10/24.
# La IP se configuro por ncpa.cpl: gateway 192.168.88.1, DNS 192.168.88.10.

# ETAPA 1: solo en servidor nuevo. Reinicia; volver a iniciar sesion antes de continuar.
Rename-Computer -NewName "SRV1" -Restart

# ETAPA 2: instalar y promover. DSRM se solicita interactivamente. Reinicia.
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools
Install-ADDSForest -DomainName "seguridad.test" -DomainNetbiosName "SEGURIDAD" -InstallDNS

# ETAPA 3: despues de la promocion, iniciar como SEGURIDAD\Administrator.
# No repetir si los grupos y usuarios ya existen.
foreach ($nivel in 0,5,10) {
    New-ADGroup -Name "Nivel$nivel" -GroupScope Global -GroupCategory Security
    $nombreUsuario = "usuario$nivel"
    $claveUsuario = Read-Host "Contrasena para $nombreUsuario" -AsSecureString
    New-ADUser -Name $nombreUsuario -SamAccountName $nombreUsuario -UserPrincipalName "$nombreUsuario@seguridad.test" -AccountPassword $claveUsuario -Enabled $true
    Add-ADGroupMember -Identity "Nivel$nivel" -Members $nombreUsuario
}

# ETAPA 4: NPS. Los clientes y las politicas se crearon mediante nps.msc.
Install-WindowsFeature -Name NPAS -IncludeManagementTools
netsh nps add registeredserver
Get-Service IAS

# ETAPA 5: despues de cambiar IP, actualizar DNS y reiniciar el enlace NPS.
ipconfig /flushdns
ipconfig /registerdns
Restart-Service Netlogon
Restart-Service IAS
