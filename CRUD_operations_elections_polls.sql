CREATE PROCEDURE dbo.viewElections
AS
BEGIN
	SELECT * 
	FROM vsdb.dbo.Election
	ORDER BY vsdb.dbo.Election.ElectionName
END;

Execute vsdb.dbo.viewElections;


CREATE PROCEDURE [dbo].[insertElections]
@ElectionName varchar(120), 
@DateCreated date,
@DateConducted date,
@ResultsDate date,
@Status int,
@Winner int,
@Creator int
AS
BEGIN
		SET NOCOUNT ON;
		SET XACT_ABORT ON;
		BEGIN TRANSACTION
			BEGIN
				INSERT INTO vsdb.dbo.Election (ElectionName, DateCreated, DateConducted, ResultsDate, [Status], Winner, Creator) VALUES (@ElectionName, @DateCreated, @DateConducted, @ResultsDate, @Status, @Winner, @Creator)
			END
		COMMIT
END;

DECLARE @date DATE
SET @date = CONVERT (date, GETDATE())
EXECUTE vsdb.dbo.insertElections @ElectionName = 'General Election', @DateCreated =  @date, @DateConducted = @date,@ResultsDate = @date, @Status = 1, @Winner = 2, @Creator = 1;