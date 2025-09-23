# 📘 Tutorial (Español) — HTB Search Tool

Este tutorial te guía paso a paso para instalar los requisitos, **clonar el repositorio**, dar permisos al script, **actualizar la base de datos con `-u`** (descargando `bundle.js`) y finalmente usar los filtros principales.

---

## 1) 🔧 Requisitos (instalar herramientas)

> ✅ Compatible con **Linux** y **WSL (Windows Subsystem for Linux)**.  
> 🐚 Recomendado usar **Bash** como shell principal.

Necesitas instalar:

- 📂 **git** → para clonar el repositorio  
- 🌐 **curl** → para descargar el archivo `bundle.js`  
- 🎨 **node-js-beautify** → para formatear el `bundle.js`  
- 🛠️ **moreutils** → proporciona la utilidad `sponge`  

---

### 📥 Instalación rápida

**Debian / Ubuntu (y derivados):**
```bash
sudo apt update && sudo apt install -y git curl node-js-beautify moreutils
```
Fedora / RHEL (y derivados):

bash
Copiar código
sudo dnf install -y git curl moreutils
sudo npm install -g js-beautify
Arch / Manjaro:

bash
Copiar código
sudo pacman -S --needed git curl moreutils
sudo npm install -g js-beautify
ℹ️ Nota: si no tienes npm, instálalo con tu gestor de paquetes antes de ejecutar
npm install -g js-beautify.

2) ⬇️ Clonar el repositorio
Descarga el repositorio oficial de GitHub y entra en la carpeta:

bash
Copiar código
git clone https://github.com/Redz-10111/HTB_Search_Tool.git
cd HTB_Search_Tool
3) ✅ Dar permisos de ejecución
Haz que los scripts sean ejecutables:

bash
Copiar código
chmod +x htbmachines_spanish.sh htbmachines_english.sh
⚠️ Solo necesitas hacerlo la primera vez que clonas el repositorio.
Si ya diste permisos antes, puedes saltar este paso.

4) 🔄 Actualizar la base local (descargar bundle.js)
Ejecuta el script en español con la opción -u.
Esto descargará bundle.js y lo reemplazará solo si el MD5 cambia (evita sobreescribir si no hay cambios).

bash
Copiar código
./htbmachines_spanish.sh -u
📌 Este paso es obligatorio la primera vez para tener la base de datos local.

5) 🚀 Uso básico (consultas rápidas)
Lanza el script en español:

bash
Copiar código
./htbmachines_spanish.sh
🔎 Filtros disponibles
Buscar por nombre

Buscar por dirección IP

Filtrar por sistema operativo (Linux / Windows)

Filtrar por dificultad (Fácil / Media / Difícil / Insane)

Filtrar por certificaciones (eJPT, OSCP, CEH, etc.)

Filtrar por técnicas (SMB, SQLi, LFI, etc.)

Acceder a enlaces de write-ups de S4vitar en YouTube

🧩 Ejemplos de comandos
bash
Copiar código
# Buscar máquina por nombre
./htbmachines_spanish.sh -n "Legacy"

# Buscar por IP
./htbmachines_spanish.sh -i "10.10.10.4"

# Filtrar por sistema operativo
./htbmachines_spanish.sh -o "Linux"

# Filtrar por dificultad
./htbmachines_spanish.sh -d "Fácil"

# Filtrar por certificación
./htbmachines_spanish.sh -c "OSCP"

# Filtrar por técnica
./htbmachines_spanish.sh -t "SMB"

# Actualizar base de datos (bundle.js)
./htbmachines_spanish.sh -u
6) 🧯 Solución de problemas
❌ permission denied → Ejecuta chmod +x ... para dar permisos.

❌ command not found: js-beautify → Instala node-js-beautify.

❌ command not found: sponge → Instala moreutils.

❌ Error al descargar bundle.js → Comprueba tu conexión o vuelve a correr -u.

❌ Conflictos con GitHub al subir cambios → Ejecuta:

bash
Copiar código
git pull --rebase origin main
git push origin main
7) 📎 Enlaces útiles
📦 Repositorio: HTB_Search_Tool

📺 Canal de S4vitar: disponible en los resultados del script

8) 📄 Notas finales
El script fue creado originalmente en Español y luego adaptado al Inglés.

Toda la documentación del repositorio está en inglés para mayor accesibilidad, pero aquí tienes la guía completa en español.
