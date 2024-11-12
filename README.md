#README - Prueba Técnica: Sistema de Gestión de Permisos
Descripción General
Este proyecto se desarrolla como una prueba técnica para implementar y gestionar un sistema de permisos basado en distintos niveles de control: entidad, usuario y registro específico. A lo largo del proyecto, se realizaron diversas modificaciones para optimizar la estructura y mejorar el rendimiento, así como para establecer una jerarquía coherente de permisos.

##Objetivo
Implementar una estructura de permisos jerárquica y un procedimiento almacenado que permita recuperar los permisos asignados a un usuario a nivel de entidad o de registros específicos dentro de la entidad. Se realizaron cambios en la estructura de las tablas y en el tipo de datos utilizado, además de agregar un procedimiento almacenado que centraliza la consulta de permisos efectivos.

##Estructura del Proyecto
Modificaciones en la estructura de la base de datos:

Se considero las querys aportadas para la creación de las tablas y conocer la estructura de la base de datos, se realizaron
Cambio de BIGINT a INT en la tabla EntityCatalog: Se optó por cambiar a INT en lugar de BIGINT para reducir el uso de almacenamiento y mejorar el rendimiento sin sacrificar funcionalidad, ya que el rango de valores de INT es suficiente para los registros esperados. Además, garantiza la consistencia en la base de datos, evitando conflictos de tipo en claves foráneas y facilitando el mantenimiento.

Eliminación del campo perol_record en la tabla PermiRole: Este campo fue eliminado porque la tabla PermiRole gestiona permisos a nivel de entidad completa, sin especificar un registro individual. Al ser innecesario en este contexto, se eliminó para simplificar la estructura y evitar redundancias en la gestión de permisos.

##Jerarquía de Permisos: La estructura de permisos sigue una jerarquía lógica para satisfacer los requisitos del sistema:

Permisos a nivel de entidad: Permiten el acceso a toda la entidad, sin considerar registros específicos. Estos permisos se almacenan en las tablas PermiUser y PermiRole.

Permisos a nivel de registro específico: Permiten definir permisos a registros individuales dentro de la entidad. Estos permisos se encuentran en las tablas PermiUserRecord y PermiRoleRecord.

Esta jerarquía asegura que los permisos sean consistentes y reflejen el nivel de acceso deseado para cada usuario o rol.

##El procedimiento almacenado GetUserPermissions

El procedimiento almacenado GetUserPermissions permite recuperar los permisos de un usuario específico sobre una entidad en el sistema, tanto a nivel de registros individuales como a nivel de la entidad completa. Este procedimiento incluye permisos asignados directamente al usuario y aquellos heredados de los roles a los que pertenece.

Parámetros de Entrada
@UserID (INT): Identificador del usuario para el cual se quieren obtener los permisos.
@EntityID (INT): Identificador de la entidad sobre la cual se validarán los permisos.
Funcionamiento
Asignación de Nombre de Tabla y Clave Primaria:

Se consulta la tabla EntityCatalog para asignar el nombre de la tabla asociada a la entidad (@tablename).
Posteriormente, se obtiene el nombre de la columna de la clave primaria de la tabla (@primary_key_column) correspondiente a la entidad recuperada desde EntityCatalog.
Con esta configuración, el procedimiento valida que los permisos a nivel de registro existan en su tabla correspondiente, como CostCenter o BranchOffice.
Construcción y Ejecución de la Consulta Dinámica:

La consulta se construye dinámicamente, permitiendo manejar múltiples tablas y nombres de claves primarias de forma flexible.
Combina cuatro subconsultas usando UNION ALL:

Permisos a Nivel de Registro para el Usuario: Recupera permisos específicos de cada registro asociados directamente al usuario.

Permisos a Nivel de Entidad para el Usuario: Recupera permisos generales asignados al usuario en la entidad completa.

Permisos a Nivel de Registro para el Rol del Usuario: Recupera permisos específicos de cada registro asociados a los roles del usuario.

Permisos a Nivel de Entidad para el Rol del Usuario: Recupera permisos generales a nivel de entidad asociados a los roles del usuario.

Ejecución Segura:

La consulta se ejecuta usando sp_executesql para un manejo seguro y parametrizado de los datos, lo que protege contra inyecciones SQL y asegura que los permisos se verifiquen correctamente.



Ejemplo de Uso
sql

DECLARE @UserID INT = 1;  -- Ajusta el ID del usuario que deseas probar
DECLARE @EntityID INT = 2; -- Ajusta el ID de la entidad que deseas probar

-- Ejecutar el procedimiento almacenado con los parámetros de prueba
EXEC GetUserEffectivePermissions @UserID = @UserID, @EntityID = @EntityID;
Explicación de la Jerarquía de Permisos

##En el video adjunto, se presentan:

Las decisiones de diseño tomadas para la estructura de la base de datos.
El funcionamiento y resultado de las consultas en el procedimiento almacenado.
Ejemplos de salida con los datos de prueba, destacando la jerarquía de permisos y cómo cada tipo de permiso afecta el resultado final.
Este README proporciona una guía para entender la estructura de la prueba técnica, los cambios realizados en la base de datos, y cómo se desarrolló y probó el procedimiento almacenado.
