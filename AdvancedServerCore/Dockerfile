FROM mcr.microsoft.com/windows/servercore:ltsc2019
RUN powershell -Command \
    Install-WindowsFeature Web-Mgmt-Console; \
    Install-WindowsFeature Web-Asp-Net45; \
    Install-WindowsFeature Web-Default-Doc; \
    Install-WindowsFeature Web-Static-Content; \
    Install-WindowsFeature Web-Stat-Compression; \
    Install-WindowsFeature Web-Dyn-Compression; \
    Install-WindowsFeature Web-Filtering