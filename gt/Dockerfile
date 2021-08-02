FROM chenmins/standalone-chrome-debug-novnc:latest
LABEL maintainer=admin@chenmin.org

RUN sudo apt-get clean && sudo apt-get update
RUN sudo apt-get install -y locales
RUN sudo localedef -c -f UTF-8 -i zh_CN zh_CN.utf8
RUN sudo chmod a+w /usr/share/fluxbox/styles/ubuntu-light
RUN sudo sed -i 's/Ubuntu-10:bold/WenQuanYi Zen Hei-10/g' /usr/share/fluxbox/styles/ubuntu-light
RUN sudo sed -i 's/Ubuntu-12:bold/WenQuanYi Zen Hei-12/g' /usr/share/fluxbox/styles/ubuntu-light
RUN sudo sed -i 's/Ubuntu-10/WenQuanYi Zen Hei-10/g' /usr/share/fluxbox/styles/ubuntu-light
ENV LANG zh_CN.utf8
ENV TZ Asia/Shanghai

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 8081
 
