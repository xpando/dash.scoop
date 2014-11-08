Set-Variable HOME "$psscriptroot\home" -Force
(Get-PSProvider 'FileSystem').Home = $home

$profile          = "$home\profile.ps1"
$env:home         = $home
$env:userprofile  = $home
$env:psmodulepath = "$home\modules;$env:psmodulepath"
$env:scoop        = resolve-path "$psscriptroot\scoop"

if (test-path $profile) {
    . $profile
}