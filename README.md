# Diagnóstico ChatGPT Bot

Script automatizado para diagnóstico técnico em Ubuntu/Linux com envio direto à API da OpenAI (GPT-4).

## 🔧 Funcionalidades

- Coleta informações do sistema
- Verifica conflitos entre PipeWire e PulseAudio
- Aplica atualizações mesmo com faseamento
- Envia tudo à API ChatGPT
- Salva resposta em .txt com timestamp

## 📦 Requisitos

```bash
python3 -m venv env
source env/bin/activate
pip install -r requirements.txt
```

## ⚙️ Como usar

1. Configure sua chave no arquivo `.env`
2. Execute primeiro o script shell:

```bash
chmod +x ultimate_diagnostico_corrigir_atualizar.sh
./ultimate_diagnostico_corrigir_atualizar.sh
```

3. Depois, execute o script Python para enviar o relatório:

```bash
python3 agente_envio_chatgpt.py
```
