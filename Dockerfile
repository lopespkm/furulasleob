FROM node:18-alpine

WORKDIR /app

# Copia apenas os arquivos de dependência primeiro para otimizar cache
COPY package*.json ./
COPY prisma ./prisma/

# Instala as dependências
RUN npm install

# Concede permissão de execução ao binário do Prisma
RUN chmod +x node_modules/.bin/prisma

# Gera os arquivos do Prisma
RUN npx prisma generate

# Copia o restante do projeto
COPY . .

# Comando para iniciar o servidor
CMD ["npm", "start"]
