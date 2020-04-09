USE [vsdb]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[deleteCitizen]
	@CitizenID int
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	BEGIN TRANSACTION
		IF (SELECT COUNT(1) FROM [dbo].[Citizen] WHERE [dbo].[Citizen].[CitizenID] = @CitizenID) = 1 
		BEGIN
			declare @addressId as int = (Select [Citizen].[AddressID] FROM [dbo].[Citizen] WHERE [Citizen].[CitizenID] = @CitizenID);
			declare @contactId as int = (Select [Citizen].[ContactID] FROM [dbo].[Citizen] WHERE [Citizen].[CitizenID] = @CitizenID);
			DELETE FROM [dbo].[Citizen] WHERE [Citizen].CitizenID = @CitizenID;
		END
	COMMIT
	BEGIN TRANSACTION
		    DELETE FROM [dbo].[Address] WHERE [Address].[AddressID] = @addressId;

			DELETE FROM [dbo].[Contact] WHERE [Contact].[ContactID] = @contactId;
	COMMIT
END
GO


