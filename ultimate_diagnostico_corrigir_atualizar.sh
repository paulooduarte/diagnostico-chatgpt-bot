#!/bin/bash
# Script: ultimate_diagnostico_corrigir_atualizar.sh
# Objetivo: Diagnosticar, corrigir conflito PipeWire/PulseAudio, forçar atualização e registrar tudo.

LOG_DIR=~/diagnostico_chatgpt_logs
LOG_FILE=$LOG_DIR/relatorio_completo.txt
mkdir -p $LOG_DIR

echo "🧠 [1/5] Coletando diagnóstico do sistema..." | tee $LOG_FILE

echo -e "\n--- uname -a ---\n" >> $LOG_FILE
uname -a >> $LOG_FILE

echo -e "\n--- apt list --upgradable ---\n" >> $LOG_FILE
apt list --upgradable 2>/dev/null | grep -v Listing >> $LOG_FILE

echo -e "\n--- Últimos comandos usados ---\n" >> $LOG_FILE
history | tail -n 20 >> $LOG_FILE

echo -e "\n--- dmesg (últimos 20) ---\n" >> $LOG_FILE
sudo dmesg | tail -n 20 >> $LOG_FILE

echo -e "\n--- dpkg -l | grep pipewire ---\n" >> $LOG_FILE
dpkg -l | grep pipewire >> $LOG_FILE

echo -e "\n--- dpkg -l | grep pulse ---\n" >> $LOG_FILE
dpkg -l | grep pulse >> $LOG_FILE

echo "✅ Diagnóstico salvo em $LOG_FILE"

echo "🔧 [2/5] Removendo PulseAudio se existir (evitar conflitos)..."
sudo apt remove pulseaudio pulseaudio:i386 -y | tee -a $LOG_FILE

echo "🔄 [3/5] Forçando atualização ignorando faseamento..."
sudo apt update | tee -a $LOG_FILE
sudo apt -o APT::Get::Always-Include-Phased-Updates=true upgrade -y | tee -a $LOG_FILE

echo "🔊 [4/5] Abrindo painel de som (testar PipeWire)..."
gnome-control-center sound &

echo "📁 [5/5] Diagnóstico e correção concluídos!"
echo "📝 Verifique o log completo em: $LOG_FILE"
