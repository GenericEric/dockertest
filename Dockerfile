FROM derenderkeks/murmur:latest

RUN mkdir -p /app/src

WORKDIR /app/src

#COPY package.json .

RUN npm install

COPY . .

EXPOSE 64738

CMD ["npm", "start"]