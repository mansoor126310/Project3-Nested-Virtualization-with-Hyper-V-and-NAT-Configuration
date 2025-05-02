Write-Host "`n==== NETWORK VERIFICATION ====" -ForegroundColor Cyan
Write-Host "`n[1] IP Configuration:" -ForegroundColor Yellow
ipconfig

Write-Host "`n[2] Default Gateway Reachability (192.168.200.1):" -ForegroundColor Yellow
ping -n 2 192.168.200.1

Write-Host "`n[3] DNS Resolution Test (ping google.com):" -ForegroundColor Yellow
ping google.com

Write-Host "`n[4] Internet Test (ping 8.8.8.8):" -ForegroundColor Yellow
ping 8.8.8.8

Write-Host "`n==== DONE ====" -ForegroundColor Cyan
