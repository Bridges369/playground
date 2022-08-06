[CmdletBinding()]
param (
  [Parameter(
    Mandatory=$true,Position=0,
    HelpMessage="Enter the name of project."
  )]
  [ValidateNotNullOrEmpty()]
  [Alias("n")]
  [string]$Name,

  [Parameter(
    Mandatory=$false,
    HelpMessage="Enter the framework used."
  )]
  [ValidateNotNullOrEmpty()]
  #[ValidateSet("null")]
  [Alias("f")]
  [string]$Framework,

  [Parameter(
    Mandatory=$false,
    HelpMessage="Enter the extension of main file."
  )]
  [ValidateNotNullOrEmpty()]
  #[ValidateSet("null")]
  [Alias("e")]
  [string]$Extension,

  [Parameter(
    Mandatory=$false,
    HelpMessage="Enter additional params for the framework used."
  )]
  [Alias("p","params")]
  [string]$Additional_params
)

$path = ((Get-Content "$PSScriptRoot/../.config") -split ":")[1]

if ($Framework) {
  switch ( $Framework ){
    "rust" {
      cargo new $Name $Additional_params
    }
    default { 
      Write-Error "This framework doesn't seem to be installed."
      exit
    }
  }
} elseif ($Extension) {
  try {
    New-Item "$path/$Name" -ItemType Directory -ErrorAction Stop
  } catch {
    Write-Error "The project '$Name' already exist"
    exit
  }
  New-Item "$path/$Name/main.$Extension" -ItemType File
  Set-Location "$path/$Name"
} else {
  try {
    New-Item "$path/$Name" -ItemType Directory -ErrorAction Stop
  } catch {
    Write-Error "The project '$Name' already exist"
    exit
  }
}
