FROM node:18-alpine

# Install dependencies needed for n8n
RUN apk add --no-cache \
    python3 \
    make \
    g++ \
    cairo-dev \
    jpeg-dev \
    pango-dev \
    musl-dev \
    giflib-dev \
    pixman-dev \
    pangomm-dev \
    libjpeg-turbo-dev \
    freetype-dev

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install n8n
RUN npm ci --only=production

# Create n8n user
RUN addgroup -g 1000 n8n && \
    adduser -u 1000 -G n8n -s /bin/sh -D n8n

# Create data directory
RUN mkdir /home/n8n/.n8n && \
    chown -R n8n:n8n /home/n8n

USER n8n

EXPOSE $PORT

CMD ["npx", "n8n", "start"]