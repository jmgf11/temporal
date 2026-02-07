# 🚀 GUÍA COMPLETA: Instalar tu Agente Autónomo (Configuración Híbrida)

## 📋 Índice Rápido

1. [Preparar tu VM Ubuntu](#paso-1-preparar-tu-vm-ubuntu)
2. [Transferir archivos a la VM](#paso-2-transferir-archivos-a-la-vm)
3. [Instalación Automática](#paso-3-instalación-automática)
4. [Configurar Ollama (GRATIS)](#paso-4-configurar-ollama-gratis)
5. [Configurar Claude (Opcional, $5 gratis)](#paso-5-configurar-claude-opcional-5-gratis)
6. [Verificar Todo](#paso-6-verificar-todo)
7. [¡Usar tu Agente!](#paso-7-usar-tu-agente)
8. [Ejemplos Prácticos](#paso-8-ejemplos-prácticos)
9. [Solución de Problemas](#solución-de-problemas)

---

## 🎯 Configuración Recomendada: HÍBRIDA

**Usa Claude mientras tengas crédito gratis ($5) → Cambia automáticamente a Ollama cuando se acabe**

**Beneficios:**
- ✅ Mejor calidad al inicio (Claude)
- ✅ Gratis para siempre después (Ollama)
- ✅ Sin interrupciones (fallback automático)
- ✅ Flexibilidad total

---

## PASO 1: Preparar tu VM Ubuntu

### 1.1 Crear/Iniciar VM

**Requisitos Mínimos:**
- **OS**: Ubuntu 22.04 LTS o superior
- **RAM**: 8GB (16GB ideal)
- **Disco**: 25GB libres
- **CPU**: 2 cores mínimo

**Opciones de VM:**
- VirtualBox (gratis)
- VMware Workstation
- Hyper-V (Windows Pro)
- Cloud (AWS, DigitalOcean, etc.)

### 1.2 Configuración Inicial de Ubuntu

```bash
# Conectarte a la VM
# Si es local: abre la VM directamente
# Si es remota: ssh usuario@ip-de-la-vm

# Una vez dentro, actualizar sistema
sudo apt update && sudo apt upgrade -y

# Verificar espacio disponible
df -h
# Necesitas al menos 20GB libres

# Verificar RAM
free -h
# Necesitas al menos 8GB
```

---

## PASO 2: Transferir Archivos a la VM

### Opción A: Transferir con SCP (recomendado)

**Desde tu computadora principal:**

```bash
# Ubicarte donde descargaste el archivo
cd ~/Descargas  # o donde esté el archivo

# Transferir a la VM
scp agente-autonomo-completo.tar.gz usuario@IP_DE_VM:~/

# Ejemplo real:
# scp agente-autonomo-completo.tar.gz juan@192.168.1.100:~/
```

### Opción B: Usar Carpeta Compartida (VirtualBox/VMware)

1. En VirtualBox/VMware: Configurar carpeta compartida
2. En Ubuntu VM: Acceder a la carpeta compartida
3. Copiar archivo: `cp /mnt/shared/agente-autonomo-completo.tar.gz ~/`

### Opción C: Descargar Directamente en VM

```bash
# Si tienes el archivo en algún servidor/GitHub
wget URL_DEL_ARCHIVO
# o
curl -O URL_DEL_ARCHIVO
```

### Verificar que llegó el archivo:

```bash
ls -lh ~/agente-autonomo-completo.tar.gz
# Deberías ver: agente-autonomo-completo.tar.gz (20K aprox)
```

---

## PASO 3: Instalación Automática

### 3.1 Descomprimir el Proyecto

```bash
# Ubicarte en tu home
cd ~

# Descomprimir
tar -xzf agente-autonomo-completo.tar.gz

# Entrar al directorio
cd agente-autonomo

# Verificar contenido
ls -la
# Deberías ver: install.sh, main.py, README.md, etc.
```

### 3.2 Ejecutar el Instalador

```bash
# Hacer ejecutable el instalador
chmod +x install.sh

# Ejecutar instalación
./install.sh
```

**El instalador te preguntará qué proveedor quieres:**

```
═══════════════════════════════════════════
  IMPORTANTE: Elige tu proveedor de IA   
═══════════════════════════════════════════

1. 🆓 Ollama - 100% GRATIS (local)
2. 💳 Claude - De pago ($5 gratis al registrarte)
3. 🔀 Ambos - Ollama como fallback

Selecciona (1/2/3): 
```

**✅ SELECCIONA: 3** (para configuración híbrida)

### 3.3 Seleccionar Modelo de Ollama

```
¿Qué modelo descargar?
1. llama3.1 (8GB RAM) - Recomendado
2. llama3.2:3b (4GB RAM) - Para PCs con poca RAM
3. mistral (8GB RAM) - Alternativa rápida

Selecciona (1/2/3): 
```

**✅ SELECCIONA: 1** (llama3.1 - recomendado)

**⏳ Esto descargará el modelo (4-5GB, tardará 5-15 minutos)**

### 3.4 Esperar a que Termine

El instalador hará:
- ✅ Instalar dependencias del sistema
- ✅ Crear entorno virtual Python
- ✅ Instalar librerías Python
- ✅ Instalar Playwright
- ✅ Instalar Ollama
- ✅ Descargar modelo llama3.1
- ✅ Iniciar servidor Ollama
- ✅ Crear archivo .env

**Verás algo como:**

```
✅ Ollama configurado
✓ Servidor Ollama iniciado

🔑 También configura tu API key de Claude
Edita .env y agrega ANTHROPIC_API_KEY
El agente usará Claude mientras tengas crédito,
y cambiará automáticamente a Ollama cuando se acabe.
```

---

## PASO 4: Configurar Ollama (GRATIS)

### 4.1 Verificar que Ollama Está Corriendo

```bash
# Verificar servicio
curl http://localhost:11434/api/tags

# Si ves algo como {"models":[...]}, está funcionando ✅
# Si da error, iniciar manualmente:
ollama serve &
```

### 4.2 Verificar Modelo Descargado

```bash
# Listar modelos instalados
ollama list

# Deberías ver algo como:
# NAME            SIZE
# llama3.1:latest 4.7GB
```

### 4.3 Probar Ollama (Opcional)

```bash
# Chat de prueba
ollama run llama3.1

# Escribe algo:
>>> Hola, ¿cómo estás?

# Debería responder. Para salir:
>>> /bye
```

**✅ Ollama Listo!** Ya tienes IA gratis funcionando.

---

## PASO 5: Configurar Claude (Opcional, $5 gratis)

### 5.1 Registrarte en Anthropic

1. **Ir a:** https://console.anthropic.com/
2. **Hacer click en:** "Sign Up" o "Get Started"
3. **Crear cuenta:**
   - Usar email (Gmail, etc.)
   - Verificar email
   - Completar perfil

4. **¡Recibes $5 de crédito gratis!** 🎉

### 5.2 Crear API Key

1. En el dashboard de Anthropic
2. Ir a: **"API Keys"** (menú izquierdo)
3. Click: **"Create Key"**
4. Darle un nombre: "agente-autonomo"
5. **Copiar la clave** (empieza con `sk-ant-api03-...`)
   
   ⚠️ **IMPORTANTE:** Solo se muestra una vez, cópiala bien!

### 5.3 Configurar la API Key en .env

```bash
# Editar archivo de configuración
nano .env

# Buscar la línea:
ANTHROPIC_API_KEY=

# Pegar tu clave (Ctrl+Shift+V):
ANTHROPIC_API_KEY=sk-ant-api03-TU_CLAVE_AQUI_MUY_LARGA

# Guardar: Ctrl+O, Enter
# Salir: Ctrl+X
```

**Ejemplo de .env configurado:**

```env
# Proveedores de LLM
ANTHROPIC_API_KEY=sk-ant-api03-xxxxxxxxxxxxxxxxxxxxx
OLLAMA_MODEL=llama3.1
OLLAMA_BASE_URL=http://localhost:11434

# Configuración
AGENT_NAME=MiAgente
ALLOW_BASH=true
```

**✅ Claude Configurado!** Tienes $5 de crédito.

---

## PASO 6: Verificar Todo

### 6.1 Activar Entorno Virtual

```bash
# Asegurarte de estar en el directorio del proyecto
cd ~/agente-autonomo

# Activar entorno virtual
source venv/bin/activate

# Tu prompt cambiará a:
(venv) usuario@ubuntu:~/agente-autonomo$
```

### 6.2 Verificar Proveedores

```bash
# Ejecutar script de verificación
python check_providers.py
```

**Deberías ver algo como:**

```
╔═══════════════════════════════════════════════════════╗
║     🔍  VERIFICADOR DE PROVEEDORES DE IA  🔍         ║
╚═══════════════════════════════════════════════════════╝

1️⃣  Anthropic (Claude)
   ✅ Disponible
   📝 API Key: sk-ant-api...xYz4
   🎯 Modelo: claude-sonnet-4-20250514

2️⃣  OpenAI (GPT)
   ❌ No configurada

3️⃣  Ollama (Local - GRATIS)
   ✅ Disponible y corriendo
   🌐 URL: http://localhost:11434
   🎯 Modelo: llama3.1
   📚 Modelos instalados: 1
   📋 Modelos:
      • llama3.1:latest (4.7GB)

═══════════════════════════════════════════════════════
✅ Proveedores disponibles: Anthropic, Ollama (GRATIS)

🚀 Puedes iniciar el agente con:
   python main.py cli
```

**✅ Si ves esto, TODO ESTÁ LISTO!**

---

## PASO 7: ¡Usar tu Agente!

### 7.1 Modo CLI (Terminal)

```bash
# Asegurarte que venv está activo
source venv/bin/activate

# Iniciar agente
python main.py cli
```

**Verás:**

```
╔═══════════════════════════════════════════════════════╗
║                                                       ║
║          🤖  AGENTE AUTÓNOMO  🤖                      ║
║                                                       ║
║  Tu asistente de IA con capacidades de:              ║
║    • Ejecutar comandos bash                          ║
║    • Navegar en la web                               ║
║    • Manipular archivos                              ║
║    • Ejecutar código Python                          ║
║                                                       ║
╚═══════════════════════════════════════════════════════╝

✅ Agente 'MiAgente' inicializado correctamente
📊 Modelo: claude-sonnet-4-20250514
🔧 Herramientas disponibles: 4
📋 Proveedores disponibles: Anthropic, Ollama (GRATIS)
🎯 Proveedor activo: Anthropic Claude (claude-sonnet-4-20250514)

Escribe /help para ver los comandos disponibles

💬 Tú: 
```

### 7.2 Primeros Comandos

**Prueba estos comandos uno por uno:**

```
1. Hola, preséntate y dime qué puedes hacer

2. Lista los archivos en mi directorio actual

3. Crea un archivo llamado test.txt con el contenido "Hola desde el agente autónomo"

4. Lee el archivo test.txt y confírmame su contenido

5. Ejecuta el comando 'df -h' y dime cuánto espacio libre tengo

6. Busca en internet quién creó Python y en qué año
```

### 7.3 Comandos Especiales del CLI

```
/help    - Mostrar ayuda
/status  - Ver estado del agente
/reset   - Reiniciar conversación
/clear   - Limpiar pantalla
/exit    - Salir
```

### 7.4 Modo Telegram (Opcional)

**Configurar Bot:**

1. Abrir Telegram y buscar: **@BotFather**
2. Enviar: `/newbot`
3. Seguir instrucciones:
   - Nombre: "Mi Agente Autónomo"
   - Username: "miagente_bot" (debe terminar en _bot)
4. **Copiar el token** que te da

**Configurar en .env:**

```bash
nano .env

# Agregar:
TELEGRAM_BOT_TOKEN=123456789:ABCdefGHIjklMNOpqrsTUVwxyz

# Guardar y salir
```

**Iniciar bot:**

```bash
python main.py telegram
```

**Usar desde Telegram:**
1. Busca tu bot en Telegram
2. Envía `/start`
3. ¡Empieza a dar órdenes!

---

## PASO 8: Ejemplos Prácticos

### 8.1 Gestión de Archivos

```
💬 Tú: Lista todos los archivos .txt en mi directorio home

🤖 Agente: [ejecuta comandos y responde]
```

```
💬 Tú: Encuentra el archivo más grande en /var/log

🤖 Agente: [analiza y responde]
```

### 8.2 Información del Sistema

```
💬 Tú: Dime cuánta RAM estoy usando

🤖 Agente: [ejecuta free -h y analiza]
```

```
💬 Tú: ¿Qué procesos están consumiendo más CPU?

🤖 Agente: [ejecuta top y analiza]
```

### 8.3 Navegación Web

```
💬 Tú: Busca información sobre Ubuntu 22.04 en internet

🤖 Agente: [navega y extrae información]
```

```
💬 Tú: Toma un screenshot de wikipedia.org

🤖 Agente: [captura y guarda imagen]
```

### 8.4 Programación

```
💬 Tú: Crea un script Python que calcule números primos

🤖 Agente: [crea archivo con código]
```

```
💬 Tú: Ejecuta este código: print([x**2 for x in range(10)])

🤖 Agente: [ejecuta y muestra resultado]
```

### 8.5 Tareas Complejas

```
💬 Tú: Busca las últimas noticias sobre IA, extrae los títulos principales, 
y guárdalos en un archivo llamado noticias_ia.txt

🤖 Agente: [navega → extrae → procesa → guarda → confirma]
```

---

## 🔄 Cómo Funciona el Cambio Automático (Híbrido)

### Escenario 1: Usando Claude ($5 disponibles)

```
💬 Tú: Analiza estos datos...

[Internamente]
🔍 Intentando con Anthropic Claude...
✅ Respuesta generada
💰 Crédito restante: $4.95

🤖 Agente: [respuesta de alta calidad]
⏱️  Tiempo: 2.3s
```

### Escenario 2: Claude sin Crédito → Ollama

```
💬 Tú: Dame un reporte del sistema

[Internamente]
🔍 Intentando con Anthropic Claude...
❌ Error: Insufficient credits
🔄 Cambiando a Ollama (llama3.1) - GRATIS
✅ Respuesta generada

🤖 Agente: [respuesta de buena calidad]
⏱️  Tiempo: 5.8s
💡 Usando Ollama (GRATIS)
```

**¡Sin interrupciones! El agente simplemente cambia de proveedor.**

---

## 📊 Monitoreo y Logs

### Ver Logs en Tiempo Real

```bash
# Logs del agente
tail -f data/agent.log

# Logs del bot de Telegram (si lo usas)
tail -f data/telegram_bot.log
```

### Ver Uso de Recursos

```bash
# CPU y RAM
htop

# Espacio en disco
df -h

# Procesos Python
ps aux | grep python
```

---

## 🔧 Configuración Avanzada

### Cambiar Modelo de Ollama

```bash
# Descargar otro modelo
ollama pull mistral

# Editar .env
nano .env
# Cambiar: OLLAMA_MODEL=mistral

# Reiniciar agente
```

### Cambiar Modelo de Claude

```bash
# Editar .env
nano .env

# Opciones:
# - claude-haiku-4-20250514 (más barato, más rápido)
# - claude-sonnet-4-20250514 (balance)
# - claude-opus-4-20250514 (más potente)

# Cambiar: DEFAULT_MODEL=claude-haiku-4-20250514
```

### Limitar Comandos Bash (Seguridad)

```bash
# Editar .env
nano .env

# Desactivar bash completamente:
ALLOW_BASH=false

# O limitar longitud:
MAX_COMMAND_LENGTH=200
```

---

## ⚙️ Mantenimiento

### Actualizar Ollama

```bash
curl -fsSL https://ollama.ai/install.sh | sh
ollama pull llama3.1  # Re-descargar modelo actualizado
```

### Actualizar Dependencias Python

```bash
source venv/bin/activate
pip install --upgrade -r requirements.txt
```

### Limpiar Logs Antiguos

```bash
# Limpiar logs viejos
rm data/*.log

# O comprimir
gzip data/agent.log
```

### Ver Uso de Crédito de Claude

```bash
# Ir a: https://console.anthropic.com/
# Sección "Usage" o "Billing"
```

---

## 🎯 Estrategias de Uso

### Estrategia "Aprendiz" (Primera Semana)

```
Día 1-2: Usa Claude
  - Experimenta libremente
  - Aprende las capacidades
  - Prueba casos complejos

Día 3-7: Mezcla Claude y Ollama
  - Tareas importantes → Claude
  - Tareas simples → Ollama (editar .env temporalmente)
  - Compara resultados
```

### Estrategia "Producción" (Después)

```
Modo 1: Solo Ollama (GRATIS)
  - Para uso diario
  - Tareas rutinarias
  - $0 de costo

Modo 2: Híbrido Inteligente
  - Ollama para 80% de tareas
  - Claude para el 20% crítico
  - Bajo costo (~$5-10/mes)

Modo 3: Solo Claude (PREMIUM)
  - Mejor calidad siempre
  - Más rápido
  - ~$20-50/mes
```

### Cambiar entre Modos

```bash
# Editar .env para cambiar prioridad
nano .env

# Solo Ollama:
ANTHROPIC_API_KEY=
OLLAMA_MODEL=llama3.1

# Solo Claude:
ANTHROPIC_API_KEY=sk-ant-...
# (Ollama sigue como backup)

# Híbrido (automático):
ANTHROPIC_API_KEY=sk-ant-...
OLLAMA_MODEL=llama3.1
# Usa Claude → fallback a Ollama
```

---

## 📱 Acceso Remoto

### SSH desde cualquier lugar

```bash
# Desde tu PC/Mac/otro dispositivo:
ssh usuario@IP_PUBLICA_VM

# Iniciar agente:
cd agente-autonomo
source venv/bin/activate
python main.py cli
```

### Telegram desde Celular

1. Configurar bot (ver Paso 7.4)
2. Desde cualquier lugar con internet:
   - Abrir Telegram
   - Hablar con tu bot
   - ¡Controlar tu VM!

### Screen/Tmux (mantener agente corriendo)

```bash
# Instalar screen
sudo apt install screen

# Iniciar sesión
screen -S agente

# Dentro del screen:
cd agente-autonomo
source venv/bin/activate
python main.py telegram

# Desconectar (agente sigue corriendo):
Ctrl+A, luego D

# Reconectar después:
screen -r agente
```

---

## 🎓 Tips Pro

### 1. Alias para Inicio Rápido

```bash
# Agregar a ~/.bashrc
echo 'alias agente="cd ~/agente-autonomo && source venv/bin/activate && python main.py cli"' >> ~/.bashrc

# Recargar
source ~/.bashrc

# Ahora solo escribe:
agente
```

### 2. Inicio Automático del Servidor Ollama

```bash
# Crear servicio systemd
sudo nano /etc/systemd/system/ollama.service

# Pegar:
[Unit]
Description=Ollama Service
After=network.target

[Service]
Type=simple
User=TU_USUARIO
ExecStart=/usr/local/bin/ollama serve
Restart=always

[Install]
WantedBy=multi-user.target

# Activar:
sudo systemctl enable ollama
sudo systemctl start ollama
```

### 3. Backup de Configuración

```bash
# Backup de .env
cp .env .env.backup

# Backup de data
tar -czf backup-$(date +%Y%m%d).tar.gz data/
```

---

## 📚 Recursos y Documentación

### Archivos Incluidos

```
agente-autonomo/
├── README.md              - Guía general
├── PRICING.md             - Comparación de opciones
├── OLLAMA_GUIDE.md        - Todo sobre Ollama
├── QUICKSTART.md          - Inicio rápido
├── INSTALACION_COMPLETA.md - Esta guía (la más completa)
└── check_providers.py     - Verificar proveedores
```

### Leer Primero

1. **Esta guía** - Instalación completa
2. **PRICING.md** - Para entender costos
3. **OLLAMA_GUIDE.md** - Si quieres profundizar en Ollama

### Links Útiles

- Anthropic Console: https://console.anthropic.com/
- Ollama Oficial: https://ollama.ai/
- Modelos de Ollama: https://ollama.ai/library
- Documentación Claude: https://docs.anthropic.com/

---

## ✅ Checklist Final

Antes de usar el agente, verifica:

- [ ] VM Ubuntu con 8GB+ RAM
- [ ] Proyecto descomprimido en ~/agente-autonomo
- [ ] Script install.sh ejecutado sin errores
- [ ] Ollama instalado: `ollama list` muestra llama3.1
- [ ] Servidor Ollama corriendo: `curl localhost:11434/api/tags`
- [ ] Claude configurado (opcional): API key en .env
- [ ] Entorno virtual activado: `source venv/bin/activate`
- [ ] Proveedores verificados: `python check_providers.py` ✅
- [ ] Agente inicia: `python main.py cli` funciona

**Si todo tiene ✅, ¡estás listo!**

---

## 🎉 ¡FELICIDADES!

Ya tienes tu agente autónomo funcionando con:

✅ **IA Gratis** (Ollama) - Para siempre
✅ **IA Premium** (Claude) - $5 gratis para empezar
✅ **Fallback Automático** - Sin interrupciones
✅ **Control Total** - De tu VM Ubuntu
✅ **Acceso Remoto** - CLI, Telegram, SSH

**Siguiente paso:** ¡Experimenta y diviértete!

---

## 💬 ¿Necesitas Ayuda?

Si algo no funciona, ve a: [Solución de Problemas](#solución-de-problemas)

**¡Disfruta de tu agente autónomo!** 🤖✨

---

# SOLUCIÓN DE PROBLEMAS

## ❌ Ollama: "connection refused"

**Problema:** El agente no puede conectarse a Ollama

**Solución:**
```bash
# Verificar si Ollama está corriendo
ps aux | grep ollama

# Si no está corriendo:
ollama serve &

# Verificar:
curl localhost:11434/api/tags
```

## ❌ Claude: "Invalid API key"

**Problema:** API key incorrecta o mal configurada

**Solución:**
```bash
# Verificar .env
cat .env | grep ANTHROPIC_API_KEY

# Debe empezar con: sk-ant-api03-
# Si no, editar:
nano .env
# Pegar clave correcta
```

## ❌ Python: "ModuleNotFoundError"

**Problema:** Falta una dependencia

**Solución:**
```bash
# Activar entorno virtual
source venv/bin/activate

# Reinstalar dependencias
pip install -r requirements.txt
```

## ❌ "Out of memory" al usar Ollama

**Problema:** No hay suficiente RAM

**Solución:**
```bash
# Opción 1: Aumentar RAM de la VM (recomendado)

# Opción 2: Usar modelo más pequeño
ollama pull llama3.2:3b

# Editar .env:
nano .env
OLLAMA_MODEL=llama3.2:3b
```

## ❌ Ollama muy lento

**Problema:** Rendimiento bajo

**Solución:**
```bash
# 1. Verificar RAM disponible
free -h

# 2. Cerrar programas innecesarios
# 3. Usar modelo más pequeño
ollama pull llama3.2:3b

# 4. Si tienes GPU NVIDIA:
nvidia-smi  # Verificar GPU
# Ollama debería usarla automáticamente
```

## ❌ "Permission denied" al ejecutar comandos

**Problema:** Sin permisos suficientes

**Solución:**
```bash
# Dar permisos de ejecución
chmod +x install.sh
chmod +x main.py

# Si necesita sudo y pide contraseña:
# El agente no puede auto-aprobar sudo
# Usa comandos que no requieran sudo
```

## ❌ Bot de Telegram no responde

**Problema:** Token incorrecto o bot no iniciado

**Solución:**
```bash
# 1. Verificar token en .env
cat .env | grep TELEGRAM_BOT_TOKEN

# 2. Verificar que bot está corriendo
ps aux | grep telegram

# 3. Ver logs
tail -f data/telegram_bot.log

# 4. Reiniciar bot
python main.py telegram
```

## ❌ "No providers available"

**Problema:** Ni Claude ni Ollama están configurados

**Solución:**
```bash
# Verificar proveedores
python check_providers.py

# Configurar al menos uno:
# Opción 1: Ollama (gratis)
ollama serve &

# Opción 2: Claude
nano .env
# Agregar: ANTHROPIC_API_KEY=...
```

## 🆘 Reinstalar Desde Cero

Si todo falla:

```bash
# 1. Borrar todo
cd ~
rm -rf agente-autonomo
rm agente-autonomo-completo.tar.gz

# 2. Re-transferir archivo
# [seguir Paso 2]

# 3. Re-instalar
# [seguir desde Paso 3]
```

---

**¿Sigues teniendo problemas?**
- Revisa los logs: `tail -f data/agent.log`
- Busca el error en Google
- Revisa la documentación en los archivos .md

