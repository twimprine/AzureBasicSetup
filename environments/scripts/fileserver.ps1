$FileSharePath = "D:\SharedData"

Install-WindowsFeature -Name FS-FileServer, FS-DFS-Namespace, FS-DFS-Replication, RSAT-DFS-Mgmt-Con -IncludeManagementTools

New-Item -ItemType Directory -Path $FileSharePath -Force