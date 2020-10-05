# WindowsScripts
My library of powershell scripts to install, configurate or simple automate tasks.

Every script has a text that describe his goal, usage options and walkthrougth.

Here i describe only general usage and options:

## Execution

To run scripts at prompt you need to enable this, note this is dangerous
so read and understand what every script do before run it.
if you what disable script execution after run what you what(recomended)
Use list command to check your current configuration, if you want to return to that:

    PS> Get-ExecutionPolicy -List

Enable execution of PowerShell scripts:

    PS> Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

Unblock PowerShell scripts and modules within this directory:

    PS> ls -Recurse *.ps*1 | Unblock-File

see more about at: https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.security/set-executionpolicy?view=powershell-7

### Thanks To

- Chris Titus(https://christitus.com/debloat-windows-10-2020/)
- Patrick Fitzgerald (https://medium.com/@fitzgeraldpk/git-dont-push-to-backup-698459ae02f2)
- phk@FreeBSD.ORG (https://spdx.org/licenses/Beerware.html)


## License

    "THE BEER-WARE LICENSE" (Revision 42):

    As long as you retain this notice you can do whatever you want with this
    stuff. If we meet someday, and you think this stuff is worth it, you can
    buy us a beer in return.

    This project is distributed in the hope that it will be useful, but WITHOUT
    ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
    FITNESS FOR A PARTICULAR PURPOSE.
