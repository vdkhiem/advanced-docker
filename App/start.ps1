#.\start.ps1 -build_number 2020.1.0.1868
param(
    [Parameter(Mandatory=$true)]
    [string]$build_number
)

#Write-Output "Clean up container and image"
#docker container rm -f advanced-container-$build_number
#docker image rm advanced-image-$build_number

#http://nzakledci02.myob.myobcorp.net:8080/repository/download/Natasha_NatashaAdvancedLive_Main/765943:id/Natasha.AdvancedLive.2020.2.0.3889.zip
#Read-S3Object -BucketName Natasha_NatashaAdvancedLive_Main -Key Natasha.AdvancedLive.$build_number.zip -File Natasha.AdvancedLive.$build_number.zip

$TeamCityUser = 'yyy'
$TeamCityPassword = 'xxx3'
$securePassword = ConvertTo-SecureString $TeamCityPassword -AsPlainText -Force
$creds = New-Object System.Management.Automation.PSCredential($TeamCityUser, $securePassword)

Write-Output "Build Dockerfile"

$CurrentPath = Get-Location
#$url = "http://nzakledci02.myob.myobcorp.net:8080/app/rest/builds/id:765943/artifacts/content/Natasha.AdvancedLive.$build_number.zip"
#$url = "http://acumatica-builds.s3.amazonaws.com/builds/20.1/20.101.0032/AcumaticaERP/AcumaticaERPInstall.msi"
$url = "http://nzakledci02.myob.myobcorp.net:8080/app/rest/builds/id:765943/artifacts/content/Natasha.AdvancedLive.2020.2.0.3889.zip"
$output = "$CurrentPath\App\Natasha.AdvancedLive.$build_number.zip"
#Invoke-WebRequest -Uri $url -Credential $creds -OutFile $output

# Write-Host $url
# $WebClient = New-Object System.Net.WebClient
# $credCache = new-object System.Net.CredentialCache
# $creds = new-object System.Net.NetworkCredential("khiem.vo","Ilovemyfamily13")
# $credCache.Add($url, "Basic", $creds)
# $WebClient.Credentials = $credCache
# $WebClient.DownloadFile($url, $output)

Set-Content -Path $CurrentPath\App\Dockerfile -Value "FROM vdkhiem/advancedservercore:2020"
Add-Content $CurrentPath\App\Dockerfile "COPY Natasha.AdvancedLive.$build_number.zip ac.ps1 c:/"
Add-Content $CurrentPath\App\Dockerfile "RUN powershell -Command \
    New-Item -Path c:\ -Name $build_number -ItemType directory; \
    Expand-Archive -Path c:\Natasha.AdvancedLive.$build_number.zip -DestinationPath c:\$build_number; \
    Remove-Item c:\Natasha.AdvancedLive.$build_number.zip"
Write-Output "Run Dockerfile"