$ObjectMemory = Get-WmiObject Win32_OperatingSystem
$funcMemory = ((($ObjectMemory.TotalVisibleMemorySize - $ObjectMemory.FreePhysicalMemory)*100)/$ObjectMemory.TotalVisibleMemorySize)

$ObjectProcessor = Get-WmiObject Win32_Processor
$funcProcessor = $ObjectProcessor.LoadPercentage

$ObjectDisk = Get-WmiObject Win32_logicaldisk
$numberofDisk= $ObjectDisk.Count

for ($i=0; $i -lt $numberofDisk; $i++){
    $getfreespace = $ObjectDisk.FreeSpace | Select-Object -index $i
    $getsize = $ObjectDisk.Size | Select-Object -index $i
    $funcDisk = ((($getsize - $getfreespace)*100)/$getsize)
    $funcDisk.ToString("N2") | Out-File C:\logs\disk$i.log
}

$funcMemory.ToString("N2") | out-file C:\logs\memory.log
$funcProcessor | Out-File C:\logs\processor.log
