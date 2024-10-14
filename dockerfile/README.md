
# Docker Workflow Guide

Este documento proporciona una guía resumida para la construcción, ejecución y optimización de imágenes Docker. Incluye ejemplos para gestionar variables y optimizar el tamaño de las imágenes.

## 1. Creación de una imagen sencilla

### Dockerfile básico:
```dockerfile
FROM debian:latest
COPY archivo.txt /home/alumno/archiv.txt
ENTRYPOINT echo "Hola alumno"
```

### Pasos:
1. **Construir la imagen**:
   ```bash
   docker build -t luistest:version001 .
   ```

2. **Ejecutar la imagen**:
   ```bash
   docker run --rm luistest:version001
   ```

3. **Etiquetar la imagen** (opcional):
   ```bash
   docker tag luistest:version001 luistest:latest
   docker run --rm luistest
   ```

4. **Mostrar contenido del archivo**:
   ```bash
   docker run --rm luistest cat /home/alumno/archiv.txt
   ```

## 2. CMD vs ENTRYPOINT

### Dockerfile con CMD y ENTRYPOINT:
```dockerfile
FROM debian:latest
ENTRYPOINT ["/bin/sh", "-c"]
CMD ["echo 'Hola mundo'"]
```

- **Ejecutar**:
  ```bash
  docker run --rm luistest 'cat /home/alumno/archiv.txt'
  ```

## 3. ARG vs ENV

### Dockerfile con ARG y ENV:
```dockerfile
FROM debian:latest

ARG usuario=profesor
ENV minombre=${usuario}

COPY entrypoint.sh /home/$minombre/entrypoint.sh
WORKDIR /home/$minombre

CMD ["sh", "entrypoint.sh"]
```

### entrypoint.sh:
```bash
echo "Directorio de trabajo $(pwd $minombre)"
echo "Variable de entorno \$minombre=$minombre"
```

### Comandos:
1. **Construir y ejecutar**:
   ```bash
   docker build -t luistest:v2 .
   docker run --rm luistest:v2
   ```

2. **Pasar variable de entorno al contenedor**:
   ```bash
   docker run --rm -e minombre=luis luistest:v2
   ```

3. **Construir con argumento personalizado**:
   ```bash
   docker build --build-arg usuario=UNO -t luistest:v2 .
   docker run --rm luistest:v2
   ```

## 4. Imagen con aplicación Java

### Dockerfile Java:
```dockerfile
FROM eclipse-temurin:21
RUN mkdir -p /opt/app && mkdir /opt/app/src

COPY Main.java conf.properties /opt/app/src/
WORKDIR /opt/app/src

RUN javac --enable-preview --source 21 Main.java
CMD ["java", "--enable-preview", "Main"]
```

### Main.java:
```java
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;

void main(){
    Properties properties = new Properties();
    try {
        properties.load(new FileInputStream(new File("conf.properties")));
        System.out.println(properties.get("DRIVER"));
        System.out.println(properties.get("URL"));
        System.out.println(properties.get("USUARIO"));
        System.out.println(properties.get("CLAVE"));
    } catch (FileNotFoundException e) {
        e.printStackTrace();
    } catch (IOException e) {
        e.printStackTrace();
    }
}
```

### conf.properties:
```
DRIVER=mysql
URL=mi.servidor.en.mi.dominio.es
USUARIO=3l.Pr0f3
CLAVE=4.Ti.T3.10.v0y.4.c0nt4r
```

### Ejecutar con configuración personalizada:
```bash
docker run --rm -v ./conf-per.properties:/opt/app/src/conf.properties luistest:version003
```

## 5. Optimización de imagen con múltiples etapas

### Dockerfile con etapas:
```dockerfile
# Etapa 1: COMPILACIÓN
FROM eclipse-temurin:21 AS builder
RUN mkdir -p /opt/app && mkdir /opt/app/src
COPY Main.java conf.properties /opt/app/src/
WORKDIR /opt/app/src
RUN javac --enable-preview --source 21 Main.java

# Etapa 2: EJECUCIÓN
FROM eclipse-temurin:21-alpine
WORKDIR /root/
COPY --from=builder /opt/app/src/Main.class /opt/app/src/conf.properties .
CMD ["java", "--enable-preview", "Main"]
```

### Construcción y ejecución:
```bash
docker build -t luistest:version005 .
docker run --rm luistest:version005
```

Para reducir aún más el tamaño de la imagen (por debajo de 200MB), considera usar `jlink` para crear una JRE personalizada.
