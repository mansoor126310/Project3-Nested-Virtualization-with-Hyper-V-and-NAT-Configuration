# Define common VM storage path
$VMPath = "F:\VMs"

# Create VM storage folder if not exists
if (!(Test-Path -Path $VMPath)) {
    New-Item -ItemType Directory -Path $VMPath
}

# Define VM specifications
$VMs = @(
    @{ Name = "Windows_Server_2019"; RAM = 4GB; vCPU = 2; DiskSizeGB = 60 },
    @{ Name = "Win11_24H2"; RAM = 4GB; vCPU = 2; DiskSizeGB = 60 },
    @{ Name = "Ubuntu"; RAM = 2GB; vCPU = 1; DiskSizeGB = 30 },
    @{ Name = "CentOS"; RAM = 2GB; vCPU = 1; DiskSizeGB = 30 }
)

# Loop through each VM and create
foreach ($VM in $VMs) {
    Write-Host "Creating VM: $($VM.Name)" -ForegroundColor Cyan

    # Ask for ISO path
    $ISOPath = Read-Host "Enter ISO path for $($VM.Name)"

    # Create VM
    New-VM -Name $VM.Name `
           -MemoryStartupBytes $VM.RAM `
           -Generation 2 `
           -NewVHDPath "$VMPath\$($VM.Name)\$($VM.Name).vhdx" `
           -NewVHDSizeBytes ($VM.DiskSizeGB * 1GB) `
           -Path "$VMPath\$($VM.Name)" `
           -SwitchName "Internal"

    # Set vCPU
    Set-VMProcessor -VMName $VM.Name -Count $VM.vCPU

    # Disable Dynamic Memory for Stability
    Set-VMMemory -VMName $VM.Name -DynamicMemoryEnabled $false

    # Attach ISO
    Set-VMDvdDrive -VMName $VM.Name -Path $ISOPath

    # Set Boot Order to boot from DVD first
    Set-VMFirmware -VMName $VM.Name -FirstBootDevice (Get-VMDvdDrive -VMName $VM.Name)

    # Enable Nested Virtualization for Windows VMs only
    if ($VM.Name -like "Windows*") {
        Set-VMProcessor -VMName $VM.Name -ExposeVirtualizationExtensions $true
    }

    Write-Host "$($VM.Name) created successfully!" -ForegroundColor Green
}

Write-Host "All VMs are created! Time to install OSes manually from the ISOs!" -ForegroundColor Yellow
