Get-ChildItem ".\Apps" -Filter *.apk | 
Foreach-Object {
    adb install $_.FullName
    Write-Output "$($_.Name) Installed"
}