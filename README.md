README - Prueba Técnica: Sistema de Gestión de Permisos
Descripción General
Este proyecto se desarrolla como una prueba técnica para implementar y gestionar un sistema de permisos basado en distintos niveles de control: entidad, usuario y registro específico. A lo largo del proyecto, se realizaron diversas modificaciones para optimizar la estructura y mejorar el rendimiento, así como para establecer una jerarquía coherente de permisos.

Objetivo
Implementar una estructura de permisos jerárquica y un procedimiento almacenado que permita recuperar los permisos asignados a un usuario a nivel de entidad o de registros específicos dentro de la entidad. Se realizaron cambios en la estructura de las tablas y en el tipo de datos utilizado, además de agregar un procedimiento almacenado que centraliza la consulta de permisos efectivos.

Estructura del Proyecto
Modificaciones en la estructura de la base de datos:

Se considero las querys aportadas para la creación de las tablas y conocer la estructura de la base de datos, se realizaron
Cambio de BIGINT a INT en la tabla EntityCatalog: Se optó por cambiar a INT en lugar de BIGINT para reducir el uso de almacenamiento y mejorar el rendimiento sin sacrificar funcionalidad, ya que el rango de valores de INT es suficiente para los registros esperados. Además, garantiza la consistencia en la base de datos, evitando conflictos de tipo en claves foráneas y facilitando el mantenimiento.

Eliminación del campo perol_record en la tabla PermiRole: Este campo fue eliminado porque la tabla PermiRole gestiona permisos a nivel de entidad completa, sin especificar un registro individual. Al ser innecesario en este contexto, se eliminó para simplificar la estructura y evitar redundancias en la gestión de permisos.

Jerarquía de Permisos: La estructura de permisos sigue una jerarquía lógica para satisfacer los requisitos del sistema:

Permisos a nivel de entidad: Permiten el acceso a toda la entidad, sin considerar registros específicos. Estos permisos se almacenan en las tablas PermiUser y PermiRole.

Permisos a nivel de registro específico: Permiten definir permisos a registros individuales dentro de la entidad. Estos permisos se encuentran en las tablas PermiUserRecord y PermiRoleRecord.

Esta jerarquía asegura que los permisos sean consistentes y reflejen el nivel de acceso deseado para cada usuario o rol.

El procedimiento almacenado GetUserEffectivePermissions

está diseñado para devolver los permisos asignados a un usuario específico dentro de una entidad en particular, considerando tanto permisos a nivel de entidad como permisos a nivel de registro. La consulta considera diferentes niveles de permisos basados en la relación entre el usuario y los roles asignados, proporcionando un control detallado de los accesos.

Parámetros de Entrada
@UserID (INT): ID del usuario para el cual se desean obtener los permisos.
@EntityID (INT): ID de la entidad sobre la cual se desean verificar los permisos.

Estructura del Procedimiento
El procedimiento consulta varias tablas de permisos y roles para consolidar los permisos efectivos de un usuario. A continuación se detallan las cuatro partes de la consulta y las razones para su inclusión.

Permisos específicos a nivel de registro para el usuario

Se obtienen permisos asignados directamente al usuario para registros específicos dentro de la entidad.
Tablas involucradas: PermiUserRecord, Permission, y UserCompany.
Filtra por user_id y entitycatalog_id específicos, considerando solo usuarios activos.
Permisos a nivel de entidad para el usuario

Se obtienen permisos que el usuario tiene para la entidad en su totalidad, sin especificar un registro particular.
Tablas involucradas: PermiUser, Permission, y UserCompany.
También se filtra por user_id y entitycatalog_id, y asegura que el usuario esté activo.
Permisos específicos a nivel de registro para el rol del usuario

Se consultan permisos asignados a roles específicos en la entidad, permitiendo obtener permisos indirectos del usuario mediante su rol.
Tablas involucradas: PermiRoleRecord, Permission, Role, y UserCompany.
Considera la relación entre el rol del usuario y la entidad, además de validar que el usuario esté activo.
Permisos a nivel de entidad para el rol del usuario

Se consultan permisos asignados al rol del usuario a nivel de entidad completa.
Tablas involucradas: PermiRole, Permission, Role, y UserCompany.
Filtra permisos de rol por entidad, asegurando la activación del usuario y que pertenezca a la misma compañía que el rol.



Ejemplo de Uso
sql

DECLARE @UserID INT = 1;  -- Ajusta el ID del usuario que deseas probar
DECLARE @EntityID INT = 2; -- Ajusta el ID de la entidad que deseas probar

-- Ejecutar el procedimiento almacenado con los parámetros de prueba
EXEC GetUserEffectivePermissions @UserID = @UserID, @EntityID = @EntityID;
Explicación de la Jerarquía de Permisos

En el video adjunto, se presentan:

Las decisiones de diseño tomadas para la estructura de la base de datos.
El funcionamiento y resultado de las consultas en el procedimiento almacenado.
Ejemplos de salida con los datos de prueba, destacando la jerarquía de permisos y cómo cada tipo de permiso afecta el resultado final.
Este README proporciona una guía para entender la estructura de la prueba técnica, los cambios realizados en la base de datos, y cómo se desarrolló y probó el procedimiento almacenado.
