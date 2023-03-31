$ip = Read-Host "Enter target IP address:"
$portRange = Read-Host "Enter port range to scan (e.g. 1-1024):"

$startPort = [int]($portRange.Split('-')[0])
$endPort = [int]($portRange.Split('-')[1])

Write-Host "Scanning $ip for open ports..."

for ($port=$startPort; $port -le $endPort; $port++) {
  $socket = New-Object System.Net.Sockets.TcpClient
  $connection = $socket.BeginConnect($ip, $port,$null,$null)
  
  Start-Sleep -Milliseconds 100

  if ($connection.AsyncWaitHandle.WaitOne(50,$false)) {
    Write-Host "Port $port is open"
  } else {
    Write-Host "Port $port is closed"
  }
  $socket.Close()
}