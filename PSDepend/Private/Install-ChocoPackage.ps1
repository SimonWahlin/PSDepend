function Install-ChocoPackage {
    [CmdletBinding()]
    param (
        # Name of Chocholatey package
        [Parameter(Mandatory)]
        [string]
        $Name,

        # Parameters to pass on to choco.exe
        [Parameter()]
        [string]
        $Parameters,
        
        # Version to install
        [Parameter()]
        [string]
        $Version,
        
        # Source for choco.exe
        [Parameter()]
        [string]
        $Source,
        
        # Force installation of package
        [Parameter()]
        [switch]
        $Force
    )
    
    $Params = @(
        'install',
        '--yes',
        $Name,
        $(if(-not [string]::IsNullOrWhiteSpace($Parameters)){"--parameters $Parameters"}),
        $(if(-not [string]::IsNullOrWhiteSpace($Version)){"--version=$Version"}),
        $(if(-not [string]::IsNullOrWhiteSpace($Source)){"--source=$Source"}),
        $(if($Force){"--force"})
    )
    & choco $Params
}