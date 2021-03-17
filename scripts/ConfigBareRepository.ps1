#!C:/Program\ Files/Git/usr/bin/sh.exe

# This script creates a bare repository at specified destiny folder*(read tip) and 
# configure a githook to push into this repository at every commit. 
# 
# Why this is useful? 
# - This bare repository is a safe copy of your code and
# prevent you to need do an "git push" to backup(read credits).

## Instructions
# Use a NAS, network drive, usb or network drive to store a remote repository(bare) backup.
# [TIP-IMPORTANTE] *Always name your bare repositories with .git suffix like described at git documentation. 
# (https://git-scm.com/book/en/v2/Git-on-the-Server-Getting-Git-on-a-Server)

## [SINTAX] 
# to run this script
# powershell -nop -c .\ConfigBareRepository.ps1 [path_of_your_code] [destiny_path_of_your_bare_backup] 
# or
# .\ConfigBareRepository.ps1 [path_of_your_code] [destiny_path_of_your_bare_backup]

## Credits
# author: https://github.com/usilva
#
# this is an windows(powersheel) version of linux shell script of Patrick Fitzgerald
# https://medium.com/@fitzgeraldpk/git-dont-push-to-backup-698459ae02f2

function MakeBareRepoBackup($repo, $backup){
        mkdir -p $backup;
        Set-Location $backup;
        git init --bare;
        Set-Location $repo;

        Write-Output "adding remote mirror link"
        git remote add --mirror=push backup $backup;
        git remote -v;
                
        Write-Output "creating post-commit.ps1 to use with hook"
        #Write-Output "#!$env:PROGRAMFILES\Git/usr/bin/sh.exe" > .git/hooks/post-commit.ps1;
        Write-Output "#!C:/Program\ Files/Git/usr/bin/sh.exe" > .git/hooks/post-commit.ps1;
        Write-Output " " >> .git/hooks/post-commit.ps1;
        Write-Output "git push backup" >> .git/hooks/post-commit.ps1;


        Write-Output "creating post-commit hook"
        $file = $repo + '\.git\hooks\post-commit'
        New-Item -Path $file -ItemType File -Value "#!C:/Program\ Files/Git/usr/bin/sh.exe"
        Add-Content $file ""
        Add-Content $file "exec powershell.exe -NoProfile -ExecutionPolicy Bypass -File '.\.git\hooks\post-commit.ps1'"
        Add-Content $file "exit"
}

#check if use the command line parameters
If ($args.Length -eq 2) {
	Write-Output "Configuring backup at bare repository..."

    $repo = $args[0]
    $backup = $args[1]

    Write-Output "Original repository is: $repo"

    Write-Output "Bare repository Backup is: $backup"

    $yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes","Description."
    $no = New-Object System.Management.Automation.Host.ChoiceDescription "&No","Description."
    $cancel = New-Object System.Management.Automation.Host.ChoiceDescription "&Cancel","Description."
    $options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no, $cancel)


    $title = "" 
    $message = "Are you sure want to use this configuration?"
    $result = $host.ui.PromptForChoice($title, $message, $options, 1)
    switch ($result) {
      0{
        Write-Host "Yes"
        MakeBareRepoBackup $repo $backup
      }
      1{
        Write-Host "No"
      }
      2{
        Write-Host "Cancel"
      }
     }
    
}else{
    Write-Output "RepositoryPath(original) and BareBackupRespository complete paths was needed parameters to script run"
}

