FROM node:18-alpine

WORKDIR /app

# Copia apenas arquivos necessários para instalar dependências
COPY package*.json ./
COPY prisma ./prisma/

# Instala dependências normalmente
RUN npm install

# Mostra binários e corrige permissões se necessário
RUN ls -la node_modules/.bin && chmod +x node_modules/.bin/* || true

# Roda o Prisma (sem falhar o build se der erro)
RUN npx prisma generate || echo "⚠️ prisma generate falhou, mas o container vai iniciar para debug"

# Copia o restante do projeto
COPY . .

# Comando de inicialização
CMD ["node", "server.js"]
