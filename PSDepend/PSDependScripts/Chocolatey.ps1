<#
    .SYNOPSIS
        Install a Chocolatey package.

    .DESCRIPTION
        Install a Chocolatey package.

        Note: We require choco in your path.

        Relevant Dependency metadata:
            DependencyName (Key): Chocolatey Package Name
            Version: Version of the Chocolatey package to install; defaults to latest.
            Parameters: Parameters string passed on to choco.exe
            Source: Source, passed on to choco.exe

    .PARAMETER Dependency
        Dependency to process
    
    .PARAMETER PSDependAction
        Test or Install the dependency.  Defaults to Install

        Test: Not yet supported
        Install: Install the dependency

    .EXAMPLE
        @{
            'vscode' = @{
                DependencyType = 'Chocolatey'
                Parameters     = '/NoDesktopIcon /NoQuicklaunchIcon'
            }
        }

        # Full syntax
            # DependencyName (key) uses (unique) name 'vscode'
            # Passes on parameters '/NoDesktopIcon /NoQuicklaunchIcon' to installer

#>
[cmdletbinding()]
param (
    [PSTypeName('PSDepend.Dependency')]
    [psobject[]]$Dependency,

    [ValidateSet('Test', 'Install')]
    [string[]]$PSDependAction = @('Install'),
    
    [switch]$Force
)
#region    Extract Dependency Data
$Name    = $Dependency.DependencyName
$Version = $Dependency.Version
$Parameters = $Dependency.Parameters
$Source = $Dependency.Source
#endregion Extract Dependency Data

#region    Install Action
If ($PSDependAction -contains 'Install')
{
    $Params = @{
        Name  = $Name
        Force = $Force
    }
            
    if($null -ne $Version)
    {
        $Params.Add('Version',$Version)
    }
    if($null -ne $Parameters)
    {
        $Params.Add('Parameters',$Parameters)
    }
    if($null -ne $Source)
    {
        $Params.Add('Source',$Source)
    }
            
    Install-ChocoPackage @Params
}
#endregion Install Action