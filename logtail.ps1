# logtail.ps1
# PrototypeLabs Network AS, Svein Morten Erikstad
# tail utility that tails by default on last *.log file written to (based on LastWriteTime) or explicit named file
Param(
  [string]$filename,
  [int]$len)

$tail = 50;

if($filename.Length -eq 0){
    $f = Get-ChildItem -Path "." -Filter "*.log"
    $f|Sort-Object -Property LastWriteTime -Descending
    $sorted = $f|Sort-Object -Property LastWriteTime -Descending
    $file = $sorted[0].FullName
} else {
    if($filename.Length -gt 0){
        $file =$filename
    }
}

if($len.Length -gt 0){
    $tail = $len
}

Write-Host "Tail with last $tail records on $file"
get-content $file -tail $tail -Wait
