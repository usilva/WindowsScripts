# WindowsScripts
My powershell scripts to install, configurate or simple automate tasks.

This is my library of windows powershell scripts, every script has a describe yourself and usage options and walkthrougth.

Here i discribe only general usage and options:

## Execution

Enable execution of PowerShell scripts:

    PS> Set-ExecutionPolicy Unrestricted -Scope CurrentUser

Unblock PowerShell scripts and modules within this directory:

    PS> ls -Recurse *.ps*1 | Unblock-File
