# Script para descargar e instalar nand2tetris correctamente
# Este script descarga la versión oficial y la extrae en C:\nand2tetris

$url = "https://drive.google.com/uc?export=download&id=1xZzcMIUETv3u3sdpM_oTJSTetpVee3KZ"
$zipPath = "$env:TEMP\nand2tetris.zip"
$extractPath = "C:\"

Write-Host "Descargando nand2tetris..."
Write-Host "NOTA: Si la descarga falla, descarga manualmente desde:"
Write-Host "https://www.nand2tetris.org/software"
Write-Host ""

try {
    # Intentar descargar
    Invoke-WebRequest -Uri $url -OutFile $zipPath -UseBasicParsing
    
    Write-Host "Extrayendo archivos..."
    
    # Limpiar instalación anterior si existe
    if (Test-Path "C:\nand2tetris") {
        Write-Host "Eliminando instalación anterior..."
        Remove-Item "C:\nand2tetris" -Recurse -Force
    }
    
    # Extraer
    Expand-Archive -Path $zipPath -DestinationPath $extractPath -Force
    
    # Limpiar temporal
    Remove-Item $zipPath -Force
    
    Write-Host ""
    Write-Host "✓ Instalación completada en C:\nand2tetris"
    Write-Host ""
    Write-Host "Ahora puedes compilar con:"
    Write-Host "  .\scripts\build_and_run.ps1"
    
} catch {
    Write-Host ""
    Write-Host "ERROR: La descarga automática falló."
    Write-Host ""
    Write-Host "Por favor descarga manualmente:"
    Write-Host "1. Ve a: https://www.nand2tetris.org/software"
    Write-Host "2. Descarga 'Nand2tetris Software Suite'"
    Write-Host "3. Extrae el ZIP en C:\ (debe quedar C:\nand2tetris\tools\)"
    Write-Host "4. Ejecuta: .\scripts\build_and_run.ps1"
    Write-Host ""
    Write-Host "Error detallado: $_"
}
