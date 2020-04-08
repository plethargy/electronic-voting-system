CREATE PROCEDURE dbo.viewElections
AS
BEGIN
	SELECT * 
	FROM dbo.Election
	ORDER BY dbo.Election.ElectionName
END;

Execute viewElections;


CREATE PROCEDURE [dbo].[updateElectionResultsDate]
@ElectionName varchar(120), 
@ResultsDate date = NULL
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	BEGIN TRANSACTION
		BEGIN 
			UPDATE Election SET ResultsDate = @ResultsDate WHERE ElectionName = @ElectionName
		END
	COMMIT
END

EXECUTE updateElectionResultsDate @ElectionName = 'General Election', @ResultsDate = '20170807';
EXECUTE updateElectionResultsDate @ElectionName = 'Local Election', @ResultsDate = '20160807';
EXECUTE updateElectionResultsDate @ElectionName = 'Provincial Election', @ResultsDate = '20150807';
EXECUTE updateElectionResultsDate @ElectionName = 'Western Cape Provincial Election', @ResultsDate = '20140807';
EXECUTE updateElectionResultsDate @ElectionName = 'Northern Cape Provincial Election', @ResultsDate = '20110807';
EXECUTE updateElectionResultsDate @ElectionName = 'Mpumalanga Provincial Election', @ResultsDate = '20100807';
EXECUTE updateElectionResultsDate @ElectionName = 'Limpopo Provincial Election', @ResultsDate = '20090807';
EXECUTE updateElectionResultsDate @ElectionName = 'Eastern Cape Provincial Election', @ResultsDate = '20080807';
EXECUTE updateElectionResultsDate @ElectionName = 'Kwa Zulu Natal Provincial Election', @ResultsDate = '20000807';

SELECT * FROM Election WHERE ResultsDate BETWEEN '20160107' AND '20200107';

CREATE PROCEDURE [dbo].[insertElections]
@ElectionName varchar(120), 
@DateCreated date = NULL,
@DateConducted date = NULL,
@ResultsDate date = NULL,
@Status int = NULL,
@Winner int = NULL,
@Creator int = NULL
AS
BEGIN
		SET NOCOUNT ON;
		SET XACT_ABORT ON;
		BEGIN TRANSACTION
			BEGIN
				INSERT INTO Election (ElectionName, DateCreated, DateConducted, ResultsDate, [Status], Winner, Creator) VALUES (@ElectionName, @DateCreated, @DateConducted, @ResultsDate, @Status, @Winner, @Creator)
			END
		COMMIT
END;

DECLARE @date DATE
SET @date = CONVERT (date, GETDATE())
EXECUTE insertElections @ElectionName = 'General Election', @DateCreated =  @date;

DECLARE @date DATE
SET @date = CONVERT (date, GETDATE())
EXECUTE insertElections @ElectionName = 'Local Election', @DateCreated =  @date;

DECLARE @date DATE
SET @date = CONVERT (date, GETDATE())
EXECUTE insertElections @ElectionName = 'North West Provincial Election', @DateCreated =  @date;

DECLARE @date DATE
SET @date = CONVERT (date, GETDATE())
EXECUTE insertElections @ElectionName = 'Western Cape Provincial Election', @DateCreated =  @date;

DECLARE @date DATE
SET @date = CONVERT (date, GETDATE())
EXECUTE insertElections @ElectionName = 'Northern Cape Provincial Election', @DateCreated =  @date;

DECLARE @date DATE
SET @date = CONVERT (date, GETDATE())
EXECUTE insertElections @ElectionName = 'Free State Provincial Election', @DateCreated =  @date;

DECLARE @date DATE
SET @date = CONVERT (date, GETDATE())
EXECUTE insertElections @ElectionName = 'Mpumalanga Provincial Election', @DateCreated =  @date;

DECLARE @date DATE
SET @date = CONVERT (date, GETDATE())
EXECUTE insertElections @ElectionName = 'Limpopo Provincial Election', @DateCreated =  @date;

DECLARE @date DATE
SET @date = CONVERT (date, GETDATE())
EXECUTE insertElections @ElectionName = 'Eastern Cape Provincial Election', @DateCreated =  @date;

DECLARE @date DATE
SET @date = CONVERT (date, GETDATE())
EXECUTE insertElections @ElectionName = 'Kwa Zulu Natal Provincial Election', @DateCreated =  @date;

DECLARE @date DATE
SET @date = CONVERT (date, GETDATE())
EXECUTE insertElections @ElectionName = 'Gauteng Provincial Election', @DateCreated =  @date;

CREATE PROCEDURE [dbo].[deleteElection]
	@name varchar(120)
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	BEGIN TRANSACTION
				DELETE FROM [dbo].[Election] WHERE [Election].[ElectionName] = @name;
	COMMIT
END
GO

EXECUTE deleteElection @name = 'Gauteng Provincial Election';



CREATE PROCEDURE [dbo].[insertPoll]
@ElectionID int,
@VoterID int,
@HasVoted bit = NULL,
@PollingStationID int = NULL
AS
BEGIN
		SET NOCOUNT ON;
		SET XACT_ABORT ON;
		BEGIN TRANSACTION
			BEGIN
				INSERT INTO Poll (ElectionID, VoterID, HasVoted, PollingStationID) VALUES (@ElectionID, @VoterID, @HasVoted, @PollingStationID)
			END
		COMMIT
END;

EXECUTE insertPoll @ElectionID  = 1, @VoterID = 2, @HasVoted  = False, @PollingStationID  = NULL;

CREATE PROCEDURE dbo.viewPoll
AS
BEGIN
	SELECT * 
	FROM dbo.Poll
END;

EXECUTE viewPoll;


CREATE PROCEDURE [dbo].[insertVoter]
@CitizenID int = NULL
AS
BEGIN
		SET NOCOUNT ON;
		SET XACT_ABORT ON;
		BEGIN TRANSACTION
			BEGIN
				INSERT INTO Voter(CitizenID) VALUES (@CitizenID)
			END
		COMMIT
END;

EXECUTE insertVoter @CitizenID = 7;

CREATE PROCEDURE dbo.viewVoter
AS
BEGIN
	SELECT * 
	FROM dbo.Voter
END;

Execute viewVoter;
