# PRACTICA JAKARTA

## 1. Crear una aplicación hecha en JakartaEE

1. 📥 **Instalar la aplicación de Tomcat**  
   - Visita la [página web oficial de Apache Tomcat](https://tomcat.apache.org/download-migration.cgi).
   - Descarga el archivo `windows.zip`.
   - Descomprime el archivo y ya tendrás Tomcat listo.

2. 📝 **Crear el proyecto**  
   - Abre el IDE de tu preferencia. En este ejemplo, usaremos IntelliJ IDEA:
     - Selecciona **New Project**.
     - Completa los datos del nombre del proyecto y su ubicación.
     - En **Template**, selecciona **Web Application**.
     - Cambia **Generator** a **Jakarta EE**.

   - 🔧 **Configuración del servidor Tomcat**:
     - En la parte superior, haz clic en el ícono de las "4 líneas".
     - Selecciona **Run** y luego **Edit Configuration**.
     - Haz clic en el botón `+` y selecciona **Tomcat Server > Local**.
       - En la opción **Deployment**, agrega una nueva configuración:
         - Selecciona **Artifact** y elige tu archivo `proyecto.war`.

3. 🚀 **Ejecutar el proyecto**
   - Haz clic en **Run**. Esto debería iniciar el proyecto y abrirlo en el navegador.