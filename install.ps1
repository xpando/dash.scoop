$ErrorActionPreference = "Stop"
#$ProgressPreference = "SilentlyContinue"

if ($Host.Version.Major -lt 3) {
    throw "Powershell v3 or greater is required."
}

push-location $psscriptroot
try {
    # download and extract ConEmu
    if (!(test-path .\conemu)) {
        write-host "Installing ConEmu..." -foregroundcolor cyan
        invoke-webrequest 'https://conemu.codeplex.com/downloads/get/891710' -usebasicparsing -usedefaultcredentials -outfile .\ConEmu.7z
        .\7za.exe x conemu.7z
        del conemu.7z
        write-host "done." -foregroundcolor green
    }

    # download default ConEmu configuration
    if (!(test-path .\ConEmu.xml)) {
        (new-object net.webclient).downloadstring('https://gist.githubusercontent.com/xpando/e6323178eb20a023a939/raw/006edcecb933c25e1bc26de3bc0297443ed1746e/ConEmu.xml') | out-file ConEmu.xml
    }

    .\conemu.exe
}
finally {
    pop-location
}