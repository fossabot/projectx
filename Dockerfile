FROM debian

MAINTAINER Daniel Nehrig <daniel.nehrig@dnehrig.com>

WORKDIR /app

RUN apt-get update && apt-get install -y \
  git \
  python \
  build-essential \
  make \
  gcc \
  nginx \
  curl \ 
  gnupg

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -

RUN apt-get install -y nodejs

RUN git clone https://github.com/bif12a/projectx ./
RUN npm install
RUN npm install typescript --global
RUN cd ./src/client && npm install && npm run build
RUN cd ../../ 
RUN tsc

EXPOSE 3112

CMD ["npm", "run", "start"]
