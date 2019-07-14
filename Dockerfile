FROM selenium/standalone-chrome-debug:latest
LABEL maintainer=admin@chenmin.org

ENV DEBIAN_FRONTEND=noninteractive \
	LANG=en_US.UTF-8 \
	LANGUAGE=en_US.UTF-8 \
	LC_ALL=C.UTF-8 \
	REMOTE_HOST=localhost \
	REMOTE_PORT=5900

RUN sudo apt-get update \
	&& sudo apt-get install -y git nodejs npm \
	&& git clone https://github.com/novnc/noVNC.git /home/seluser/noVNC \
	&& git clone https://github.com/novnc/websockify /home/seluser/noVNC/utils/websockify \
	&& rm -rf /home/seluser/noVNC/.git \
	&& rm -rf /home/seluser/noVNC/utils/websockify/.git \
	&& cd /home/seluser/noVNC \
	&& npm install npm@latest \
	&& npm install \
	&& ./utils/use_require.js --as commonjs --with-app \
	&& cp /home/seluser/noVNC/node_modules/requirejs/require.js /home/seluser/noVNC/build \
	&& sed -i -- "s/ps -p/ps -o pid | grep/g" /home/seluser/noVNC/utils/launch.sh \

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 8081
