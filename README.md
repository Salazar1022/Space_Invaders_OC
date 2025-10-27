Space Invaders (nand2tetris)

Este repositorio contiene una versión minimalista de Space Invaders escrita en Jack para ejecutarse en la plataforma nand2tetris (Hardware Simulator / CPU Emulator).

Estructura principal
- `src/` - Contiene los archivos `.jack` del proyecto:
  - `main.jack`, `game.jack`, `fleet.jack`, `alien16.jack`, `sprites.jack`, `Player.jack`, `Bullet.jack`.

Resumen de funcionamiento
- El juego dibuja una flota de aliens (cada uno 16x16 alineado a word) y un jugador en la parte inferior.
- Controles: tecla 'a' (izquierda), 'd' (derecha), espacio (disparo). El código lee la dirección de memoria del teclado (24576) para detectar la tecla.
- La pantalla usa la memoria de pantalla estándar del Hack (base 16384). Las posiciones y sprites están alineados en palabras (16 px de ancho).

Cómo compilar y ejecutar (PowerShell / Windows)

Requisitos: tener instaladas las herramientas de nand2tetris (JackCompiler, VMTranslator, Assembler). Si usas la distribución oficial, estas utilidades están en la carpeta `tools` de la instalación de nand2tetris.

1) Compilar los archivos Jack a VM

Reemplaza la ruta del ejemplo por la ruta real donde tienes las utilidades. A continuación hay ejemplos con dos alternativas comunes:

Opción A — Usando el jar del JackCompiler (ejemplo genérico):

```powershell
java -jar "C:\ruta\a\tools\JackCompiler.jar" src
```

Opción B — Usando un script/bat que venga con tu instalación (si existe):

```powershell
& 'C:\ruta\a\tools\JackCompiler.bat' src
# o
& 'C:\ruta\a\tools\JackCompiler.exe' src
```

Esto generará archivos `.vm` dentro de `src/` (uno por clase o varios, según el compilador).

2) Traducir VM a ASM

Ejemplo (ajusta según la utilidad disponible):

```powershell
java -jar "C:\ruta\a\tools\VMTranslator.jar" src
# o
& 'C:\ruta\a\tools\VMTranslator.bat' src
```

Esto generará un archivo `.asm` (por lo general con el nombre de la carpeta `src`) en la misma carpeta.

3) Ensamblar `.asm` a `.hack`

```powershell
& 'C:\ruta\a\tools\Assembler.bat' src\src.asm
# o con jar
java -jar "C:\ruta\a\tools\Assembler.jar" src\src.asm
```

Luego obtendrás `src.hack` (o el nombre que corresponda), que puedes cargar en el Hardware Simulator.

4) Ejecutar en el Hardware Simulator

- Abre el Hardware Simulator (o CPU Emulator según versión). Carga el archivo `.hack` en la opción `File -> Load program`.
- Inicializa la simulación y dale `run`/`stop` según tu herramienta.

Notas útiles / debugging
- Memoria de pantalla: base 16384 (el código usa `Memory.poke` en `Alien16` y `Player`).
- Teclado: lectura en `Memory.peek(24576)` devuelve el código ASCII de la tecla presionada (0 si no hay tecla). En el juego actual: 'a' = 97, 'd' = 100, espacio = 32.
- Si la flota no se mueve o el juego está demasiado rápido/lento, ajusta las constantes de espera en `game.jack` (ese demo usa busy-waits) o en `Fleet` si cambias la temporización.

Problemas comunes
- "No encuentro JackCompiler": asegúrate de descargar e instalar la suite nand2tetris y apunta las rutas en los comandos anteriores.
- Errores de compilación Jack: revisa el output del JackCompiler; las líneas y clases problemáticas se informan en la consola.

Próximos pasos sugeridos
- Añadir soporte para múltiples balas, vidas, puntuación y fin de juego.
- Reemplazar busy-waits por un temporizador más consistente si tienes una clase `Sys` o similar.

Si quieres, puedo:
- Generar un script PowerShell completo que compile todo y abra automáticamente el Hardware Simulator (si me confirmas la ubicación de las utilidades),
- O seguir implementando mejoras (más balas, puntaje, colisiones más finas, animación).

---
Fecha: 26 de octubre de 2025
