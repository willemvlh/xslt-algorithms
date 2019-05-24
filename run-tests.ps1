Get-ChildItem -Recurse -Filter "*test.xsl" | ForEach{
    $file = $_.FullName
    $shortFile = $_.BaseName
    $tmp=New-TemporaryFile
    $start = Get-Date
    $x = java -jar C:\Saxon\saxon.jar -xsl:$_.FullName -s:"test-dummy.xml" 2> $tmp
    $err = Get-Content -Path $tmp
    $end = Get-Date
    $duration = ($end.Subtract($start).Milliseconds / 1000).ToString() + "s"
    if($err) {
        $reason = $err.Item(0)
     Write-Host "Failed: $shortFile -> $reason" -ForegroundColor Red
    }
    else{
    Write-Host "Passed: $shortFile ($duration)" -ForegroundColor Green
    }
}