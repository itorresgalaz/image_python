#FROM desde que imagen
FROM ubuntu 
#RUN ejecuta comandos no interactivos -y para aceptar
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y python2

#RUN con && para tener solo una capa
RUN echo 1.0 >> /etc/version && apt-get install -y git \
    && apt-get install -y iputils-ping

RUN mkdir /datos $
#WORKDIR directorio de trabajo 
WORKDIR /datos 

RUN touch f1.txt && echo TEST 1 >> f1.txt
#CMD comando por defecto del contenedor, solo debe haber 1 CMD
#CMD ["echo", "Welcome"] /bin/sh => Shell
#CMD ["/bin/sh"]

#COPY copia archivos del host en el workdir del contenedor
COPY index.html .
COPY file.txt /datos

#ADD permite llevar ficheros y .tar del host al workdir del contenedor

##ENV variables de entorno
ENV dir=/data dir1=/data1
RUN mkdir $dir && mkdir $dir1

#ARG similar a ENV pero no se le debe poner un valor , se le puede pasar un argumento a la build de la image
# ARG dir2
# RUN mkdir $dir2
# ARG user 
# ENV user_docker $user
# ADD add_user.sh /datos/
# RUN /datos/add_user.sh

##EXPOSE
RUN apt-get install -y apache2
EXPOSE 80
ADD entrypoint.sh /datos
#CMD
CMD /datos/entrypoint.sh

#VOLUME
ADD paginas /var/www/html
VOLUME [ "/var/www/html" ]


#ENTRYPOINT siempre ejecuta el comando que se le da, se le puede añadir argumentos
#ENTRYPOINT [ "/bin/bash" ]

