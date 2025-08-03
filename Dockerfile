FROM node:18-alpine

WORKDIR /app

# Copia apenas arquivos necessários para instalar dependências
COPY package*.json ./
COPY prisma ./prisma/

# Instala dependências normalmente
RUN npm install

# Corrige permissões de todos os binários (inclui Prisma)
RUN find node_modules/.bin -type f -exec chmod +x {} \;

# Gera arquivos do Prisma
RUN npx prisma generate

# Copia o restante do projeto
COPY . .

# Inicia o servidor
CMD ["node", "server.js"]
