USE tecnical_test_stone
GO
    ALTER PROCEDURE GetUserEffectivePermissions @UserID INT,
    @EntityID INT AS BEGIN
SET
    NOCOUNT ON;

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
FROM
    PermiUserRecord pur
    JOIN Permission p ON pur.permission_id = p.id_permi
    JOIN UserCompany us ON pur.usercompany_id = us.id_useco
WHERE
    us.user_id = @UserID
    AND pur.entitycatalog_id = @EntityID
    AND us.useco_active = 1
UNION
ALL -- Permisos a nivel de entidad para el usuario
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
FROM
    PermiUser pu
    JOIN Permission p ON pu.permission_id = p.id_permi
    JOIN UserCompany uc ON pu.usercompany_id = uc.id_useco
WHERE
    uc.user_id = @UserID
    AND pu.entitycatalog_id = @EntityID
    AND uc.useco_active = 1
UNION
ALL -- Permisos específicos a nivel de registro para el rol del usuario
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
FROM
    PermiRoleRecord prr
    JOIN Permission p ON prr.permission_id = p.id_permi
    JOIN Role r ON prr.role_id = r.id_role
    JOIN UserCompany uc on uc.company_id = r.company_id
WHERE
    uc.user_id = @UserID
    AND prr.entitycatalog_id = @EntityID
    AND uc.useco_active = 1
UNION
ALL -- Permisos a nivel de entidad para el rol del usuario
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
FROM
    PermiRole pr
    JOIN Permission p ON pr.permission_id = p.id_permi
    JOIN Role r ON pr.role_id = r.id_role
    JOIN UserCompany uc ON uc.company_id = r.company_id
WHERE
    uc.user_id = @UserID
    AND pr.entitycatalog_id = @EntityID
    AND uc.useco_active = 1;

END;

GO