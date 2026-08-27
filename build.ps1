$ErrorActionPreference = 'Stop'
$projectRoot = $PSScriptRoot
$distRoot = Join-Path $projectRoot 'dist'
$serverRoot = Join-Path $distRoot 'server'

if (Test-Path -LiteralPath $distRoot) {
  Remove-Item -LiteralPath $distRoot -Recurse -Force
}
New-Item -ItemType Directory -Path $serverRoot -Force | Out-Null

$assetTypes = @{
  '.html' = 'text/html; charset=utf-8'
  '.css' = 'text/css; charset=utf-8'
  '.js' = 'text/javascript; charset=utf-8'
  '.json' = 'application/json; charset=utf-8'
  '.webmanifest' = 'application/manifest+json; charset=utf-8'
  '.svg' = 'image/svg+xml; charset=utf-8'
}
$sourceFiles = @(
  'index.html','index_sign.html','index_renshuu.html','nihongo_vocab-5.html',
  'kanji-detail.js','words.json','n3.html','n3.css','n3-data.js','n3-app.js',
  'manifest.webmanifest','n3-icon.svg','sw.js'
)
$files = [ordered]@{}
foreach ($name in $sourceFiles) {
  $path = Join-Path $projectRoot $name
  if (-not (Test-Path -LiteralPath $path)) { throw "Missing source asset: $name" }
  $extension = [IO.Path]::GetExtension($name).ToLowerInvariant()
  $files['/' + $name] = [ordered]@{
    type = $assetTypes[$extension]
    body = [IO.File]::ReadAllText($path, [Text.Encoding]::UTF8)
  }
}
$files['/'] = $files['/index.html']
$payload = $files | ConvertTo-Json -Compress -Depth 5
$worker = @"
const FILES = $payload;
export default {
  async fetch(request) {
    const url = new URL(request.url);
    let path = decodeURIComponent(url.pathname);
    if (path.endsWith('/')) path += 'index.html';
    if (path === '/index.html') path = '/';
    const file = FILES[path];
    if (!file) return new Response('Not found', { status: 404 });
    const headers = {
      'content-type': file.type,
      'x-content-type-options': 'nosniff',
      'referrer-policy': 'strict-origin-when-cross-origin',
      'cache-control': path === '/sw.js' ? 'no-cache' : 'public, max-age=300'
    };
    return new Response(file.body, { status: 200, headers });
  }
};
"@
[IO.File]::WriteAllText((Join-Path $serverRoot 'index.js'), $worker, (New-Object Text.UTF8Encoding($false)))
Write-Output "Built $($sourceFiles.Count) assets into dist/server/index.js"
