# Detect if Ollama is installed and running
param(
    [switch]$CheckRunning
)

$ollamaPath = Get-Command ollama -ErrorAction SilentlyContinue

if (-not $ollamaPath) {
    Write-Host "OLLAMA_NOT_FOUND"
    exit 1
}

Write-Host "OLLAMA_PATH: $($ollamaPath.Source)"

if ($CheckRunning) {
    try {
        $response = Invoke-RestMethod -Uri "http://localhost:11434/api/tags" -TimeoutSec 5
        Write-Host "OLLAMA_RUNNING: true"
        Write-Host "OLLAMA_VERSION: $($response.version ?? 'unknown')"
    } catch {
        Write-Host "OLLAMA_RUNNING: false"
        Write-Host "OLLAMA_ERROR: $_"
        exit 2
    }
}
