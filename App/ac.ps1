# ac.ps1 -build_number 2020.1.0.1868 -db_server localhost -db_user root -db_password root
param(
    [Parameter(Mandatory=$true)]
    [string]$build_number,

    [Parameter(Mandatory=$false)]
    [string]$db_server,

    [Parameter(Mandatory=$false)]
    [string]$db_user,

    [Parameter(Mandatory=$false)]
    [string]$db_password
)

if (!$db_server) {$db_server = "localhost"}
if (!$db_user) {$db_user = "root"}
if (!$db_password) {$db_password = "root"}

#echo $db_server $db_user $db_password

cd $build_number\Tools
.\ac.exe -configmode:"NewInstance" -dbsrvname:"$db_server" -dbsrvwinauth:"No" -dbsrvuser:"$db_user" -dbsrvpass:"$db_password" -dbname:"$build_number" -company:"CompanyID=1;CompanyType=;LoginName=;" -company:"CompanyID=2;CompanyType=;ParentID=1;LoginName=;" -company:"CompanyID=3;CompanyType=AU;ParentID=2;Visible=Yes;LoginName=AU;"  -dbwinauth:"No" -dbnewuser:"No" -dbuser:"$db_user" -dbpass:"$db_password" -iname:"$build_number" -ipath:"C:\Advanced\\" -swebsite:"Default Web Site" -svirtdir:"Advanced" -spool:"DefaultAppPool" -dbsrvtype:"MySql"
if (Test-Path -Path "C:\Advanced")
{
    Remove-Website -Name 'Default Web Site';
    New-Website -Name 'advanced' -PhysicalPath 'C:\advanced' -Port 80 -Force
    iisreset.exe
    ipconfig
}


# Test installer command with parameter
#.\ac.exe -configmode:"NewInstance" -dbsrvname:"172.27.9.5" -dbsrvwinauth:"No" -dbsrvuser:"root" -dbsrvpass:"root" -dbname:"MYOBAdvLiveDB" -company:"CompanyID=1;CompanyType=;LoginName=;" -company:"CompanyID=2;CompanyType=;ParentID=1;LoginName=;" -company:"CompanyID=3;CompanyType=AU;ParentID=2;Visible=Yes;LoginName=Company;"  -dbwinauth:"No" -dbnewuser:"No" -dbuser:"root" -dbpass:"root" -iname:"MYOBAdvanced" -ipath:"C:\Advanced\\" -swebsite:"Default Web Site" -svirtdir:"MYOBAdvanced" -spool:"DefaultAppPool" -dbsrvtype:"MySql"
#.\ac.exe -configmode:"NewInstance" -dbsrvname:"172.27.9.5" -dbsrvwinauth:"No" -dbsrvuser:"root" -dbsrvpass:"root" -dbname:"MYOBAdvLiveDB" -company:"CompanyID=1;CompanyType=;LoginName=;" -company:"CompanyID=2;CompanyType=;ParentID=1;LoginName=;" -company:"CompanyID=3;CompanyType=AU;ParentID=2;Visible=Yes;LoginName=Company;"  -dbwinauth:"No" -dbnewuser:"No" -dbuser:"root" -dbpass:"root" -iname:"MYOBAdvanced" -ipath:"C:\Advanced\\" -swebsite:"Advanced" -svirtdir:"MYOBAdvanced" -spool:"DefaultAppPool" -dbsrvtype:"MySql"