#
# This is a script to install and configure windows dotnet/dotnetCore development machine
#

### Prerequisites:
##
## Windows 10 1709 (16299) or later
## Enabled run powershell scripts: 
##   Open powershell as administrator and run the command bellow
##   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine
##
## **If you preffer, after run the script you can disable this option again(recomended)

## To run type at powershell(ADM):
##  .\MakeDevelopmentMachine.ps1
##  or
##  powershell -nop -c "MakeDevelopmentMachine.ps1"

#
## author: https://github.com/usilva
#

$functions = @(
	### Require administrator privileges ###
    "RequireAdmin",
    
    ## First need to install winget
    "InstallWinget"

    ## Development Tool
    "InstallGit"
    "InstallVisualStudio"
    "InstallVisualStudioCode"
    "InstallSSMS"
    "InstallChrome"
    "InstallFirefox"
    "InstallToggl"
    "InstallmRemoteNG"    
    "InstallSlack"
    "InstallInsomnia"

    ## Configurations
    "ConfigurateGit"
    "SSMSToDarkMode"

    ## Windows features
    "InstallWindowsTerminal"
    "InstallWSL" ##Must be a last to run, because needs a restart 

    ### Auxiliary functions ###
	"WaitForKey"
	#"Restart"
)

Write-Output "This is a script to install my .dotnet core development environment"

function InstallWinget{
    Write-Output "installing winget"
    Invoke-WebRequest -Uri https://github.com/microsoft/winget-cli/releases/download/v0.1.4331-preview/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.appxbundle -OutFile Winget.appx -UseBasicParsing
    Add-AppxPackage .\Winget.appx
}

function InstallGit{
    winget install Git.Git
}

function InstallVisualStudio{
    winget install Visual Studio Community
}

function InstallVisualStudioCode{
    winget install -e Microsoft.VisualStudioCode
}

function InstallSSMS{
    winget install -e Microsoft.SQLServerManagementStudio
}

function InstallChrome{
    winget install -e Google.Chrome
}

function InstallFirefox{
    winget install -e Mozilla.Firefox
}

function InstallToggl{
    winget install -e Toggl.TogglDesktop
}

function InstallmRemoteNG{
    winget install mRemoteNG
}

function InstallWindowsTerminal{
    winget install -e Microsoft.WindowsTerminal
}

function InstallSlack{
    winget install -e SlackTechnologies.Slack
}

function InstallInsomnia{
    winget install -e Insomnia.Insomina
}

function InstallWSL{
    dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
    dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
    #Restart-Computer
    #Invoke-WebRequest -Uri https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi -OutFile wsl_update_x64.msi -UseBasicParsing
    #$arguments = "/i .\wsl_update_x64.msi /quiet"
    #Start-Process msiexec.exe -ArgumentList $arguments -Wait
}

function ConfigurateGit{
    git config --global user.email "usilva@gmail.com"
    git config --global user.name "Ulisses"
    git config --global credential.helper store
}

function SSMSToDarkMode{
    Write-Output "Enabling ssms to dark mode option"
    powershell -Command "(gc 'C:\Program Files (x86)\Microsoft SQL Server Management Studio 18\Common7\IDE\ssms.pkgundef') -replace '\[\`$RootKey\`$\\Themes\\{1ded0138-47ce-435e-84ef-9ec1f439b749}\]', '//[`$RootKey`$\Themes\{1ded0138-47ce-435e-84ef-9ec1f439b749}]' | Out-File 'C:\Program Files (x86)\Microsoft SQL Server Management Studio 18\Common7\IDE\ssms.pkgundef'"
}

##########
# Auxiliary functions
##########

# Relaunch the script with administrator privileges
function RequireAdmin {
	If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
		Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`" $PSCommandArgs" -WorkingDirectory $pwd -Verb RunAs
		Exit
	}
}

# Wait for key press
function WaitForKey {
	Write-Output "Press any key to continue..."
	[Console]::ReadKey($true) | Out-Null
}

# Restart computer
function Restart {
	Write-Output "Restarting..."
	Restart-Computer
}

# Call the desired tweak functions
$functions | ForEach { Invoke-Expression $_ }