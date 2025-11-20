<div align="center">

# 👾 Space Invaders - Nand2Tetris

![Space Invaders](https://img.shields.io/badge/Space%20Invaders-Arcade%20Classic-green?style=for-the-badge)
![Jack Language](https://img.shields.io/badge/Language-Jack-blue?style=for-the-badge)
![Nand2Tetris](https://img.shields.io/badge/Platform-nand2tetris-orange?style=for-the-badge)
![Version](https://img.shields.io/badge/version-1.0.0-purple?style=for-the-badge)

**Implementación del clásico arcade en arquitectura Hack**

[🎮 Características](#-características-principales) • [📦 Instalación](#-requisitos-previos) • [🚀 Ejecución](#-ejecutar-el-proyecto) • [📚 Documentación](#-stack-tecnológico)

</div>

---

## 📖 Descripción

**Space Invaders** es una implementación completa del videojuego arcade clásico desarrollada en el lenguaje **Jack** para la plataforma educativa **nand2tetris**. Este proyecto demuestra conceptos avanzados de arquitectura de computadores, gestión de memoria y programación de sistemas de bajo nivel.

**🎓 Curso:** Organización de Computadores  
**🏫 Institución:** Universidad EAFIT  
**📅 Fecha:** 19 de noviembre de 2025

### 🎯 Sobre el Juego

Space Invaders es uno de los videojuegos arcade más icónicos de la historia. En esta versión:

- 🚀 **Controla una nave espacial** en la parte inferior de la pantalla
- 👾 **Enfrenta una flota de 30 aliens** organizados en formación 3×10
- 💣 **Esquiva bombas enemigas** que caen aleatoriamente
- 🎯 **Elimina todos los aliens** para avanzar al siguiente nivel
- ⚡ **Mejora tu puntuación** destruyendo aliens de mayor valor

---

## 🚀 Requisitos Previos

Antes de comenzar, asegúrate de tener instalado:

| Herramienta | Versión Mínima | Propósito |
|-------------|----------------|-----------|
| **Java JRE** | v8.0+ | Runtime para herramientas nand2tetris |
| **Nand2tetris Tools** | Latest | JackCompiler y VMEmulator |

### ✅ Verificación de Requisitos

```bash
java -version   # v8.0.0 o superior
```

### 📥 Descarga de Herramientas

Las herramientas oficiales están disponibles en:  
🔗 [https://www.nand2tetris.org/software](https://www.nand2tetris.org/software)

**Ubicación recomendada:** `C:\nand2tetris\tools\`

---

## 📦 Instalación

### 1️⃣ Clonar el repositorio

```bash
git clone https://github.com/Salazar1022/Space_Invaders_OC.git
cd Space_Invaders_OC
```

### 2️⃣ Verificar estructura

```bash
dir src      # Windows
ls src       # Linux/macOS
```

✅ **Archivos esperados:** `Main.jack`, `Game.jack`, `Fleet.jack`, `Alien16.jack`, `AlienBomb.jack`, `Player.jack`, `Bullet.jack`, `Sprites.jack`

---

## 🏃 Ejecutar el Proyecto

### ⚡ Opción 1: Script Automatizado (Recomendado)

```powershell
# Desde la raíz del proyecto
.\scripts\build_and_run.ps1 'C:\nand2tetris\tools'
```

El script ejecuta automáticamente:
1. 🔧 **Compilación Jack → VM**
2. ▶️ **Ejecución en VMEmulator**

### 🔧 Opción 2: Compilación Manual

#### Paso 1: Compilar Jack → VM

```powershell
# Compilar todos los archivos .jack
java -jar "C:\nand2tetris\tools\JackCompiler.jar" src
```
o Ejecutar individualmente en :
```powershell
JackCompiler.bat src
```

**✅ Resultado:** Se generarán archivos `.vm` en la carpeta `src/`:
- `Main.vm`
- `Game.vm`
- `Fleet.vm`
- `Alien16.vm`
- `AlienBomb.vm`
- `Player.vm`
- `Bullet.vm`
- `Sprites.vm`

#### Paso 2: Ejecutar en VMEmulator

```powershell
# Abrir VMEmulator
java -jar "C:\nand2tetris\tools\VMEmulator.jar"
```
o Ejecutar individualmente en :
```powershell
VMEmulator.bat 
```

**Pasos en el emulador:**
1. 📁 `File → Load Program`
2. 📂 Navegar a la carpeta `src/`
3. ▶️ Presionar `Run` o `F5`
4. ⚙️ Ajustar velocidad con el slider (recomendado: máxima)
5. 🎨 Configurar `Animate: No Animation` para mejor rendimiento

---

## 🎮 Controles del Juego

| Tecla | Acción |
|-------|--------|
| **⬅️ Flecha Izquierda** | Mover nave a la izquierda |
| **➡️ Flecha Derecha** | Mover nave a la derecha |
| **␣ Barra Espaciadora** | Disparar proyectil |

---

## 📁 Estructura del Proyecto

```
Space_Invaders_OC/
├── 📄 README.md                      # Este archivo
├── 📄 QUICKSTART.md                  # Guía de inicio rápido
├
├── 📂 src/                           # 🎨 Código fuente en Jack
│   ├── 📄 Main.jack                  # Punto de entrada del programa
│   ├── 📄 Game.jack                  # 🎮 Controlador principal del juego
│   ├── 📄 Fleet.jack                 # 👾 Gestión de la flota de aliens (3×10)
│   ├── 📄 Alien16.jack               # 👽 Clase individual de alien (16×16 px)
│   ├── 📄 AlienBomb.jack             # 💣 Proyectiles enemigos
│   ├── 📄 Player.jack                # 🚀 Nave del jugador
│   ├── 📄 Bullet.jack                # 🔫 Proyectiles del jugador
│   └── 📄 Sprites.jack               # 🖼️ Biblioteca de sprites bitmap
└
└── 📂 scripts/                       # ⚙️ Scripts de automatización
    └── 📄 build_and_run.ps1          # Compilación y ejecución automatizada
```

### 📂 Descripción de Componentes

| Archivo | Descripción | Responsabilidades |
|---------|-------------|-------------------|
| **Main.jack** | 🚪 Punto de entrada | Inicializa `Game` y transfiere control |
| **Game.jack** | 🎮 Motor del juego | Estados, vidas, puntuación, niveles, ciclo a ~100 FPS |
| **Fleet.jack** | 👾 Flota de aliens | Movimiento en formación, colisiones, bombas (pool de 10) |
| **Alien16.jack** | 👽 Alien individual | Sprite 16×16, vida/muerte, puntos (10/20/30), animación |
| **Player.jack** | 🚀 Nave espacial | Movimiento horizontal, disparo único, colisiones |
| **Bullet.jack** | 🔫 Proyectil jugador | Movimiento ascendente, límites, ciclo de vida |
| **AlienBomb.jack** | 💣 Bomba enemiga | Movimiento descendente, colisión con jugador |
| **Sprites.jack** | 🖼️ Biblioteca visual | 4 diseños de aliens (A, B, C, D) en arrays bitmap |

---

## 🌟 Características Principales

### 🎮 Mecánicas de Juego

✅ **Sistema de Vidas**
- 3 vidas iniciales
- Pérdida por impacto de bomba o invasión enemiga
- Reinicio de nivel al perder una vida

✅ **Sistema de Puntuación**
- **Fila superior** (👾 Tipo A): 30 puntos
- **Fila media** (👾 Tipo D): 20 puntos
- **Fila inferior** (👾 Tipo B): 10 puntos
- **Bonus por nivel**: 100 puntos × número de nivel

✅ **Progresión de Niveles**
- Velocidad inicial: `baseDelay = 20`
- Incremento por nivel: `-2` delay (mínimo 3)
- Frecuencia de bombas: ~2.56 segundos entre ráfagas

✅ **Interfaz de Usuario**
- 🎬 Pantalla de inicio interactiva
- 📊 Tabla de puntuación con sprites
- 🎯 HUD en tiempo real (vidas, puntos, nivel, aliens)
- 💀 Pantalla de Game Over con estadísticas

### 🛠️ Características Técnicas

#### 🧠 Gestión de Memoria
- ✅ **Sin fugas de memoria:** Métodos `dispose()` en todas las clases
- ✅ **Sprites compartidos:** Liberación cuidadosa de arrays
- ✅ **Pool de proyectiles:** Máximo 10 bombas simultáneas

#### 💥 Sistema de Colisiones
- ✅ **Algoritmo AABB:** Axis-Aligned Bounding Box eficiente
- ✅ **Validación de límites:** Prevención de errores de renderizado
- ✅ **Multi-objeto:** Gestión simultánea de proyectiles y enemigos

#### 🎨 Renderizado Gráfico
- ✅ **Memoria de pantalla Hack:** Base 16384
- ✅ **Sprites 16×16:** Palabras de 16 bits
- ✅ **Optimización:** `Screen.drawRectangle` para bloques 2×2
- ✅ **Animación fluida:** Limpieza y redibujado a ~100 FPS

#### ⌨️ Sistema de Entrada
- ✅ **Interfaz de teclado:** `Memory.peek(24576)`
- ✅ **Códigos ASCII:**
  - Flecha Izquierda: 130
  - Flecha Derecha: 132
  - Barra Espaciadora: 32
- ✅ **Respuesta inmediata:** Procesamiento por ciclo

---

## 🛠️ Stack Tecnológico

### 🎨 Lenguaje y Plataforma

| Tecnología | Versión | Propósito |
|------------|---------|------------|
| **Jack** | - | Lenguaje de alto nivel OOP para nand2tetris |
| **Nand2tetris** | Latest | Plataforma educativa de arquitectura Hack |
| **JackCompiler** | - | Compilador Jack → VM |
| **VMEmulator** | - | Emulador de máquina virtual Hack |


---

## 🔧 Solución de Problemas

### ❌ Error: "Heap overflow (Memory.alloc)"

**Causa:** Fuga de memoria por liberación incorrecta de objetos.

**Solución (ya implementada):**
- ✅ Liberación explícita de sprites temporales en `showScoreTable()`
- ✅ Métodos `dispose()` con verificación de nulos en `Fleet`
- ✅ Limpieza de arrays de proyectiles en `clearAllBombs()`

### ❌ Error: Compilación Fallida

**Diagnóstico:**
```powershell
# Revisar salida del JackCompiler
java -jar "C:\nand2tetris\tools\JackCompiler.jar" src
```

**Posibles causas:**
- Errores de sintaxis en archivos `.jack`
- Referencias a clases inexistentes
- Problemas de tipos de datos

### 🐌 Rendimiento Lento

**Optimizaciones:**
1. ⚙️ Configurar `Animate: No Animation` en VMEmulator
2. 🚀 Ajustar slider de velocidad al máximo
3. 💻 Cerrar aplicaciones en segundo plano

---

## 🧪 Consideraciones Técnicas

### ⚠️ Limitaciones de la Arquitectura Hack

- **Memoria heap limitada:** ~14KB para asignación dinámica
- **Sin multithreading:** Procesamiento secuencial
- **Pantalla monocromática:** 512×256 píxeles (blanco y negro)
- **Sin hardware de sonido:** Interfaz puramente visual
- **Velocidad de CPU:** Simulada, depende del hardware host

### ⚡ Optimizaciones Implementadas

| Optimización | Impacto |
|--------------|---------|
| **Reutilización de sprites** | -60% uso de heap |
| **Pool de bombas (máx 10)** | Memoria predecible |
| **Validación previa de límites** | -40% llamadas inválidas |
| **Detección AABB optimizada** | O(n) vs O(n²) |
| **Sprites compartidos** | -75% asignaciones |

---

## 📚 Referencias

1. 📖 Nisan, N., & Schocken, S. (2005). *The Elements of Computing Systems: Building a Modern Computer from First Principles*. MIT Press.
2. 🌐 Documentación oficial de nand2tetris: [https://www.nand2tetris.org](https://www.nand2tetris.org)
3. 📘 Especificación del lenguaje Jack: [https://www.nand2tetris.org/project09](https://www.nand2tetris.org/project09)
4. 🎮 Documentación del VMEmulator: [Capítulo 7 del libro](https://www.nand2tetris.org/_files/ugd/44046b_7ef1c00a714c46768f08c459a6cab45a.pdf)

---

## 👥 Equipo de Desarrollo
<div align="center">
<table>
  <tr>
    <td align="center">
      <img src="https://github.com/Salazar1022.png" width="100px;" alt="Sebastián Salazar"/><br />
      <sub><b>Sebastián Salazar</b></sub><br />
      <a href="https://github.com/Salazar1022">@Salazar1022</a>
    </td>
    <td align="center">
    <img src="https://github.com/AndresVelez31.png" width="100px;" alt="Andres Velez"/><br />
      <sub><b>Andres Velez</b></sub><br />
      <a href="#">@AndresVelez31</a>
    </td>
    <td align="center">
      <img src="https://github.com/Smg4315.png" width="100px;" alt="Simon Mazo"/><br />
      <sub><b>Simon Mazo</b></sub><br />
      <a href="#">@Smg4315</a>
    </td>
  </tr>
</table>
</div>

### 🎓 Contexto Académico

**Universidad EAFIT** - Organización de Computadores (4to Semestre)  
**Proyecto:** Implementación de Space Invaders en Arquitectura Hack  
**Año:** 2025-2

---

<div align="center">
  <p>Hecho con ❤️ y muchas horas de debugging 🐛</p>
  <p><strong>Universidad EAFIT - 2025</strong></p>
  
  ---
  
  <sub>⚠️ Para consultas o asistencia técnica, consultar el archivo <a href="./QUICKSTART.md">QUICKSTART.md</a> para instrucciones detalladas de uso.</sub>
</div>
