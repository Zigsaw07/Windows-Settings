# Run PowerShell as Administrator before executing this script!

# 1) Enable All Desktop Icons
# This enables: This PC, User’s Files, Network, Recycle Bin, Control Panel
$desktopIconPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel"

# GUIDs for system icons
$icons = @{
    "ThisPC"        = "{20D04FE0-3AEA-1069-A2D8-08002B30309D}"
    "UserFiles"     = "{59031a47-3f72-44a7-89c5-5595fe6b30ee}"
    "Network"       = "{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}"
    "RecycleBin"    = "{645FF040-5081-101B-9F08-00AA002F954E}"
    "ControlPanel"  = "{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}"
}

foreach ($icon in $icons.Values) {
    Set-ItemProperty -Path $desktopIconPath -Name $icon -Value 0 -Force
}

# Refresh desktop to show icons
$shell = New-Object -ComObject Shell.Application
$shell.Namespace(0).Self.InvokeVerb("R&efresh")


# 2) Enable All Folders in Start Menu (Settings > Personalization > Start > Folders)
$startFoldersPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"

Set-ItemProperty -Path $startFoldersPath -Name "Start_ShowDocuments" -Value 1
Set-ItemProperty -Path $startFoldersPath -Name "Start_ShowDownloads" -Value 1
Set-ItemProperty -Path $startFoldersPath -Name "Start_ShowMusic" -Value 1
Set-ItemProperty -Path $startFoldersPath -Name "Start_ShowPictures" -Value 1
Set-ItemProperty -Path $startFoldersPath -Name "Start_ShowVideos" -Value 1
Set-ItemProperty -Path $startFoldersPath -Name "Start_ShowRun" -Value 1
Set-ItemProperty -Path $startFoldersPath -Name "Start_ShowNetwork" -Value 1
Set-ItemProperty -Path $startFoldersPath -Name "Start_ShowPersonalFolder" -Value 1
Set-ItemProperty -Path $startFoldersPath -Name "Start_ShowSettings" -Value 1
Set-ItemProperty -Path $startFoldersPath -Name "Start_ShowFileExplorer" -Value 1


# 3) Taskbar Behaviour: Combine Taskbar Buttons -> When taskbar is full
# Registry values: 0 = Always, 1 = When full, 2 = Never
$taskbarPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
Set-ItemProperty -Path $taskbarPath -Name "TaskbarGlomLevel" -Value 1


Write-Host "✅ Settings Applied. Some changes may require restarting Explorer or logging out/in." -ForegroundColor Green
