Set-Variable HOME "$psscriptroot\home" -Force
(Get-PSProvider 'FileSystem').Home = $home

$profile          = "$home\profile.ps1"
$env:home         = $home
$env:userprofile  = $home
$env:psmodulepath = "$home\modules;$env:psmodulepath"
$env:scoop        = "$psscriptroot\scoop"
$env:path         = "$env:scoop\shims;$env:path"

# check for scoop installation
if (!(test-path $env:scoop)) {
    # no local scoop is installed so install to local folder
    write-host "Installing scoop..." -foregroundcolor cyan
    md scoop | out-null
    iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
}

if (test-path $profile) {
    . $profile
}
