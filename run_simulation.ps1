# PowerShell helper to compile and run the counter simulation
# Usage: run this from the project folder: .\run_simulation.ps1

$iverilog = Get-Command iverilog -ErrorAction SilentlyContinue
$vvp = Get-Command vvp -ErrorAction SilentlyContinue

if ($null -eq $iverilog -or $null -eq $vvp) {
    Write-Output "iverilog or vvp not found on PATH."
    Write-Output "If you have Chocolatey and can run an elevated PowerShell, install with:"
    Write-Output "  choco install iverilog -y"
    Write-Output "Or download a Windows build from: https://bleyer.org/icarus/ and add its bin folder to your PATH."
    exit 1
}

$cwd = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
$counter = Join-Path $cwd 'counter.v'
$tb = Join-Path $cwd 'tb_counter.v'

Write-Output "Compiling..."
& iverilog -o my_counter_sim $tb $counter
if ($LASTEXITCODE -ne 0) { Write-Output "Compilation failed."; exit 2 }

Write-Output "Running simulation..."
& vvp my_counter_sim
if ($LASTEXITCODE -ne 0) { Write-Output "Simulation runtime failed."; exit 3 }

Write-Output "Simulation finished. Waveform: counter_waveform.vcd"
Write-Output "Open it with: gtkwave counter_waveform.vcd (if gtkwave is installed)"
