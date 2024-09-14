# Get all removable devices
$removableDevices = Get-WmiObject -Query "SELECT * FROM Win32_Volume WHERE DriveType = 2"

# Create a Shell.Application COM object
$shell = New-Object -ComObject Shell.Application

# Eject each removable device
foreach ($device in $removableDevices) {
    $driveLetter = $device.DriveLetter
    if ($driveLetter) {
        $shell.Namespace(17).ParseName($driveLetter).InvokeVerb("Eject")
        Write-Output "Ejected: $driveLetter"
    }
}
Start-Sleep -Seconds 5

Write-Host -ForegroundColor Green "Starting OSDCloud ZTI"
Start-Sleep -Seconds 5

Start-OSDCloud -OSLanguage en-us -OSName 'Windows 10 22H2 x64' -OSLicense Retail -OSEdition Pro -ZTI

#Restart from WinPE

Write-Host -ForegroundColor Green “Restarting in 20 seconds!”

Start-Sleep -Seconds 20

wpeutil reboot
