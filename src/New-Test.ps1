[CmdletBinding()]
param (
  [Parameter(
    Mandatory=$true,Position=0,
    HelpMessage="Enter the name of test (if `".`" this directory is cloned to test directory)."
  )]
  [ValidateNotNullOrEmpty()]
  [Alias("n")]
  [String]$Name,

  [Parameter(
    Mandatory=$false,
    HelpMessage="Enter the path to the test directories."
  )]
  [ValidateNotNullOrEmpty()]
  [String]$ConfigPath=""
)

$config = (Get-Content "$PSScriptRoot/../config.json" | ConvertFrom-JSON)

if (Test-Path $ConfigPath) {

  Write-Output "Moving $($Config.Tests.Path + "/*") to $ConfigPath..."

  try {
    Move-Item -Path ($Config.Tests.Path + "/*") -Destination $ConfigPath -ErrorAction Stop
  } catch {
    Write-Error "An unknown error has occurred."
    exit
  }

  Write-Output "Done! " -NoNewLine

  $Config.Tests.Path = $ConfigPath
  Set-Content "$PSScriptRoot/../config.json" -Value (ConvertTo-JSON $Config)
  
  Write-Output "New path updated."

}

if (
  $Name -eq "." # -and -not (Test-Path ($Config.Tests.Path + "/" + (Get-Item .).Name))
) {

  Copy-Item -Path $Name -Destination $Config.Tests.Path -Recurse -Force
  Set-Location ($Config.Tests.Path + "/$((Get-Item $Name).Name)")

} elseif ($Name -ne ".") {
  
  $test = New-Item -Path $Config.Tests.Path -Name $Name -Force
  Set-Location $test

} else {
  Write-Error "The argument in position 0 is a String?"
}
