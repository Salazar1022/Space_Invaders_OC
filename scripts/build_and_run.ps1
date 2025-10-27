<#
  build_and_run.ps1

  Script PowerShell para compilar el proyecto Jack -> VM -> ASM -> HACK
  Uso: .\build_and_run.ps1 [ruta_a_tools]
  Si no se pasa ruta, usa 'C:\nand2tetris\tools' por defecto.
#>

param (
    [string]$ToolsPath = 'C:\nand2tetris\tools'
)

Write-Host "Usando tools en: $ToolsPath"

function Run-JackCompiler {
    param($tools, $src)
    if (Test-Path (Join-Path $tools 'JackCompiler.jar')) {
        Write-Host "Ejecutando JackCompiler.jar..."
        & java -jar (Join-Path $tools 'JackCompiler.jar') $src
        return $LASTEXITCODE
    }
    if (Test-Path (Join-Path $tools 'JackCompiler.bat')) {
        Write-Host "Ejecutando JackCompiler.bat..."
        & (Join-Path $tools 'JackCompiler.bat') $src
        return $LASTEXITCODE
    }
    if (Test-Path (Join-Path $tools 'JackCompiler.exe')) {
        Write-Host "Ejecutando JackCompiler.exe..."
        & (Join-Path $tools 'JackCompiler.exe') $src
        return $LASTEXITCODE
    }
    Write-Error "No se encontró JackCompiler en $tools"
    return 1
}

function Run-VMTranslator {
    param($tools, $src)
    if (Test-Path (Join-Path $tools 'VMTranslator.jar')) {
        Write-Host "Ejecutando VMTranslator.jar..."
        & java -jar (Join-Path $tools 'VMTranslator.jar') $src
        return $LASTEXITCODE
    }
    if (Test-Path (Join-Path $tools 'VMTranslator.bat')) {
        Write-Host "Ejecutando VMTranslator.bat..."
        & (Join-Path $tools 'VMTranslator.bat') $src
        return $LASTEXITCODE
    }
    Write-Error "No se encontró VMTranslator en $tools"
    return 1
}

function Run-Assembler {
    param($tools, $asmPath)
    if (Test-Path (Join-Path $tools 'Assembler.jar')) {
        Write-Host "Ejecutando Assembler.jar en $asmPath ..."
        & java -jar (Join-Path $tools 'Assembler.jar') $asmPath
        return $LASTEXITCODE
    }
    if (Test-Path (Join-Path $tools 'Assembler.bat')) {
        Write-Host "Ejecutando Assembler.bat en $asmPath ..."
        & (Join-Path $tools 'Assembler.bat') $asmPath
        return $LASTEXITCODE
    }
    Write-Error "No se encontró Assembler en $tools"
    return 1
}

$srcDir = Join-Path (Get-Location) 'src'
if (-not (Test-Path $srcDir)) {
    Write-Error "No se encontró la carpeta src en $(Get-Location). Ejecuta el script desde la raíz del repo."
    exit 1
}

# 1) Jack -> VM
$rc = Run-JackCompiler -tools $ToolsPath -src $srcDir
if ($rc -ne 0) { Write-Error "JackCompiler falló (rc=$rc)"; exit $rc }

# 2) VM -> ASM
$rc = Run-VMTranslator -tools $ToolsPath -src $srcDir
if ($rc -ne 0) { Write-Error "VMTranslator falló (rc=$rc)"; exit $rc }

# 3) Buscar .asm generado
$asmFiles = Get-ChildItem -Path $srcDir -Filter *.asm -Recurse | Sort-Object LastWriteTime -Descending
if ($asmFiles.Count -eq 0) {
    Write-Error "No se encontró ningún archivo .asm en $srcDir después de VMTranslator"
    exit 1
}

# Preferir src.asm si existe
$asm = $asmFiles | Where-Object { $_.Name -eq 'src.asm' } | Select-Object -First 1
if (-not $asm) { $asm = $asmFiles[0] }

Write-Host "Usando archivo asm: $($asm.FullName)"

# 4) ASM -> HACK (Assembler)
$rc = Run-Assembler -tools $ToolsPath -asmPath $asm.FullName
if ($rc -ne 0) { Write-Error "Assembler falló (rc=$rc)"; exit $rc }

# Determinar path del .hack
$hackPath = [System.IO.Path]::ChangeExtension($asm.FullName, '.hack')
if (-not (Test-Path $hackPath)) {
    # algunos Assembler colocan el .hack en la misma carpeta con otro nombre; buscar el más reciente
    $hackFiles = Get-ChildItem -Path $srcDir -Filter *.hack -Recurse | Sort-Object LastWriteTime -Descending
    if ($hackFiles.Count -gt 0) { $hackPath = $hackFiles[0].FullName }
}

if (-not (Test-Path $hackPath)) {
    Write-Error "No se encontró el .hack resultante. Comprueba la salida del Assembler."
    exit 1
}

Write-Host "Generado .hack en: $hackPath"

# 5) Abrir Hardware Simulator (si está disponible)
$hwJar = Join-Path $ToolsPath 'HardwareSimulator.jar'
if (Test-Path $hwJar) {
    Write-Host "Lanzando Hardware Simulator..."
    Start-Process -FilePath 'java' -ArgumentList "-jar `"$hwJar`"" -NoNewWindow
    Write-Host "Abre el Hardware Simulator y carga el archivo: $hackPath"
} else {
    Write-Host "No se encontró HardwareSimulator.jar en $ToolsPath. Carga manualmente el archivo .hack en el simulador."
}

Write-Host "Hecho."
exit 0
