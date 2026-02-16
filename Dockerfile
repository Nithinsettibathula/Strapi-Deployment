FROM node:18-slim
# Install build essentials (required for some Strapi dependencies like Sharp or SQLite)
RUN apt-get update && apt-get install -y build-essential gcc make python3

WORKDIR /opt/app
COPY package.json package-lock.json ./
# Using --legacy-peer-deps helps bypass version conflicts
RUN npm install --legacy-peer-deps

COPY . .
RUN npm run build
EXPOSE 1337
CMD ["npm", "run", "develop"]