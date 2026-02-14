#!/bin/bash

# Script de Instalación Automática de OpenClaw
# Para Ubuntu 22.04+

set -e

echo "╔═══════════════════════════════════════════════════════╗"
echo "║                                                       ║"
echo "║      🦞  INSTALADOR DE OPENCLAW REAL  🦞             ║"
echo "║                                                       ║"
echo "╚═══════════════════════════════════════════════════════╝"
echo ""

# Colores
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# 1. Verificar sistema
echo -e "${BLUE}📋 Verificando sistema...${NC}"
if ! grep -q "Ubuntu" /etc/os-release; then
    echo -e "${YELLOW}⚠️  Este script está diseñado para Ubuntu${NC}"
fi

# 2. Actualizar sistema
echo ""
echo -e "${BLUE}📦 Actualizando sistema...${NC}"
sudo apt update
sudo apt upgrade -y

# 3. Instalar dependencias
echo ""
echo -e "${BLUE}📦 Instalando dependencias...${NC}"
sudo apt install -y \
    curl \
    git \
    build-essential \
    python3 \
    ca-certificates \
    gnupg

# 4. Instalar Node.js 22
echo ""
echo -e "${BLUE}📦 Instalando Node.js 22...${NC}"
if command -v node &> /dev/null; then
    NODE_VERSION=$(node --version | cut -d'v' -f2 | cut -d'.' -f1)
    if [ "$NODE_VERSION" -lt 22 ]; then
        echo "Node.js versión actual: $(node --version)"
        echo "Se requiere v22+, actualizando..."
        curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
        sudo apt install -y nodejs
    else
        echo -e "${GREEN}✓ Node.js $(node --version) ya instalado${NC}"
    fi
else
    curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
    sudo apt install -y nodejs
fi

echo ""
echo -e "${GREEN}✓ Node.js: $(node --version)${NC}"
echo -e "${GREEN}✓ npm: $(npm --version)${NC}"

# 5. Preguntar sobre Ollama
echo ""
echo -e "${BLUE}═══════════════════════════════════════════${NC}"
echo -e "${BLUE}  ¿Quieres instalar Ollama (IA GRATIS)?   ${NC}"
echo -e "${BLUE}═══════════════════════════════════════════${NC}"
echo ""
echo "1. Sí - Instalar Ollama (100% gratis, local)"
echo "2. No - Usaré Claude/OpenAI (de pago)"
echo ""
read -p "Selecciona (1/2): " -n 1 -r
echo ""

if [[ $REPLY =~ ^[1]$ ]]; then
    echo ""
    echo -e "${BLUE}🦙 Instalando Ollama...${NC}"
    
    if ! command -v ollama &> /dev/null; then
        curl -fsSL https://ollama.ai/install.sh | sh
        echo -e "${GREEN}✓ Ollama instalado${NC}"
    else
        echo -e "${GREEN}✓ Ollama ya está instalado${NC}"
    fi
    
    echo ""
    echo "¿Qué modelo descargar?"
    echo "1. llama3.1 (8GB RAM) - Recomendado"
    echo "2. llama3.2:3b (4GB RAM) - Ligero"
    echo "3. mistral (8GB RAM) - Alternativa"
    echo "4. Ninguno (descargaré después)"
    echo ""
    read -p "Selecciona (1/2/3/4): " -n 1 -r
    echo ""
    
    case $REPLY in
        1) ollama pull llama3.1 ;;
        2) ollama pull llama3.2:3b ;;
        3) ollama pull mistral ;;
        4) echo "OK, puedes descargar después con: ollama pull llama3.1" ;;
    esac
    
    echo ""
    echo -e "${BLUE}Iniciando servidor Ollama...${NC}"
    nohup ollama serve > /dev/null 2>&1 &
    sleep 2
    
    if curl -s http://localhost:11434/api/tags > /dev/null; then
        echo -e "${GREEN}✓ Ollama corriendo${NC}"
    else
        echo -e "${YELLOW}⚠️  Ollama no inició automáticamente${NC}"
        echo "Puedes iniciarlo después con: ollama serve &"
    fi
fi

# 6. Instalar OpenClaw
echo ""
echo -e "${BLUE}🦞 Instalando OpenClaw...${NC}"

# Agregar npm global bin al PATH si no está
NPM_BIN=$(npm config get prefix)/bin
if [[ ":$PATH:" != *":$NPM_BIN:"* ]]; then
    echo "export PATH=\"\$PATH:$NPM_BIN\"" >> ~/.bashrc
    export PATH="$PATH:$NPM_BIN"
fi

npm install -g openclaw@latest

echo ""
if command -v openclaw &> /dev/null; then
    OPENCLAW_VERSION=$(openclaw --version)
    echo -e "${GREEN}✓ OpenClaw instalado: v${OPENCLAW_VERSION}${NC}"
else
    echo -e "${RED}✗ Error instalando OpenClaw${NC}"
    echo "Intenta manualmente: npm install -g openclaw@latest"
    exit 1
fi

# 7. Información final
echo ""
echo -e "${GREEN}╔═══════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║                                                       ║${NC}"
echo -e "${GREEN}║           ✅  INSTALACIÓN COMPLETADA  ✅              ║${NC}"
echo -e "${GREEN}║                                                       ║${NC}"
echo -e "${GREEN}╚═══════════════════════════════════════════════════════╝${NC}"
echo ""

echo -e "${YELLOW}📝 Próximos pasos:${NC}"
echo ""
echo "1. Ejecutar el wizard de configuración:"
echo -e "   ${BLUE}openclaw onboard --install-daemon${NC}"
echo ""
echo "2. Durante el wizard:"
if [[ $REPLY =~ ^[1]$ ]]; then
    echo -e "   ${GREEN}• Selecciona: Ollama (Local - FREE)${NC}"
else
    echo "   • Selecciona tu proveedor (Anthropic/OpenAI/etc.)"
    echo "   • Ingresa tu API key"
fi
echo "   • Acepta configuración por defecto"
echo "   • Configura Telegram (opcional)"
echo ""
echo "3. Acceder al dashboard:"
echo -e "   ${BLUE}openclaw dashboard${NC}"
echo ""
echo "4. Verificar que todo funciona:"
echo -e "   ${BLUE}openclaw doctor${NC}"
echo ""

if [[ $REPLY =~ ^[1]$ ]]; then
    echo -e "${GREEN}💡 Tips para Ollama:${NC}"
    echo "   • Verificar: curl localhost:11434/api/tags"
    echo "   • Reiniciar: pkill ollama && ollama serve &"
    echo "   • Modelos: ollama list"
    echo ""
fi

echo -e "${YELLOW}📚 Documentación:${NC}"
echo "   • https://docs.openclaw.ai/"
echo "   • https://github.com/openclaw/openclaw"
echo ""

echo -e "${GREEN}¡OpenClaw instalado! Ahora ejecuta:${NC} openclaw onboard --install-daemon"
echo ""
