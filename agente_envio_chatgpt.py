import os
import openai
from datetime import datetime

# ⚠️ Configure sua chave de API OpenAI antes de rodar
openai.api_key = os.getenv("OPENAI_API_KEY")

# Caminho do log gerado pelo script bash
log_path = os.path.expanduser("~/diagnostico_chatgpt_logs/relatorio_completo.txt")

# Lê o conteúdo do relatório
with open(log_path, "r") as f:
    diagnostic_text = f.read()

# Cria o prompt a ser enviado ao ChatGPT
prompt = f"""
Você é um assistente técnico. Analise o seguinte diagnóstico extraído de um sistema Ubuntu 25.05. 
Diga quais problemas estão presentes e sugira correções claras e seguras.

RELATÓRIO:
{diagnostic_text}
"""

print("⏳ Enviando relatório para o ChatGPT...")

# Envia à API da OpenAI
response = openai.ChatCompletion.create(
    model="gpt-4",
    messages=[
        {"role": "system", "content": "Você é um especialista em Linux e Ubuntu."},
        {"role": "user", "content": prompt}
    ]
)

# Salva resposta no mesmo diretório
output_path = os.path.expanduser(f"~/diagnostico_chatgpt_logs/resposta_{datetime.now().strftime('%Y%m%d_%H%M%S')}.txt")
with open(output_path, "w") as f:
    f.write(response['choices'][0]['message']['content'])

print(f"✅ Diagnóstico enviado com sucesso. Resposta salva em: {output_path}")
