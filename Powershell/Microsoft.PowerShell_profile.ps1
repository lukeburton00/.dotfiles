$shimPath = "$env:USERPROFILE\AppData\Local\mise\shims"
$currentPath = [Environment]::GetEnvironmentVariable('Path', 'User')
$newPath = $currentPath + ";" + $shimPath
[Environment]::SetEnvironmentVariable('Path', $newPath, 'User')
. $HOME\Documents\Powershell\env.ps1

# Renders background colors correctly
$PSStyle.FileInfo.Directory = "`e[96;1m"

Set-Alias -Name c -Value clear
Set-Alias -Name l -Value Get-ChildItem
Set-Alias -Name v -Value nvim
Set-Alias -Name vi -Value nvim
Set-Alias -Name vim -Value nvim

function y {
    $tmp = [System.IO.Path]::GetTempFileName()
    yazi $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp -Encoding UTF8
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
        Set-Location -LiteralPath ([System.IO.Path]::GetFullPath($cwd))
    }
    Remove-Item -Path $tmp
}

Import-VisualStudioEnvironment
Invoke-Expression (& { (zoxide init powershell | Out-String) })
Invoke-Expression (&starship init powershell)
