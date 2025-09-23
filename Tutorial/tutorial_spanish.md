# 📘 Tutorial (Español) — HTB Search Tool

Este tutorial te guía paso a paso para instalar los requisitos, **clonar el repositorio**, dar permisos al script, **actualizar la base de datos con `-u`** (descargando `bundle.js`) y finalmente usar los filtros principales.

---

## 1) 🔧 **Requisitos (instalar herramientas)**

> ✅ Compatible con **Linux** y **WSL (Windows Subsystem for Linux)**.  
> 🐚 Recomendado usar **Bash** como shell principal.

Necesitas instalar:

- 📂 **git** → para clonar el repositorio 
- 🌐 **curl** → para descargar el archivo `bundle.js`  
- 🎨 **node-js-beautify** → para formatear el `bundle.js`  
- 🛠️ **moreutils** → proporciona la utilidad `sponge`  

---

## 📥 **Instalación rápida**

### **Debian / Ubuntu (derivados):**
Copiar código
```bash
sudo apt update && sudo apt install -y git curl node-js-beautify moreutils
```
### **Fedora / RHEL (y derivados):**

Copiar código
```bash
Copiar código
sudo dnf install -y git curl moreutils
sudo npm install -g js-beautify
```
### **Arch / Manjaro:**

Copiar código
````bash
sudo pacman -S --needed git curl moreutils
sudo npm install -g js-beautify
````
ℹ️ Nota: si no tienes npm, instálalo con tu gestor de paquetes antes de ejecutar
npm install -g js-beautify.

## 2) ⬇️ **Clonar el repositorio**
Descarga el repositorio oficial de GitHub y entra en la carpeta:

Copiar código
```bash
git clone --no-checkout --depth 1 https://github.com/Redz-10111/HTB_Search_Tool.git
cd HTB_Search_Tool
git sparse-checkout init --cone
git sparse-checkout set htbmachines_english.sh htbmachines_spanish.sh
git checkout main
```

## 3) ✅ **Dar permisos de ejecución**
Haz que los scripts sean ejecutables:

Copiar código
```bash
chmod +x htbmachines_spanish.sh htbmachines_english.sh
```
⚠️ Solo necesitas hacerlo la primera vez que clonas el repositorio.
Si ya diste permisos antes, puedes saltar este paso.

## 4) 🔄 **Actualizar la base local (descargar bundle.js)**
Ejecuta el script en español con la opción -u.
Esto descargará bundle.js y lo reemplazará solo si el MD5 cambia (evita sobreescribir si no hay cambios).

Copiar código
```bash
./htbmachines_spanish.sh -u
```
📌 Este paso es obligatorio la primera vez para tener la base de datos en local.

## 5) 🚀 **Uso básico (consultas rápidas)**
Lanza el script en español:

Copiar código
```bash
./htbmachines_spanish.sh
```
### 🔎 **Filtros y opciones disponibles**

El script ofrece múltiples opciones de búsqueda y utilidades:

- 🟡 **`-u`** → Descargar o actualizar archivos necesarios (`bundle.js`)  
- 🟣 **`-m`** → Buscar por **nombre de máquina**  
- 🟣 **`-i`** → Buscar por **dirección IP**  
- 🟣 **`-d`** → Filtrar por **dificultad** (Fácil, Media, Difícil, Insane)  
- 🟣 **`-o`** → Filtrar por **sistema operativo** (Linux / Windows)  
- 🟣 **`-s`** → Filtrar por **skills** (ej. SMB, SQLi, LFI, etc.)  
- 🟣 **`-c`** → Filtrar por **certificaciones** (eJPT, OSCP, CEH, etc.)  
- 🟣 **`-y`** → Obtener link directo a la **resolución de la máquina en YouTube**  
- 🟣 **`-h`** → Mostrar el **panel de ayuda**, que resume todas las opciones disponibles  

---

### 6) **🆘 Panel de ayuda**

El script incluye un **menú interactivo de ayuda** que muestra todas las opciones de uso.  
Ejecuta:

```bash
./htbmachines_spanish.sh -h
```
👉 Esto mostrará algo como:

Copiar código
```bash
[+] Uso:
    u) Descargar o actualizar archivos necesarios
    m) Buscar por un nombre de máquina
    i) Buscar por dirección IP
    d) Buscar por la dificultad de una máquina
    o) Buscar por el sistema operativo
    s) Buscar por Skills
    c) Filtrar por certificaciones
    y) Obtener link de la resolución de la máquina en YouTube
    h) Mostrar este panel de ayuda
```

## 7) 🧯 **Solución de problemas**
❌ permission denied → Ejecuta chmod +x ... para dar permisos.

❌ command not found: js-beautify → Instala node-js-beautify.

❌ command not found: sponge → Instala moreutils.

❌ Error al descargar bundle.js → Comprueba tu conexión o vuelve a correr -u.

❌ Conflictos con GitHub al subir cambios → Ejecuta:



