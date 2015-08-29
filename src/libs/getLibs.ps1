$client = new-object System.Net.WebClient 
$shell_app = new-object -com shell.application
$scriptpath = $MyInvocation.MyCommand.Path
$dir = Split-Path $scriptpath
$filename = "google-gson-2.3.1-release.zip"

Write-Host "Downloading Google Gson 2.3.1"
$client.DownloadFile("http://google-gson.googlecode.com/files/google-gson-2.3.1-release.zip", "$dir\$filename") 

Write-Host "Decompressing..."
$zip_file = $shell_app.namespace("$dir\$filename")
$destination = $shell_app.namespace("$dir")
$destination.Copyhere($zip_file.items())

Write-Host "Removing zip file"
Remove-Item "$dir\$filename"

Write-Host "Move library to current folder"
Move-Item "$dir\google-gson-2.3.1\gson-2.3.1.jar" "$dir"

Write-Host "Remove extra files"
Remove-Item "$dir\google-gson-2.3.1\" -recurse
