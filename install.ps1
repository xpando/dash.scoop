$ErrorActionPreference = "Stop"
$ProgressPreference = "SilentlyContinue"

if ($Host.Version.Major -lt 3) {
    throw "Powershell v3 or greater is required."
}

push-location $psscriptroot

# check for scoop installation
$scoop = $env:SCOOP, "~\appdata\local\scoop", $env:SCOOP_GLOBAL, "$($env:programdata.tolower())\scoop", ".\scoop" | select -first 1
if (!(test-path $scoop)) {
    # no scoop is installed so install to local folder
    write-host "Installing scoop..." -foregroundcolor cyan
    md scoop | out-null
    $env:scoop = resolve-path .\scoop
    [environment]::setEnvironmentVariable("scoop",$env:scoop,"User")
    iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
}

# ensure 7zip is installed which is needed to extract conemu
if (!(scoop which 7z)) {
    scoop install 7zip
}

# download and extract ConEmu
if (!(test-path .\conemu)) {
    write-host "Installing ConEmu..." -foregroundcolor cyan
    invoke-webrequest 'https://conemu.codeplex.com/downloads/get/891710' -usebasicparsing -usedefaultcredentials -outfile .\ConEmu.7z
    7z x conemu.7z
    del conemu.7z
    write-host "done." -foregroundcolor green
}

# download default ConEmu configuration
if (!(Test-Path .\ConEmu.xml)) {
    (new-object net.webclient).downloadstring('https://gist.githubusercontent.com/xpando/e6323178eb20a023a939/raw/006edcecb933c25e1bc26de3bc0297443ed1746e/ConEmu.xml') | out-file ConEmu.xml
}

.\ConEmu.exe

pop-location