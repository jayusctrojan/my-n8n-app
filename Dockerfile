FROM node:18-alpine

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

COPY package*.json ./

RUN npm install --only=production

RUN addgroup -g 1000 n8n && \
    adduser -u 1000 -G n8n -s /bin/sh -D n8n

RUN mkdir /home/n8n/.n8n && \
    chown -R n8n:n8n /home/n8n

USER n8n

EXPOSE $PORT

CMD ["npx", "n8n", "start"]
