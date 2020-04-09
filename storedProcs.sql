USE [evsdb]
GO

/****** Object:  StoredProcedure [dbo].[insertCandidate]    Script Date: 2020/04/08 13:19:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[insertCandidate]
	@CitizenID int
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	BEGIN TRANSACTION
		IF (SELECT COUNT(1) FROM [dbo].[Citizen] WHERE [dbo].[Citizen].[CitizenID] = @CitizenID) = 1 
		BEGIN
			INSERT INTO [dbo].[Candidate] (CitizenID) VALUES (@CitizenID);
		END
	COMMIT
END
GO


CREATE PROCEDURE [dbo].[deleteCandidate]
	@CandidateID int
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	BEGIN TRANSACTION
		IF (SELECT COUNT(1) FROM [dbo].[Candidate] WHERE [dbo].[Candidate].[CandidateID] = @CandidateID) = 1 
		BEGIN
			DELETE FROM [dbo].[Candidate] WHERE CandidateID = @CandidateID;
		END
	COMMIT
END
GO

CREATE PROCEDURE [dbo].[updateCandidate]
	@CandidateID int,
	@CitizenID int
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	BEGIN TRANSACTION
		IF (SELECT COUNT(1) FROM [dbo].[Candidate] WHERE [dbo].[Candidate].CandidateID = @CandidateID) = 1
		BEGIN
			IF (SELECT COUNT(1) FROM [dbo].[Citizen] WHERE [dbo].[Citizen].[CitizenID] = @CitizenID) = 1
			BEGIN
				UPDATE [dbo].[Candidate] SET CitizenID = @CitizenID WHERE CandidateID = @CandidateID;
			END
		END
		COMMIT
END
GO


CREATE PROCEDURE [dbo].[insertElectionCandidate]
	@ElectionID int,
	@CandidateID int,
	@PartyID int = NULL
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	BEGIN TRANSACTION
		BEGIN
			INSERT INTO ElectionCandidates (ElectionID, CandidateID, PartyID) VALUES (@ElectionID, @CandidateID, @PartyID);
		END
		COMMIT
END
GO

CREATE PROCEDURE [dbo].[deleteElectionCandidate]
	@ElectionID int,
	@CandidateID int
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	BEGIN TRANSACTION
		IF (SELECT COUNT(1) FROM ElectionCandidates WHERE ElectionID = @ElectionID AND CandidateID = @CandidateID) = 1
		BEGIN
			DELETE FROM ElectionCandidates WHERE ElectionID = @ElectionID AND CandidateID = @CandidateID;
		END
		COMMIT
END
GO


CREATE PROCEDURE [dbo].[insertElectionCandidateManualVote]
	@ElectionID int,
	@CandidateID int,
	@ManualCounterID int
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	BEGIN TRANSACTION
		BEGIN
			INSERT INTO ElectionCandidateManualVote (ElectionID, CandidateID, ManualCounterID, VoteCount) VALUES (@ElectionID, @CandidateID, @ManualCounterID, 0);
		END
		COMMIT
END
GO

CREATE PROCEDURE [dbo].[updateElectionCandidateManualVote]
	@ElectionID int,
	@CandidateID int,
	@ManualCounterID int,
	@voteCount int 
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	BEGIN TRANSACTION
		IF (SELECT COUNT(1) FROM ElectionCandidateManualVote WHERE ElectionID = @ElectionID AND CandidateID = @CandidateID AND ManualCounterID = @ManualCounterID) = 1
		BEGIN
			UPDATE ElectionCandidateManualVote SET VoteCount = VoteCount + @voteCount;
		END
		COMMIT
END
GO


CREATE PROCEDURE [dbo].[insertElectionCandidateEVMVote]
	@ElectionID int,
	@CandidateID int,
	@EVM_ID int
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	BEGIN TRANSACTION
		BEGIN
			INSERT INTO ElectionCandidateEVMVote (ElectionID, CandidateID, EVM_ID, VoteCount) VALUES (@ElectionID, @CandidateID, @EVM_ID, 0);
		END
		COMMIT
END
GO

CREATE PROCEDURE [dbo].[updateElectionCandidateEVMVote]
	@ElectionID int,
	@CandidateID int,
	@EVM_ID int,
	@voteCount int 
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	BEGIN TRANSACTION
		IF (SELECT COUNT(1) FROM ElectionCandidateEVMVote WHERE ElectionID = @ElectionID AND CandidateID = @CandidateID AND EVM_ID = @EVM_ID) = 1
		BEGIN
			UPDATE ElectionCandidateEVMVote SET VoteCount = VoteCount + @voteCount;
		END
		COMMIT
END
GO


CREATE PROCEDURE [dbo].[insertElectionCandidateOnlineVote]
	@ElectionID int,
	@CandidateID int,
	@OnlineID int
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	BEGIN TRANSACTION
		BEGIN
			INSERT INTO ElectionCandidateOnlineVote (ElectionID, CandidateID, OnlineID, VoteCount) VALUES (@ElectionID, @CandidateID, @OnlineID, 0);
		END
		COMMIT
END
GO


CREATE PROCEDURE [dbo].[updateElectionCandidateOnlineVote]
	@ElectionID int,
	@CandidateID int,
	@OnlineID int,
	@voteCount int 
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	BEGIN TRANSACTION
		IF (SELECT COUNT(1) FROM ElectionCandidateOnlineVote WHERE ElectionID = @ElectionID AND CandidateID = @CandidateID AND OnlineID = @OnlineID) = 1
		BEGIN
			UPDATE ElectionCandidateOnlineVote SET VoteCount = VoteCount + @voteCount;
		END
		COMMIT
END
GO

CREATE PROCEDURE [dbo].[insertEVM]
	@PollingStationID int
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	BEGIN TRANSACTION
		INSERT INTO [dbo].[EVM] (PollingStationID) VALUES (@PollingStationID)
		COMMIT
END
GO

CREATE PROCEDURE [dbo].[deleteEVM]
	@EVM_ID int
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	BEGIN TRANSACTION
		IF (SELECT COUNT(1) FROM EVM WHERE EVM_ID = @EVM_ID) = 1
		BEGIN
			DELETE FROM [dbo].[EVM] WHERE EVM_ID = @EVM_ID;
		END
		COMMIT
END
GO

CREATE PROCEDURE [dbo].[insertParty]
	@Name varchar(60) 
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	BEGIN TRANSACTION
		INSERT INTO [dbo].[Party] ([Name]) VALUES (@Name)
		COMMIT
END
GO

CREATE PROCEDURE [dbo].[updateParty]
	@partyID int,
	@Name varchar(60) 
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	BEGIN TRANSACTION
		IF (SELECT COUNT(1) FROM [dbo].[Party] WHERE PartyID = @partyID) = 1
		BEGIN
		UPDATE Party SET [Name] = @Name WHERE PartyID = @partyID
		END
		COMMIT

END
GO

CREATE PROCEDURE [dbo].[insertPollingStation]
	@Name varchar(120),
	@addressID int = null,
	@electionID int = null
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	BEGIN TRANSACTION
		INSERT INTO [dbo].[PollingStation] ([Name], [AddressID], [ElectionID]) VALUES (@Name, @addressID, @electionID)
		COMMIT
END
GO

CREATE PROCEDURE [dbo].[insertManualCounter]
	@pollingStationID int,
	@citizenID int
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	BEGIN TRANSACTION
		INSERT INTO [dbo].[ManualCounter] ([PollingStationID], [CitizenID]) VALUES (@pollingStationID, @citizenID)
		COMMIT
END
GO



