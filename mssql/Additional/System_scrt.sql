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

Use Kinder_garden
drop role AdminS
GO

Use Kinder_garden
create role AdminS
Go

	Use Kinder_garden

	GRANT all PRIVILEGES  to AdminS WITH GRANT OPTION
	go

	grant select, insert, delete, update on [dbo].[Rations] to AdminS
		grant select, insert, delete, update on [dbo].[Type_groups] to AdminS
			grant select, insert, delete, update on [dbo].[Groups] to AdminS
				grant select, insert, delete, update on [dbo].[Relatives] to AdminS
					grant select, insert, delete, update on [dbo].[List_of_relatives_type]  to AdminS
						grant select, insert, delete, update on [dbo].[Relatives_type] to AdminS
							grant select, insert, delete, update on [dbo].[Child] to AdminS
								grant select, insert, delete, update on [dbo].[Medical_card] to AdminS
									grant select, insert, delete, update on [dbo].[Type_of_sick_leaves] to AdminS
										grant select, insert, delete, update on [dbo].[Sick_leaves] to AdminS
											grant select, insert, delete, update on [dbo].[Vaccination_reasons] to AdminS
												grant select, insert, delete, update on [dbo].[Type_of_vaccination] to AdminS
													grant select, insert, delete, update on [dbo].[Vaccination] to AdminS
														grant select, insert, delete, update on [dbo].[Height_Weight] to AdminS
															grant select, insert, delete, update on [dbo].[Sections] to AdminS
																grant select, insert, delete, update on [dbo].[List_of_section] to AdminS
																	grant select, insert, delete, update on [dbo].[Type_of_passage] to AdminS
																		grant select, insert, delete, update on [dbo].[Medical_Journal] to AdminS
																			grant select, insert, delete, update on [dbo].[Employee] to AdminS
																				grant select, insert, delete, update on [dbo].[Department] to AdminS
																					grant select, insert, delete, update on [dbo].[Type_of_position] to AdminS
																						grant select, insert, delete, update on [dbo].[Appointment] to AdminS
																							grant select, insert, delete, update on [dbo].[Teacher_of_section] to AdminS
																								grant select, insert, delete, update on [dbo].[Visits_Journal] to AdminS




																						grant execute on [PersDataOfSelectGroup] to AdminS
																							grant execute on [ContactToRelativesOfGroupOrChild] to AdminS
																								grant execute on [GroupMembers] to AdminS
																									grant execute on [PersWithChildOrGroupDate] to AdminS
																										grant execute on [BiomDataOfChildInDate] to AdminS
																											grant execute on [VaccinOfChild] to AdminS
																												grant execute on [VaccinOfChildInNearTime] to AdminS
																													grant execute on [SectionOfMembers] to AdminS
																														grant execute on [TimetableForGroupChildOrTeacher] to AdminS
																															grant execute on [VisitJournalTableCost] to AdminS
																																grant execute on [PayChildGroupGardenOfDate] to AdminS

																																	exec  sp_droplogin 'admins'
																																	exec  sp_addlogin 'admins','password_123',[Kinder_garden]
																																	GO

																																	exec  sp_dropuser  'AD1'
																																	exec sp_adduser 'admins', 'AD1'
																																	GO

																																	exec  sp_droprolemember 'AdminS','AD1'
																																	exec  sp_addrolemember 'AdminS','AD1'
																																	GO