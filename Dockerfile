FROM node:18-slim
# Install build essentials
RUN apt-get update && apt-get install -y build-essential gcc make python3

WORKDIR /opt/app
COPY package.json package-lock.json ./
RUN npm install --legacy-peer-deps

COPY . .

# Set environment to production for external access
ENV NODE_ENV=production
RUN npm run build

EXPOSE 1337
# Use start instead of develop for production deployments
CMD ["npm", "run", "start"]