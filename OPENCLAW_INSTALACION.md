# 🦞 GUÍA COMPLETA: Instalar OpenClaw REAL en Ubuntu

## 🎯 Qué es OpenClaw

**OpenClaw** es el asistente de IA personal de código abierto creado por Peter Steinberger (@steipete).

**Características principales:**
- 🤖 Asistente de IA 24/7 que corre en TU máquina
- 💬 Conecta con Telegram, WhatsApp, Discord, iMessage, Signal, etc.
- 🧠 Memoria persistente - recuerda TODO
- 🔧 Sistema de Skills extensible (50+ skills incluidos)
- 🌐 Navegación web, control de calendario, emails, etc.
- 🔒 100% auto-hospedado - tus datos NO salen de tu servidor

**GitHub:** https://github.com/openclaw/openclaw  
**Docs:** https://docs.openclaw.ai/

---

## 📋 Requisitos

### Hardware Mínimo:
- **RAM**: 2GB (4GB recomendado)
- **Disco**: 5GB libres
- **CPU**: Cualquier procesador moderno

### Software:
- **OS**: Ubuntu 22.04+ (o cualquier distro Linux)
- **Node.js**: v22+ (se instalará en la guía)
- **Internet**: Conexión estable

### API Keys (necesitas AL MENOS UNA):

**Opción 1: Anthropic Claude** (Recomendado)
- Registrarse en: https://console.anthropic.com/
- Ya NO hay $5 gratis (según lo que dijiste)
- Costo: ~$3-15 por millón de tokens

**Opción 2: OpenAI GPT**
- Registrarse en: https://platform.openai.com/
- Costo similar a Claude

**Opción 3: Modelos Locales** (GRATIS)
- Ollama (vamos a configurar esto)
- LMStudio
- Sin costos, pero requiere más RAM

---

## 🚀 INSTALACIÓN PASO A PASO

### PASO 1: Preparar Ubuntu

```bash
# Conectarte a tu VM
ssh usuario@ip-vm
# O abrir terminal si es local

# Actualizar sistema
sudo apt update && sudo apt upgrade -y

# Instalar dependencias básicas
sudo apt install -y \
    curl \
    git \
    build-essential \
    python3 \
    ca-certificates \
    gnupg
```

---

### PASO 2: Instalar Node.js 22+

OpenClaw **requiere** Node.js v22 o superior.

```bash
# Descargar e instalar Node.js 22
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
sudo apt install -y nodejs

# Verificar versión
node --version
# Debe mostrar: v22.x.x

npm --version
# Debe mostrar: 10.x.x o superior
```

**✅ Checkpoint:** Si ves versiones correctas, continúa.

---

### PASO 3: Instalar OpenClaw

Hay dos métodos. **Recomiendo el automático:**

#### Método A: Instalación Automática (Recomendado)

```bash
# Instalar con script automático
curl -fsSL https://openclaw.ai/install.sh | bash
```

Este script:
- ✅ Detecta tu OS automáticamente
- ✅ Verifica Node.js
- ✅ Instala OpenClaw globalmente
- ✅ Te lleva al onboarding wizard

#### Método B: Instalación Manual

```bash
# Instalar OpenClaw con npm
npm install -g openclaw@latest

# Verificar instalación
openclaw --version
# Debe mostrar: 2026.x.x (versión actual)
```

**✅ Checkpoint:** `openclaw --version` funciona

---

### PASO 4: Configurar Ollama (GRATIS) - OPCIONAL

Si quieres usar OpenClaw **GRATIS** con Ollama:

```bash
# 1. Instalar Ollama
curl -fsSL https://ollama.ai/install.sh | sh

# 2. Descargar modelo (elige uno)
ollama pull llama3.1        # 8GB RAM - Recomendado
# o
ollama pull llama3.2:3b     # 4GB RAM - Más ligero
# o
ollama pull mistral         # 8GB RAM - Alternativa

# 3. Iniciar servidor Ollama
ollama serve &

# 4. Verificar
curl http://localhost:11434/api/tags
# Debe retornar JSON con modelos
```

---

### PASO 5: Ejecutar Onboarding Wizard

**ESTE PASO ES CRÍTICO** - configura TODO.

```bash
# Iniciar wizard de configuración
openclaw onboard --install-daemon
```

**¿Qué hace `--install-daemon`?**  
Registra OpenClaw como servicio del sistema (systemd), para que corra 24/7.

---

### PASO 6: Wizard - Configuración Paso a Paso

El wizard te hará preguntas. Aquí está qué responder:

#### 6.1 Tipo de Instalación

```
? Choose installation mode:
  > QuickStart (recommended)
    Custom Setup
    Advanced
```

**✅ Selecciona: QuickStart**  
(Usa configuración por defecto, más fácil)

#### 6.2 Seleccionar Proveedor de IA

```
? Select your AI provider:
  > Anthropic (Claude)
    OpenAI (GPT)
    Google (Gemini)
    Ollama (Local - FREE)
    Other...
```

**Opciones:**

**Si quieres GRATIS:**
- ✅ Selecciona: **Ollama (Local - FREE)**
- El wizard detectará automáticamente tu servidor Ollama
- Seleccionará el modelo que descargaste

**Si tienes API key de Claude:**
- ✅ Selecciona: **Anthropic (Claude)**
- Te pedirá la API key

#### 6.3 Ingresar API Key (si elegiste Claude/OpenAI)

```
? Enter your Anthropic API key:
sk-ant-api03-_____________________
```

**Pega tu API key** y presiona Enter.

#### 6.4 Configurar Gateway

```
? Gateway port (default: 18789):
  > 18789
```

**✅ Presiona Enter** (usa el puerto por defecto)

```
? Enable Control UI?
  > Yes
    No
```

**✅ Selecciona: Yes**  
(Te permite controlar OpenClaw desde navegador)

#### 6.5 Configurar Canales de Comunicación

```
? Which channels do you want to set up?
  ◯ Telegram
  ◯ WhatsApp
  ◯ Discord
  ◯ iMessage
  ◯ Signal
  > Skip for now
```

**Por ahora:** ✅ Selecciona **Skip for now**  
(Configuraremos Telegram después)

#### 6.6 Configurar Skills

```
? Do you want to configure skills now?
  > Yes
    Skip
```

**✅ Selecciona: Skip**  
(Se pueden agregar después)

#### 6.7 Configurar Workspace

```
? Workspace directory:
  > ~/.openclaw/workspace
```

**✅ Presiona Enter** (usa directorio por defecto)

#### 6.8 Finalizar

```
✓ OpenClaw has been configured successfully!

Gateway is running at: http://localhost:18789
Access token: eyJ...xxxxxxxxx

To access the Control UI:
  openclaw dashboard

To check status:
  openclaw doctor
```

**¡Instalación completada!** 🎉

---

### PASO 7: Verificar que Funciona

```bash
# Ver estado del servicio
openclaw doctor

# Debe mostrar:
# ✓ Gateway is running
# ✓ Models configured
# ✓ Workspace accessible
```

Si todo tiene ✓ → **¡Funciona!**

---

### PASO 8: Acceder al Control UI (Dashboard Web)

```bash
# Abrir dashboard en navegador
openclaw dashboard
```

Esto abrirá automáticamente en tu navegador:  
`http://localhost:18789/?token=eyJ...`

**Si estás en SSH (VM remota):**

```bash
# Opción 1: SSH Tunnel
# En tu PC local:
ssh -L 18789:localhost:18789 usuario@IP_VM

# Luego abrir en navegador local:
http://localhost:18789/?token=TU_TOKEN
```

**Opción 2: Tailscale (recomendado para acceso remoto)**

Sigue: https://docs.openclaw.ai/gateway/remote-access

---

## 💬 Configurar Telegram (PASO OPCIONAL)

### 1. Crear Bot en Telegram

```bash
# En Telegram, buscar: @BotFather
# Enviar: /newbot
# Seguir instrucciones
# Copiar el TOKEN que te da
```

### 2. Configurar en OpenClaw

```bash
# Iniciar configuración de canal
openclaw channel add telegram

# Te pedirá:
? Enter Telegram Bot Token:
123456789:ABCdef...

# Sigue las instrucciones
```

### 3. Emparejar

```bash
# El bot te dará un código de pairing
# En Telegram, envía a tu bot: /pair CODIGO
```

### 4. ¡Usar!

```bash
# En Telegram, habla con tu bot:
/start

# Luego prueba:
Hello, who are you?
```

---

## 🎮 EJEMPLOS DE USO

### Desde Control UI (Navegador)

Abre `openclaw dashboard` y escribe:

```
1. "Hello, introduce yourself"

2. "What can you do?"

3. "Create a file named test.txt with content 'Hello from OpenClaw'"

4. "List all files in my workspace"

5. "Search for information about Python online"
```

### Desde Telegram (si configuraste)

```
Tú: Hey, what's the weather?

Bot: [si configuraste weather skill]
     The weather in [tu ubicación] is...

Tú: Set a reminder for tomorrow at 3pm

Bot: [si configuraste calendar skill]
     Reminder set for tomorrow at 3pm ✓
```

---

## 🔧 Comandos Útiles

### Gestión del Servicio

```bash
# Ver status
openclaw doctor

# Ver logs en tiempo real
openclaw logs --follow

# Reiniciar gateway
openclaw gateway restart

# Detener todo
openclaw gateway stop

# Iniciar
openclaw gateway start
```

### Gestión de Skills

```bash
# Listar skills disponibles
openclaw skill list

# Instalar un skill
openclaw skill install google-calendar

# Ver skills instalados
openclaw skill list --installed
```

### Enviar Mensajes

```bash
# Enviar mensaje directo al agente
openclaw agent --message "What time is it?"

# Enviar a un canal específico
openclaw message send --to telegram --message "Hello!"
```

### Actualizar OpenClaw

```bash
# Actualizar a última versión
openclaw update

# Cambiar canal de actualizaciones
openclaw update --channel stable
# Opciones: stable, beta, dev
```

---

## 📊 Comparación: Ollama vs Claude

| Aspecto | Ollama (Gratis) | Claude (Pago) |
|---------|----------------|---------------|
| **Costo** | $0 | ~$3-15/millón tokens |
| **Velocidad** | Medio (depende HW) | Rápido |
| **Calidad** | Buena (7/10) | Excelente (9.5/10) |
| **Setup** | Más complejo | Simple (solo API key) |
| **RAM** | 8-16GB | Cualquiera |
| **Internet** | No necesario | Sí necesario |

**Recomendación:**
- Experimenta con **Ollama** (gratis)
- Si te gusta, upgrade a **Claude** para mejor calidad

---

## 🌟 Skills Populares

OpenClaw tiene 50+ skills. Algunos populares:

### Productividad
- `google-calendar` - Gestión de calendario
- `gmail` - Enviar/leer emails
- `todoist` - Lista de tareas

### Smart Home
- `philips-hue` - Control de luces
- `homeassistant` - Home automation

### Salud
- `whoop` - Métricas de salud
- `oura` - Datos del anillo Oura

### Desarrollo
- `github` - Gestión de repos
- `sentry` - Monitoreo de errores

### Instalar skills:

```bash
# Desde CLI
openclaw skill install google-calendar

# O desde Control UI:
# Dashboard → Skills → Search → Install
```

---

## 🐛 Solución de Problemas

### "openclaw: command not found"

```bash
# Agregar npm global bin al PATH
echo 'export PATH="$PATH:$(npm config get prefix)/bin"' >> ~/.bashrc
source ~/.bashrc
```

### Gateway no inicia

```bash
# Verificar puerto
sudo lsof -i :18789

# Si está ocupado, matar proceso
sudo kill -9 PID

# Reiniciar
openclaw gateway restart
```

### "Models not configured"

```bash
# Re-ejecutar onboarding
openclaw onboard

# O editar config manualmente
nano ~/.openclaw/config.json
```

### Ollama no conecta

```bash
# Verificar que Ollama esté corriendo
curl http://localhost:11434/api/tags

# Si no responde:
ollama serve &
```

### "Permission denied" en logs

```bash
# Verificar permisos
ls -la ~/.openclaw/

# Arreglar permisos
chmod -R 755 ~/.openclaw/
```

### Dashboard no carga

```bash
# Verificar token
openclaw dashboard --print-token

# Usar túnel SSH si estás remoto
ssh -L 18789:localhost:18789 usuario@VM
```

---

## 📁 Estructura de Archivos

```
~/.openclaw/
├── config.json          # Configuración principal
├── workspace/           # Sandbox del agente
├── skills/             # Skills instalados
├── logs/               # Logs del sistema
└── data/               # Datos persistentes
    ├── memory/         # Memoria del agente
    └── sessions/       # Sesiones activas
```

**Importante:**
- ⚠️ `config.json` contiene API keys - NO compartir
- ⚠️ Hacer backup de `~/.openclaw/` regularmente
- ⚠️ El workspace es donde el agente guarda archivos

---

## 🔒 Seguridad

### NUNCA hagas esto:

❌ Exponer gateway a internet público (puerto 18789)  
❌ Compartir tu token de acceso  
❌ Darle permisos de sudo al agente  
❌ Usar sin revisar qué skills instalas

### SÍ haz esto:

✅ Usar Tailscale para acceso remoto  
✅ Habilitar modo "consent" para comandos peligrosos  
✅ Revisar logs regularmente  
✅ Mantener OpenClaw actualizado

```bash
# Habilitar modo consent (pide aprobación antes de ejecutar)
# Editar ~/.openclaw/config.json
"exec": {
  "ask": "on"
}
```

---

## 📈 Próximos Pasos

### 1. Configurar tu canal favorito
```bash
openclaw channel add telegram
# o whatsapp, discord, etc.
```

### 2. Instalar skills útiles
```bash
openclaw skill install google-calendar
openclaw skill install gmail
```

### 3. Personalizar el agente
```bash
# Editar configuración
nano ~/.openclaw/config.json

# Cambiar nombre, comportamiento, etc.
```

### 4. Automatizar tareas
```bash
# Configurar cron jobs
openclaw cron add "0 9 * * * Send me daily briefing"
```

---

## 📚 Recursos Oficiales

- **Documentación:** https://docs.openclaw.ai/
- **GitHub:** https://github.com/openclaw/openclaw
- **Discord Comunidad:** https://discord.com/invite/clawd
- **Skills Hub:** https://clawhub.com
- **Blog:** https://openclaw.ai/blog

---

## ✅ Checklist Final

Antes de empezar a usar:

- [ ] Node.js 22+ instalado: `node --version`
- [ ] OpenClaw instalado: `openclaw --version`
- [ ] Ollama corriendo (si usas local): `curl localhost:11434/api/tags`
- [ ] Onboarding completado: `openclaw doctor` muestra ✓
- [ ] Gateway activo: `openclaw dashboard` abre
- [ ] Al menos un canal configurado (Telegram/WebChat)

**Si todo ✓ → ¡Listo para usar OpenClaw!**

---

## 🎉 ¡Felicidades!

Ahora tienes **OpenClaw REAL** corriendo en tu VM:

✅ Asistente de IA 24/7  
✅ Memoria persistente  
✅ Skills extensibles  
✅ Control desde Telegram/WhatsApp/etc.  
✅ 100% auto-hospedado

**Es exactamente lo que querías** - el OpenClaw original, no una réplica.

---

## 💡 Ejemplo Rápido de Uso

```bash
# 1. Abrir dashboard
openclaw dashboard

# 2. En el navegador, escribir:
"Hello! What can you do?"

# 3. El agente responderá con sus capacidades

# 4. Probar algo simple:
"Create a file named notes.txt with content 'My first OpenClaw note'"

# 5. Verificar:
cat ~/.openclaw/workspace/notes.txt
```

**¡Disfruta de tu OpenClaw!** 🦞

---

¿Problemas? Revisa la sección de Solución de Problemas o ejecuta `openclaw doctor`
