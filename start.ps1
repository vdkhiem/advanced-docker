#.\start.ps1 -build_number 2020.2.0.3460 -db_server 192.168.1.84 -db_user root -db_password root
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


if (!$db_user) {$db_user = "root"}
if (!$db_password) {$db_password = "root"}

# Create NAT network
$network_name = docker network ls --filter name=advanced-net
if (!($network_name -contains "advanced-net"))
{
    Write-Output $network_name
    docker network create --driver nat advanced-net
}

# Build advanced app dockerfile
.\App\start.ps1 -build_number $build_number

# Start docker compose
docker-compose up -d

# Pause 1 minute to get created containers to be ready
Start-Sleep -s 60

if (!$db_server) 
{
    # store database server ip address
    $db_server = docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' advanced-mysql-container
    #$db_server = "localhost"
    Write-Output "database server ip address: $db_server"
}

# run advanced installer
docker container exec -ti advanced-app-container powershell .\ac.ps1 -build_number $build_number -db_server $db_server -db_user $db_user -db_password $db_password
