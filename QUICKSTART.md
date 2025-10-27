# Guía Rápida: Compilar y Ejecutar Space Invaders en nand2tetris

Esta guía te llevará paso a paso desde la descarga de las herramientas hasta ejecutar el juego en el emulador.

## Paso 1: Descargar e instalar nand2tetris

1. Ve al sitio oficial de nand2tetris: https://www.nand2tetris.org/software
2. Descarga el archivo ZIP del software (normalmente se llama `nand2tetris.zip`)
3. Extrae el archivo ZIP en tu disco C:\ (recomendado) o en otra ubicación que recuerdes
   - Por ejemplo: `C:\nand2tetris\`
   - Después de extraer, deberías tener: `C:\nand2tetris\tools\` con archivos `.jar`, `.bat`, etc.

4. **Requisito**: Necesitas tener Java instalado. Verifica ejecutando en PowerShell:
   ```powershell
   java -version
   ```
   - Si no tienes Java, descárgalo de: https://www.java.com/download/

## Paso 2: Compilar tu proyecto Space Invaders

Abre PowerShell en la carpeta de tu proyecto (`C:\Codigos\Space_Invaders_OC`) y ejecuta:

### Opción A: Usar el script automático (recomendado)

Si instalaste nand2tetris en `C:\nand2tetris\`, ejecuta:
```powershell
.\scripts\build_and_run.ps1
```

Si lo instalaste en otra ubicación, pasa la ruta:
```powershell
.\scripts\build_and_run.ps1 'D:\mi_carpeta\nand2tetris\tools'
```

### Opción B: Compilar manualmente paso a paso

Si prefieres hacerlo manual o el script falla, aquí están los comandos individuales.

**Reemplaza `C:\nand2tetris\tools` con tu ruta real en todos los comandos.**

#### 2.1: Compilar Jack a VM
```powershell
java -jar "C:\nand2tetris\tools\JackCompiler.jar" src
```

Esto creará archivos `.vm` dentro de la carpeta `src/`:
- `src\Main.vm`
- `src\Game.vm`
- `src\Fleet.vm`
- `src\Alien16.vm`
- `src\Sprites.vm`
- `src\Player.vm`
- `src\Bullet.vm`

#### 2.2: Traducir VM a ASM
```powershell
java -jar "C:\nand2tetris\tools\VMTranslator.jar" src
```

Esto creará `src\Main.asm` (o un archivo `.asm` con el nombre del directorio).

#### 2.3: Ensamblar ASM a HACK
```powershell
java -jar "C:\nand2tetris\tools\Assembler.jar" src\Main.asm
```

Esto creará `src\Main.hack` (el archivo ejecutable final).

**Nota**: El nombre exacto del `.asm` puede variar según la versión del VMTranslator. Si ves otro nombre, ajusta el comando en consecuencia.

## Paso 3: Ejecutar en el Hardware Simulator

1. Abre el Hardware Simulator:
   ```powershell
   java -jar "C:\nand2tetris\tools\HardwareSimulator.jar"
   ```

2. En el Hardware Simulator:
   - Ve a `File` → `Load Program`
   - Navega a `C:\Codigos\Space_Invaders_OC\src\` y selecciona el archivo `.hack` generado
   - Haz clic en el botón de "Run" (►) o presiona F5
   - Selecciona "No Animation" o ajusta la velocidad para mejor rendimiento

3. **Controles del juego**:
   - Presiona la tecla **'a'** para mover la nave a la izquierda
   - Presiona la tecla **'d'** para mover la nave a la derecha
   - Presiona la **barra espaciadora** para disparar

## Solución de problemas comunes

### Error: "java no se reconoce como comando"
- Necesitas instalar Java: https://www.java.com/download/
- Después de instalar, reinicia PowerShell

### Error: "No se puede encontrar la ruta especificada"
- Verifica que la ruta a las herramientas sea correcta
- Usa `Get-ChildItem` para listar el contenido:
  ```powershell
  Get-ChildItem "C:\nand2tetris\tools"
  ```

### Los archivos .vm no se generan
- Verifica que los archivos `.jack` en `src/` no tengan errores de sintaxis
- El JackCompiler mostrará los errores en la consola
- Revisa los mensajes de error y corrige el archivo indicado

### El juego va muy lento
- En el Hardware Simulator, selecciona "No Animation" en el menú `Animate`
- Ajusta la velocidad con el slider de velocidad al máximo

### El juego va muy rápido
- Edita `src\game.jack` y aumenta el valor en el busy-wait:
  ```jack
  let t = 0;
  while (t < 12000) {  // aumenta este número
      let t = t + 1;
  }
  ```
- Vuelve a compilar desde el Paso 2.1

## Alternativa: CPU Emulator

Si el Hardware Simulator no funciona bien, puedes usar el CPU Emulator:

```powershell
java -jar "C:\nand2tetris\tools\CPUEmulator.jar"
```

1. En el CPU Emulator:
   - `File` → `Load Program` → selecciona tu `.hack`
   - Haz clic en "Run" (►)
   - La pantalla se mostrará en la ventana del emulador

## Resumen de comandos rápidos

Para futuras compilaciones (una vez que tengas todo configurado):

```powershell
# Desde la raíz del proyecto
cd C:\Codigos\Space_Invaders_OC

# Compilar todo de una vez (reemplaza la ruta si es necesaria)
.\scripts\build_and_run.ps1 'C:\nand2tetris\tools'

# O manual:
java -jar "C:\nand2tetris\tools\JackCompiler.jar" src
java -jar "C:\nand2tetris\tools\VMTranslator.jar" src
java -jar "C:\nand2tetris\tools\Assembler.jar" src\Main.asm
java -jar "C:\nand2tetris\tools\CPUEmulator.jar"
```

## ¿Necesitas ayuda?

Si encuentras problemas:
1. Revisa que Java esté instalado: `java -version`
2. Verifica la ruta de las herramientas de nand2tetris
3. Comprueba que no haya errores de compilación en los archivos `.jack`
4. Revisa los mensajes de error del JackCompiler o VMTranslator

---

**¡Disfruta tu Space Invaders en nand2tetris!** 🚀👾
