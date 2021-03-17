#Replace some text at some file

$filePath = $args[0]
$originalText = $args[1]
$textToReplace = $args[2]

Write-Output "Original text: $originalText"

Write-Output "file path: $filePath"

$content = Get-Content -Path $filePath

Write-Output "content: $content"

Write-Output ""
Write-Output "new text: $textToReplace"
Write-Output ""

$newContent = $content -replace $originalText, $textToReplace

Write-Output "New content: $newContent"

#Set-Content -Path $filePath -Value $newContent

#((Get-Content -path .\.git\config -Raw) -replace 'backup_repository','backup\\repositories') | Set-Content -Path .\.git\config