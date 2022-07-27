function Add-Project {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory=$true,Position=0,HelpMessage="Syntax: <DIRECTORY_NAME>")]
    [ValidateNotNullOrEmpty()]
    [string]$name="",

    [Parameter(Mandatory=$false,HelpMessage="")]
    [ValidateSet("null")]
    [string]$framework,

    [Parameter(Mandatory=$false,HelpMessage="")]
    [ValidateSet("null")]
    [string]$extension
  )

  begin {
  }

  process {
  }

  end {
  }
}

function Get-Project {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory=$true)]
    [string]$Param
  )

  begin {
  }

  process {
  }

  end {
  }
}
