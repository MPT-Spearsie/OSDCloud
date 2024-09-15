# Get all removable devices
$removableDevices = Get-WmiObject -Query "SELECT * FROM Win32_Volume WHERE DriveType = 2"

# Remove the drive letter for each removable device
foreach ($device in $removableDevices) {
    $driveLetter = $device.DriveLetter
    Write-Host $driveLetter
        # Remove the drive letter
        Get-Partition -DriveLetter $driveLetter | Remove-PartitionAccessPath -AccessPath $driveLetter
        Write-Output "Removed drive letter: $driveLetter"

}
Start-Sleep -Seconds 5

# Start OSDCloud ZTI
Write-Host -ForegroundColor Green "Starting OSDCloud ZTI"
Start-Sleep -Seconds 5

Start-OSDCloud -OSLanguage en-us -OSName 'Windows 11 22H2 x64' -OSLicense Retail -OSEdition Pro -ZTI

#Restart from WinPE

Write-Host -ForegroundColor Green “Restarting in 20 seconds!”

Start-Sleep -Seconds 20

wpeutil reboot
