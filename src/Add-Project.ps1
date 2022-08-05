[CmdletBinding()]
param (
  [Parameter(Mandatory=$true,Position=0)]
  [ValidateNotNullOrEmpty()]
  [string]$name="",

  [Parameter(Mandatory=$false)]
  #[ValidateSet("null")]
  [string]$framework,

  [Parameter(Mandatory=$false)]
  #[ValidateSet("null")]
  [string]$extension,

  [Parameter(Mandatory=$false)]
  [string]$params
)

$path = ((Get-Content "$PSScriptRoot/../.config") -split ":")[1]

if ($framework -ne "") {
  switch ( $framework ){
    "rust" {
      cargo new $name $params
    }
    default { 
      Write-Error "This framework doesn't seem to be installed."
      exit
    }
  }
} elseif ($extension -ne "") {
  try {
    New-Item "$path/$name" -ItemType Directory -ErrorAction Stop
  } catch {
    Write-Error "The project '$name' already exist"
    exit
  }
  New-Item "$path/$name/main.$extension" -ItemType File
  Set-Location "$path/$name"
} else {
  try {
    New-Item "$path/$name" -ItemType Directory -ErrorAction Stop
  } catch {
    Write-Error "The project '$name' already exist"
    exit
  }
}
