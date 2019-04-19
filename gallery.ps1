Param (
    $Search,
    $ClientID,
    $Path = ".\gallery.htm"
)


$webResponse = Invoke-WebRequest -Uri "https://api.imgur.com/3/gallery/search?q=$Search" -Headers @{Authorization = "Client-ID $ClientID"}
$json = $webResponse.Content | ConvertFrom-Json

$images = $json.Data | Select-Object id, title, link
$position = 0
$imgTemplate = '<blockquote class="imgur-embed-pub" lang="en" data-id="{0}"><a href="{1}">{2}</a></blockquote>'
$gallery = @()
$gallery += '<script async src="https://s.imgur.com/min/embed.js" charset="utf-8"></script><table>'
foreach ($image in $images) {
    if ($position % 5 -eq 0) {
        $row = "<tr>`n"
    }
    $imgTemplate = '<blockquote class="imgur-embed-pub" lang="en" data-id="{0}"><a href="{1}">{2}</a></blockquote>'
    #$row += "  <td>$($image.title)<p><img src='$($image.link)' height=42 width=42></p></td>`n"
    $row += "  <td>"
    $row += $imgTemplate -f $image.id, $image.link, $image.title
    $row += "</td>`n"
    if ($position % 5 -eq 4) {
        $row += "</tr>`n"
        $gallery += $row
    }
    if ($position -ge 24) { break } 
    $position++
}
$gallery += "</table>"
$gallery | Set-Content -Path $Path -Encoding UTF8