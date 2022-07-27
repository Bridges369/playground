[CmdletBinding()]
param (
  [Parameter(Mandatory=$true,Position=0)]
  [ValidateNotNullOrEmpty()]
  [string]$name="",

  [Parameter(Mandatory=$false)]
  [ValidateSet("null")]
  [string]$framework,

  [Parameter(Mandatory=$false)]
  [ValidateSet("null")]
  [string]$extension
)

$path = ((Get-Content "$PSScriptRoot/../.config") -split ":")[1]
try {
  New-Item "$path/$name" -ItemType Directory 
} catch {
  Write-Error "The project '$name' already exist"    
}
