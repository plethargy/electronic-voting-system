
CREATE PROCEDURE InsertCitizen
	@City varchar(120),
	@Country varchar(120),
	@PostalCode varchar(8),
	@Street varchar(120),
	@CellPhone varchar(15),
	@Telephone varchar(15),
	@Email varchar(120),
	@Fax varchar(120),
	@IDNumber varchar(15),
	@Name varchar(120),
	@Surname varchar(120)
AS

BEGIN
BEGIN TRANSACTION
   
   INSERT INTO [vsdb].[dbo].[Address] (City, Country, PostalCode, Street) VALUES (@City, @Country, @PostalCode , @Street);
   
   declare @addressId as int = scope_identity();

   INSERT INTO [vsdb].[dbo].[Contact] (CellPhone, Telephone, Email, Fax) VALUES (@CellPhone, @Telephone, @Email, @Fax);

   INSERT INTO [vsdb].[dbo].[Citizen] (AddressID, ContactID, IDNumber, [Name], Surname) VALUES (@addressId, SCOPE_IDENTITY(), @IDNumber, @Name, @Surname);

COMMIT
END