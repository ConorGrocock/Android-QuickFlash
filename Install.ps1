param ([Parameter(Mandatory=$true)][string]$OSName)
param ([Parameter(Mandatory=$true)][string]$OSVer)
if(Test-Path .\Roms\$OSName.zip){
    $a = Get-Date
    Write-Output $a.ToString()
    adb devices
    #adb reboot recovery
    
    while((adb devices | Measure-Object –Line).Lines -lt 2) {
        sleep 5
        Write-Output "Not booted yet, waiting"
    }

    #sleep 40
    adb devices
    
    adb shell twrp wipe cache
    adb shell twrp wipe system
    adb shell twrp wipe data
    adb shell twrp sideload
    
    sleep 5
    adb sideload .\Roms\$OSName.zip
    sleep 5
    adb shell twrp sideload
    sleep 10
    adb sideload .\Gapps\$OSVer-mini.zip

    $b = Get-Date
    Write-Output $([math]::floor($b.Subtract($a).TotalMinutes).ToString()) : $([math]::floor($b.Subtract($a).TotalSeconds).ToString()) : $([math]::floor($b.Subtract($a).TotalMilliseconds).ToString())
} else {
    Write-Output "Image not found"
}
