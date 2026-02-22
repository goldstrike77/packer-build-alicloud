#powershell
write-output "Running User Data Script"
write-host "(host) Running User Data Script"
Set-ExecutionPolicy Unrestricted -Scope LocalMachine -Force -ErrorAction Ignore
# Don't set this before Set-ExecutionPolicy as it throws an error
$ErrorActionPreference = "stop"
# Remove HTTP listener
Remove-Item -Path WSMan:\Localhost\listener\listener* -Recurse
# WinRM
write-output "Setting up WinRM"
write-host "(host) setting up WinRM"
cmd.exe /c winrm quickconfig -q
cmd.exe /c winrm quickconfig '-transport:http'
cmd.exe /c winrm set "winrm/config" '@{MaxTimeoutms="1800000"}'
cmd.exe /c winrm set "winrm/config/winrs" '@{MaxMemoryPerShellMB="10240"}'
cmd.exe /c winrm set "winrm/config/service" '@{AllowUnencrypted="true"}'
cmd.exe /c winrm set "winrm/config/client" '@{AllowUnencrypted="true"}'
cmd.exe /c winrm set "winrm/config/service/auth" '@{Basic="true"}'
cmd.exe /c winrm set "winrm/config/client/auth" '@{Basic="true"}'
cmd.exe /c winrm set "winrm/config/service/auth" '@{CredSSP="true"}'
cmd.exe /c winrm set "winrm/config/listener?Address=*+Transport=HTTP" '@{Port="5985"}'
cmd.exe /c netsh advfirewall firewall set rule group="remote administration" new enable=yes
cmd.exe /c netsh firewall add portopening TCP 5985 "Port 5985"
cmd.exe /c net stop winrm
cmd.exe /c sc config winrm start= auto
cmd.exe /c net start winrm
# Add account
cmd.exe /c net user ecsadmin /add
cmd.exe /c net localgroup administrators ecsadmin /add
# Rename administrator account
Rename-LocalUser -Name "Administrator" -NewName "xadmin"
# Set Windows virtual memory.
cmd.exe /c wmic computersystem where name="%computername%" set AutomaticManagedPagefile=False
cmd.exe /c wmic pagefileset where name="C:\\pagefile.sys" set InitialSize=4096,MaximumSize=4096