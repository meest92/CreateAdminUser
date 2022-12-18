# CreateAdminUser
Script para generar un usuario Administrador y deshabilitar el resto de administradores de la máquina.
Este script nos permitirá:
- Crear un usuario administrador en la máquina objetivo.
- Establecer un password definido por nosotros a este usuario.
- Deshabilitar el resto de usuarios de la máquina.

# ¿Cómo funciona?
Este script comprueba si el usuario que nosotros queremos crear existe, si existe le cambia la contraseña, se establece como contraseña que no caduca 
y deshabilita el resto de usuarios que tiene la máquina.
Genera un Log en el escritorio del usuario actual para comprobar que toda la ejecución ha sido satisfactoria.

# Posibles utilidades
Se puede usar en entornos de dominio muy grandes para que cuando la máquina se establezca en el dominio, automáticamente se cree el usuario administrador local
que queremos establecer.
También, es muy interesante cruzar este script con la instalación de LAPS, que nos permite generar passwords random a nuestro usuario administrador local y hacer
que cada X tiempo cambie este password, de esta manera ganamos en seguridad por si la contraseña que nosotros hemos establecido es vulnerada en algún momento.
