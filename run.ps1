# Run PowerShell as Administrator before executing this script!

# === 1) Enable All Desktop Icons ===
$desktopIconPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel"

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

# Refresh desktop
$shell = New-Object -ComObject Shell.Application
$shell.Namespace(0).Self.InvokeVerb("R&efresh")

# === 2) Enable All Folders in Start Menu ===
$startFoldersPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"

$folders = @(
    "Start_ShowDocuments","Start_ShowDownloads","Start_ShowMusic",
    "Start_ShowPictures","Start_ShowVideos","Start_ShowRun",
    "Start_ShowNetwork","Start_ShowPersonalFolder","Start_ShowSettings",
    "Start_ShowFileExplorer"
)

foreach ($f in $folders) {
    Set-ItemProperty -Path $startFoldersPath -Name $f -Value 1
}

# === 3) Taskbar Behaviour: Combine Taskbar Buttons -> When taskbar is full ===
# 0 = Always, 1 = When full, 2 = Never
Set-ItemProperty -Path $startFoldersPath -Name "TaskbarGlomLevel" -Value 1

Write-Host "✅ All settings applied. Restarting Explorer..." -ForegroundColor Green

Stop-Process -Name explorer -Force
Start-Process explorer.exe
