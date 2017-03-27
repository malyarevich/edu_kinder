USE Kinder_garden
--SELECT * FROM sys.fn_builtin_permissions('SERVER') ORDER BY permission_name;
--SELECT * FROM sys.fn_builtin_permissions('Kinder_garden') ORDER BY permission_name;

--
--create role [ViewServerState] 
--add [SomeFakeLogin] to [ViewServerState]
--give rights [VIEW SERVER] for [ViewServerState]
--
-------------------Role Methodist
USE Kinder_garden
GO
CREATE ROLE PositionMethodist AUTHORIZATION dbo--sa
GO
--ALTER ROLE PositionMethodist ADD MEMBER userMeth1
GO
--ALTER ROLE PositionMethodist ADD MEMBER userMeth2
GO
GRANT EXECUTE ON OBJECT::dbo.PersDataOfSelectGroup
    TO PositionMethodist;
GRANT EXECUTE ON OBJECT::dbo.GroupMembers
    TO PositionMethodist;
GRANT EXECUTE ON OBJECT::dbo.TimetableForGroupChildOrTeacher
    TO PositionMethodist;
GRANT EXECUTE ON OBJECT::dbo.SectionOfMembers
    TO PositionMethodist;
GRANT EXECUTE ON OBJECT::dbo.ContactToRelativesOfGroupOrChild
    TO PositionMethodist;
GRANT UPDATE ON OBJECT::dbo.Child TO PositionMethodist;
GO
GO
-------------------Role Employee
USE Kinder_garden
GO
CREATE ROLE PositionEmployee AUTHORIZATION dbo--sa
GO
--ALTER ROLE PositionMethodist ADD MEMBER userEmp1
GO
--ALTER ROLE PositionMethodist ADD MEMBER userEmp2
GO
GRANT EXECUTE ON OBJECT::dbo.PersDataOfSelectGroup
    TO PositionEmployee;
GRANT EXECUTE ON OBJECT::dbo.GroupMembers
    TO PositionEmployee;
GRANT EXECUTE ON OBJECT::dbo.TimetableForGroupChildOrTeacher
    TO PositionEmployee;
GRANT EXECUTE ON OBJECT::dbo.SectionOfMembers
    TO PositionEmployee;
GRANT EXECUTE ON OBJECT::dbo.ContactToRelativesOfGroupOrChild
    TO PositionEmployee;
GO
-------------------Role Revative
USE Kinder_garden
GO
CREATE ROLE PositionRelative AUTHORIZATION dbo--sa
GO
--ALTER ROLE PositionMethodist ADD MEMBER userRel1
GO
--ALTER ROLE PositionMethodist ADD MEMBER userRel2
GO
GRANT EXECUTE ON OBJECT::dbo.PersDataOfSelectGroup
    TO PositionRelative;
GRANT EXECUTE ON OBJECT::dbo.GroupMembers
    TO PositionRelative;
GRANT EXECUTE ON OBJECT::dbo.BiomDataOfChildInDate
    TO PositionRelative;
GRANT EXECUTE ON OBJECT::dbo.PersWithChildOrGroupDate
    TO PositionRelative;
GRANT EXECUTE ON OBJECT::dbo.VaccinOfChildOfChild
    TO PositionRelative;
GRANT EXECUTE ON OBJECT::dbo.VaccinOfChildOfChildInNearTime
    TO PositionRelative;
GO 
GO

--delete role
--ALTER ROLE [ViewServerState] DROP MEMBER [SomeFakeLogin]
--GO

GO
CREATE ROLE [SupportRole]

GRANT CONNECT ON ENDPOINT::[Dedicated Admin Connection] TO [SupportRole]
GRANT VIEW DEFINITION ON ENDPOINT::[Dedicated Admin Connection] TO [SupportRole]
GRANT VIEW DEFINITION ON LOGIN::[sa] TO [SupportRole]
GRANT CONNECT SQL TO [SupportRole]
GRANT VIEW ANY DATABASE TO [SupportRole]
GRANT VIEW ANY DEFINITION TO [SupportRole]
GRANT VIEW SERVER STATE TO [SupportRole]
GO

ALTER ROLE [SupportRole] ADD MEMBER [NightsAndWeekendsPeeps]
GO