FROM selenium/standalone-chrome-debug:latest
LABEL maintainer=admin@chenmin.org

ENV DEBIAN_FRONTEND=noninteractive \
	LANG=en_US.UTF-8 \
	LANGUAGE=en_US.UTF-8 \
	LC_ALL=C.UTF-8 \
	REMOTE_HOST=localhost \
	REMOTE_PORT=5900

RUN sudo apt-get update \
        && sudo apt -y install curl dirmngr apt-transport-https lsb-release ca-certificates \
	&& curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash - \
	&& sudo apt install nodejs \
	&& sudo apt-get install -y git tzdata \
	&& git clone https://github.com/novnc/noVNC.git /home/seluser/noVNC \
	&& git clone https://github.com/novnc/websockify /home/seluser/noVNC/utils/websockify \
	&& rm -rf /home/seluser/noVNC/.git \
	&& rm -rf /home/seluser/noVNC/utils/websockify/.git \
	&& cd /home/seluser/noVNC \
	&& npm install \
	&& ./utils/use_require.js \
	&& cp /home/seluser/noVNC/node_modules/requirejs/require.js /home/seluser/noVNC/build \
	&& sed -i -- "s/ps -p/ps -o pid | grep/g" /home/seluser/noVNC/utils/launch.sh \
	&& sudo rm /etc/localtime \
	&& sudo ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 8081
 
