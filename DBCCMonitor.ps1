$dbccHistory ="caminhoArquivo\Dbcc.txt"

if(Test-Path $dbccHistory){
Remove-Item $dbccHistory -force
}

sqlcmd -S instancia -U usuario -P pass -d baseName -o $dbccHistory -Q "DBCC CHECKDB WITH NO_INFOMSGS"

$MyEmail = "email"
$SMTP= "smtp do e-mail"
$To = "destinatario"
$Subject = "assunto"
$anexo = $dbccHistory
$senha = ConvertTo-SecureString -String "senha e-mail" -AsPlainText -Force
$Creds = New-Object System.Management.Automation.PSCredential ($MyEmail,$senha)

$teste=Get-Content $dbccHistory

$teste

if ($teste -eq $null){
$Body = "DBCC Result em anexo

0 erros encontrado

"
Send-MailMessage -To $to -From $MyEmail -Subject $Subject -Body $Body -Attachments $anexo -SmtpServer $SMTP -Credential $Creds -UseSsl -Port 587 -DeliveryNotificationOption never
} else {
$Body = "O Dbcc encontrou erro na base de dados, por gentileza, contacte a Omega

"
Send-MailMessage -To $to -From $MyEmail -Subject $Subject -Body $Body -Attachments $anexo -SmtpServer $SMTP -Priority High -Credential $Creds -UseSsl -Port 587 -DeliveryNotificationOption never
}
