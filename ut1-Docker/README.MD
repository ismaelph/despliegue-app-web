# **PRACTICA DOCKER CLI**

### **Descripción**

En esta práctica vamos a crear tres microservicios en Docker que se conectarán entre sí mediante una **red interna**:

1. **MariaDB**: Este servicio de base de datos no será accesible desde el exterior, solo podrá ser utilizado por otros contenedores dentro de la red interna. Al iniciar el contenedor, se debe crear el usuario `pepe` con la contraseña `despliegue`.

2. **PHP-Apache**: Un servidor web accesible desde el exterior en el **puerto 80**. Este servicio debe poder conectarse a la base de datos y tendrá un archivo `info.php` en la raíz pública con la función `phpinfo()`.

3. **phpMyAdmin**: Herramienta de administración de bases de datos accesible desde el exterior en el **puerto 8080** (o 443 si se utiliza un VPS). Este servicio debe conectarse a la base de datos de **MariaDB**. Para simplificar la conexión, se pasará la variable de entorno `PMA_HOST=nombre_contenedor_mariaDB`.

---

### **Pasos a seguir**

#### 1. Crear una red interna para la comunicación entre los contenedores

```bash
docker network create ejercicio
```

