FROM zzswang/docker-nginx-react:latest
LABEL maintainer="zzswang@gmail.com"

ENV NODE_VERSION=v8.9.3 NPM_VERSION=5

RUN echo "http://dl-4.alpinelinux.org/alpine/v3.2/main" >> /etc/apk/repositories && \
	apk add --update git curl make gcc g++ python linux-headers libgcc libstdc++ binutils-gold && \
	cd / && curl -sSL https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}.tar.gz | tar -xz && \
	cd /node-${NODE_VERSION} && \
	./configure --prefix=/usr --without-snapshot && \
	make -j$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) && \
	make install && \
	cd / && \
	npm install -g npm@${NPM_VERSION} && \
	apk del gcc g++ linux-headers binutils-gold && \
	rm -rf /etc/ssl /node-${NODE_VERSION} /usr/include \
	/usr/share/man /tmp/* /var/cache/apk/* /root/.npm /root/.node-gyp \
	/usr/lib/node_modules/npm/man /usr/lib/node_modules/npm/doc /usr/lib/node_modules/npm/html