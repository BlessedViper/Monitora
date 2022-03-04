$ObjectMemory = Get-WmiObject Win32_OperatingSystem
$funcMemory = ((($ObjectMemory.TotalVisibleMemorySize - $ObjectMemory.FreePhysicalMemory)*100)/$ObjectMemory.TotalVisibleMemorySize)

$ObjectProcessor = Get-WmiObject Win32_Processor
$funcProcessor = $ObjectProcessor.LoadPercentage

$ObjectDisk = Get-WmiObject Win32_logicaldisk
$numberofDisk= $ObjectDisk.Count

Write-Host "Percentual de memória RAM utilizada: " $funcMemory"%"
Write-Host "Percentual de usabilidade do processador: " $funcProcessor"%"

for ($i=0; $i -lt $numberofDisk; $i++){
$getfreespace = $ObjectDisk.FreeSpace | Select-Object -index $i
$getsize = $ObjectDisk.Size | Select-Object -index $i
$funcDisk = ((($getsize - $getfreespace)*100)/$getsize)
$funcDisk | Out-File C:\logs\disk$i.log
Write-Host "Percentual de espaço alocado no disco" $i": "$funcDisk"%"
}

$funcMemory | out-file C:\logs\memory.log
$funcProcessor | Out-File C:\logs\processor.log
