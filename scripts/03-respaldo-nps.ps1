# PowerShell como administrador en SRV1. El archivo PRIVADO contiene secretos.
# Nunca adjuntar ni subir el XML privado. El publico es solo documentacion.
New-Item -ItemType Directory -Path C:\Laboratorio -Force | Out-Null
netsh nps export filename="C:\Laboratorio\NPS-PRIVADO.xml" exportPSK=YES
if ($LASTEXITCODE -ne 0) { throw "No se pudo exportar NPS." }
[xml]$doc = Get-Content -LiteralPath "C:\Laboratorio\NPS-PRIVADO.xml"
$nodosSensibles = @($doc.SelectNodes("//*") | Where-Object { $_.LocalName -match 'secret|password' })
foreach ($nodo in $nodosSensibles) {
    if ($null -ne $nodo.ParentNode) { [void]$nodo.ParentNode.RemoveChild($nodo) }
}
$atributosSensibles = @($doc.SelectNodes("//@*") | Where-Object { $_.LocalName -match 'secret|password' })
foreach ($atributo in $atributosSensibles) { [void]$atributo.OwnerElement.RemoveAttributeNode($atributo) }
$doc.Save("C:\Laboratorio\NPS-PUBLICO.xml")
[xml]$verificacion = Get-Content -LiteralPath "C:\Laboratorio\NPS-PUBLICO.xml"
$restantes = @($verificacion.SelectNodes("//* | //@*") | Where-Object { $_.LocalName -match 'secret|password' })
"Campos sensibles restantes: $($restantes.Count)"
# Cero no garantiza ausencia de informacion sensible en otros campos.
# Revisar estructura, atributos y contenido antes de publicar el XML publico.
