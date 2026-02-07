# 📋 CHEAT SHEET - Comandos Rápidos

## 🚀 Instalación en 5 Comandos

```bash
# 1. Descomprimir
tar -xzf agente-autonomo-FINAL.tar.gz && cd agente-autonomo

# 2. Instalar (elige opción 3: Híbrido)
./install.sh

# 3. Activar entorno
source venv/bin/activate

# 4. Verificar
python check_providers.py

# 5. ¡Usar!
python main.py cli
```

---

## 📝 Configurar Claude ($5 gratis)

```bash
# 1. Registrarse en: https://console.anthropic.com/
# 2. Crear API key
# 3. Configurar:
nano .env
# Agregar: ANTHROPIC_API_KEY=sk-ant-api03-TU_CLAVE
```

---

## 🆓 Comandos de Ollama

```bash
# Instalar Ollama
curl -fsSL https://ollama.ai/install.sh | sh

# Descargar modelo (elige uno)
ollama pull llama3.1        # 8GB RAM - Recomendado
ollama pull llama3.2:3b     # 4GB RAM - Ligero
ollama pull mistral         # 8GB RAM - Alternativo

# Iniciar servidor
ollama serve &

# Listar modelos
ollama list

# Probar modelo
ollama run llama3.1

# Ver procesos
ps aux | grep ollama

# Verificar que funciona
curl localhost:11434/api/tags
```

---

## 🤖 Usar el Agente

```bash
# Modo CLI (terminal)
cd ~/agente-autonomo
source venv/bin/activate
python main.py cli

# Modo Telegram
python main.py telegram

# Verificar proveedores
python check_providers.py

# Modo test
python main.py test
```

---

## 💬 Comandos Dentro del CLI

```
/help     - Mostrar ayuda
/status   - Estado del agente  
/reset    - Reiniciar conversación
/clear    - Limpiar pantalla
/exit     - Salir
```

---

## 📊 Monitoreo

```bash
# Ver logs en tiempo real
tail -f data/agent.log
tail -f data/telegram_bot.log

# Ver recursos
htop
free -h
df -h

# Ver procesos Python
ps aux | grep python
```

---

## ⚙️ Editar Configuración

```bash
# Editar .env
nano .env

# Variables importantes:
ANTHROPIC_API_KEY=         # Clave de Claude
OLLAMA_MODEL=llama3.1      # Modelo de Ollama
ALLOW_BASH=true            # Permitir comandos
DEFAULT_MODEL=             # Modelo de Claude
```

---

## 🔄 Cambiar entre Proveedores

```bash
nano .env

# Solo Ollama (GRATIS):
ANTHROPIC_API_KEY=
OLLAMA_MODEL=llama3.1

# Solo Claude:
ANTHROPIC_API_KEY=sk-ant-...

# Híbrido (ambos):
ANTHROPIC_API_KEY=sk-ant-...
OLLAMA_MODEL=llama3.1
```

---

## 🐛 Solución Rápida de Problemas

```bash
# Ollama no conecta
ollama serve &
curl localhost:11434/api/tags

# Reinstalar dependencias
source venv/bin/activate
pip install -r requirements.txt

# Ver error exacto
tail -n 50 data/agent.log

# Reiniciar desde cero
cd ~
rm -rf agente-autonomo
tar -xzf agente-autonomo-FINAL.tar.gz
cd agente-autonomo
./install.sh
```

---

## 📱 Telegram Bot

```bash
# 1. Crear bot con @BotFather en Telegram
# 2. Copiar token
# 3. Configurar:
nano .env
# Agregar: TELEGRAM_BOT_TOKEN=123456:ABC...

# 4. Iniciar:
python main.py telegram

# 5. En Telegram, buscar tu bot y /start
```

---

## 🎯 Ejemplos de Uso Rápido

```
# Información del sistema
"Dime cuánta RAM y disco tengo disponible"

# Gestión de archivos  
"Lista los 10 archivos más grandes en mi home"
"Crea un archivo llamado notas.txt"

# Web
"Busca información sobre Python en Wikipedia"
"Toma screenshot de google.com"

# Programación
"Crea un script Python que calcule números primos"
"Ejecuta: print([x**2 for x in range(10)])"
```

---

## 📚 Documentos a Leer

```
INSTALACION_COMPLETA.md  ← Lee ESTO primero (paso a paso)
PRICING.md               ← Comparación de opciones
OLLAMA_GUIDE.md          ← Todo sobre Ollama gratis
README.md                ← Guía general
QUICKSTART.md            ← Inicio rápido
```

---

## ✅ Verificación Rápida

```bash
# Todo funcionando si ves:
python check_providers.py
# ✅ Anthropic disponible
# ✅ Ollama disponible  
# ✅ Proveedores: Anthropic, Ollama (GRATIS)
```

---

## 🔧 Mantenimiento

```bash
# Actualizar Ollama
curl -fsSL https://ollama.ai/install.sh | sh
ollama pull llama3.1

# Limpiar logs
rm data/*.log

# Backup configuración
cp .env .env.backup
tar -czf backup.tar.gz data/

# Ver crédito de Claude
# Ir a: https://console.anthropic.com/settings/limits
```

---

## 🚪 Acceso Remoto

```bash
# SSH desde otra computadora
ssh usuario@IP_VM

# Screen (mantener corriendo)
screen -S agente
python main.py telegram
# Ctrl+A, D para desconectar
# screen -r agente para reconectar
```

---

## 🎓 Alias Útiles

```bash
# Agregar a ~/.bashrc
echo 'alias agente="cd ~/agente-autonomo && source venv/bin/activate && python main.py cli"' >> ~/.bashrc
echo 'alias agentebot="cd ~/agente-autonomo && source venv/bin/activate && python main.py telegram"' >> ~/.bashrc
source ~/.bashrc

# Ahora solo escribe:
agente      # Inicia CLI
agentebot   # Inicia Telegram
```

---

## 💰 Ver Uso de Crédito

```bash
# Claude (web):
# https://console.anthropic.com/settings/limits

# Ollama (gratis, sin límite):
# ∞ Infinito ∞
```

---

## ⚡ Tips Pro

```bash
# Inicio automático de Ollama
sudo systemctl enable ollama
sudo systemctl start ollama

# Ver qué modelo se está usando
python check_providers.py

# Cambiar temporalmente a otro modelo
OLLAMA_MODEL=mistral python main.py cli
```

---

**¡Guarda este archivo para referencia rápida!** 📌
