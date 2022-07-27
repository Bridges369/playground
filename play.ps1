<#
.SYNOPSIS
This script is an example of how any .ps1 script can provide content to `Get-Help`.

.DESCRIPTION
..USAGE
    .\play.ps1 <command>

.COMMANDS
    1. test <DIRECTORY_NAME>                   => default `DIRECTORY_NAME`: "project#{hash}" 
    2. project {NEW [NAME] <FRAMEWORK> || CD [NAME || LOCAL] || SET || LIST } =>
    3. quit
    4. help
  -------------
    1. init a new directory test
    2. create, set, navegate, list projects
    3. quit of test
    4. help
#>

param(
  [Parameter(Position=0,Mandatory=$True)]
  [ValidateNotNullOrEmpty()]
  [ValidateSet("test","project","quit","return")]
  [System.String]$Command,

<#
  [Parameter(Position=1)]
  [Alias("CN","MachineName")]
  [System.String]$Arg_1 = "help",
#>
  [Parameter(Position=2)]
  [System.String]$Arg_2="",

  [Parameter(Position=3)]
  [System.String]$Arg_3="."
<#
  [Parameter]
  [switch]$flag=""
#>
)

DynamicParam {
  if ( $Command -eq "test") {
      $ParamAttribute = [System.Management.Automation.ParameterAttribute]@{
        Mandatory = $true
        Position = 1
        HelpMessage = "HelpMessage"
      }
      $attributeCollection = New-Object -TypeName System.Collections.ObjectModel.Collection[System.Attribute]
      #add our custom attribute
      $attributeCollection.Add($ParamtAttribute)

      #add our paramater specifying the attribute collection
      $DIRECTORY_NAME = New-Object System.Management.Automation.RuntimeDefinedParameter("Test name", [String], $attributeCollection)
      #expose the name of our parameter
      $paramDictionary = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary
      $paramDictionary.Add("Test name", $DIRECTORY_NAME)
      return $paramDictionary
    }
    if ($Command -eq "project") {
      $ParamAttribute = [System.Management.Automation.ParameterAttribute]@{
        Mandatory = $true
        Position = 1
        HelpMessage = "HelpMessage"
      }
      $attributeCollection = New-Object -TypeName System.Collections.ObjectModel.Collection[System.Attribute]
      #add our custom attribute
      $attributeCollection.Add($ParamAttribute)

      #add our paramater specifying the attribute collection
      $ACTION = New-Object System.Management.Automation.RuntimeDefinedParameter("Action", [String], $attributeCollection)
      #expose the name of our parameter
      $paramDictionary = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary
      $paramDictionary.Add("Action", $ACTION)
      return $paramDictionary
    }
}
BEGIN{}
PROCESS {
  switch ( $Command ){
    "test" {
      Update-SessionEnvironment
      $env:LASTDIR = (Get-Location).ToString()
      $dir = "$HOME/Tests/$($DIRECTORY_NAME.value)"
      New-Item $dir -ItemType Directory; Set-Location $dir
    }
    "project" {
      w $ACTION.value
      switch ( $ACTION.value ){
        "new" {
          if ($Arg_2 -eq '.') {
            # $projectName = (Get-Item .).Name
            $env:LastProject = (Get-Location).ToString
          } else {
            $pathToProject = "$HOME/Projects/$Arg_2"
            switch ( $Arg_3 ){
              "ruby" {  }
              default {
                New-Item $pathToProject -ItemType Directory
                if ($?) {
                  New-Item "$pathToProject/README.md" -ItemType File
                  Set-Location $pathToProject
                }
              } 
            }
          }
        }
        "cd" {
          #
        }
        "set"{
          #
        }
        "list"{
          #
        }
        default {  }
      }
    }
    "return" {
      Update-SessionEnvironment
      cd $env:LASTDIR
    }
    "help" {
      #
    }
    default { "help" }
  }
}
END{}
