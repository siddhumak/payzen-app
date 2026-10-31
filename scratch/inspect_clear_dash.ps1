Add-Type -AssemblyName System.Drawing

$srcPath = 'C:\Users\trish\.gemini\antigravity\brain\d841c7b7-eb7c-4421-bf19-1c116865ed72\.user_uploaded\media_1793470487258_4434dfc9.jpg'
$src = [System.Drawing.Bitmap]::FromFile($srcPath)
Write-Output "Image size: $($src.Width) x $($src.Height)"
$src.Dispose()

