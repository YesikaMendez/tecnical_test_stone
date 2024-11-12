ALTER PROCEDURE GetUserPermissions @UserID INT,
@EntityID INT AS BEGIN
SET
    NOCOUNT ON;

DECLARE @tablename VARCHAR(255);

DECLARE @primary_key_column VARCHAR(255);

DECLARE @sql NVARCHAR(MAX);

-- Obtiene el nombre de la tabla desde EntityCatalog
SELECT
    @tablename = entit_name
FROM
    EntityCatalog
WHERE
    id_entit = @EntityID;

-- Recupera el nombre de la columna de la clave primaria
SELECT
    TOP 1 @primary_key_column = c.name
FROM
    sys.indexes i
    INNER JOIN sys.index_columns ic ON i.object_id = ic.object_id
    AND i.index_id = ic.index_id
    INNER JOIN sys.columns c ON ic.object_id = c.object_id
    AND c.column_id = ic.column_id
WHERE
    i.is_primary_key = 1
    AND OBJECT_NAME(i.object_id) = @tablename;

-- Construye la consulta SQL dinámica para obtener permisos
SET
    @sql = '
    -- Permisos específicos a nivel de registro para el usuario
    SELECT 
        p.name,
        p.description,
        p.can_create,
        p.can_read,
        p.can_update,
        p.can_delete,
        p.can_import,
        p.can_export,
        pur.peusr_record,
        pur.peusr_include
    FROM PermiUserRecord pur
    JOIN Permission p ON pur.permission_id = p.id_permi
    JOIN UserCompany us ON pur.usercompany_id = us.id_useco
    JOIN ' + QUOTENAME(@tablename) + ' AS t ON t.' + QUOTENAME(@primary_key_column) + ' = pur.peusr_record -- Verifica existencia en tabla específica
    WHERE us.user_id = @UserID
        AND pur.entitycatalog_id = @EntityID 
        AND us.useco_active = 1

    UNION ALL

    -- Permisos a nivel de entidad para el usuario
    SELECT 
        p.name,
        p.description,
        p.can_create,
        p.can_read,
        p.can_update,
        p.can_delete,
        p.can_import,
        p.can_export,
        NULL AS peusr_record,
        pu.peusr_include
    FROM PermiUser pu
    JOIN Permission p ON pu.permission_id = p.id_permi
    JOIN UserCompany uc ON pu.usercompany_id = uc.id_useco
    WHERE uc.user_id = @UserID 
        AND pu.entitycatalog_id = @EntityID
        AND uc.useco_active = 1

    UNION ALL

    -- Permisos específicos a nivel de registro para el rol del usuario
    SELECT 
        p.name,
        p.description,
        p.can_create,
        p.can_read,
        p.can_update,
        p.can_delete,
        p.can_import,
        p.can_export,
        prr.perrc_record,
        prr.perrc_include
    FROM PermiRoleRecord prr
    JOIN Permission p ON prr.permission_id = p.id_permi
    JOIN Role r ON prr.role_id = r.id_role
    JOIN UserCompany uc on uc.company_id = r.company_id
    JOIN ' + QUOTENAME(@tablename) + ' AS t ON t.' + QUOTENAME(@primary_key_column) + ' = prr.perrc_record -- Verifica existencia en tabla específica
    WHERE uc.user_id = @UserID 
        AND prr.entitycatalog_id = @EntityID 
        AND uc.useco_active = 1

    UNION ALL

    -- Permisos a nivel de entidad para el rol del usuario
    SELECT 
        p.name,
        p.description,
        p.can_create,
        p.can_read,
        p.can_update,
        p.can_delete,
        p.can_import,
        p.can_export,
        NULL AS peusr_record,
        pr.perol_include
    FROM PermiRole pr
    JOIN Permission p ON pr.permission_id = p.id_permi
    JOIN Role r ON pr.role_id = r.id_role
    JOIN UserCompany uc ON uc.company_id = r.company_id
    WHERE uc.user_id = @UserID 
        AND pr.entitycatalog_id = @EntityID 
        AND uc.useco_active = 1;';

-- Ejecuta la consulta dinámica
EXEC sp_executesql @sql,
N '@UserID INT, @EntityID INT',
@UserID,
@EntityID;

END;

GO