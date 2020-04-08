CREATE FUNCTION dbo.getCandidateElectionVoteCount
(
@CandidateID int, 
@ElectionID int
)
RETURNS INT
AS
BEGIN

	DECLARE @ManualVoteCount int, @OnlineVoteCount int, @EVMVoteCount int

	SELECT @ManualVoteCount = SUM(VoteCount) 
	FROM evsdb.dbo.ElectionCandidateManualVote
	WHERE ElectionID = @ElectionID AND CandidateID = @CandidateID

	SELECT @OnlineVoteCount = SUM(VoteCount) 
	FROM ElectionCandidateOnlineVote
	WHERE ElectionID = @ElectionID AND CandidateID = @CandidateID

	SELECT @EVMVoteCount = SUM(VoteCount) 
	FROM ElectionCandidateEVMVote
	WHERE ElectionID = @ElectionID AND CandidateID = @CandidateID

	RETURN @ManualVoteCount + @OnlineVoteCount + @EVMVoteCount

END

GO

DECLARE @totalVotes int;
EXEC @totalVotes = dbo.getCandidateElectionVoteCount @CandidateID = 1, @ElectionID = 1;
SELECT @totalVotes; 



CREATE FUNCTION getElectionCandidateList
(
@ElectionID int
)
RETURNS TABLE
AS
	RETURN SELECT CandidateID FROM evsdb.dbo.ElectionCandidates WHERE ElectionID = @ElectionID
GO

CREATE FUNCTION getElectionVotes
(
@ElectionID int
)
RETURNS int
AS
BEGIN

	DECLARE @VoteCount int
	SELECT @VoteCount = SUM(evsdb.dbo.getCandidateElectionVoteCount(CandidateID, @ElectionID)) FROM getElectionCandidateList(@ElectionID)
	RETURN @VoteCount
END

GO

DECLARE @totalVotes int;
EXEC @totalVotes = dbo.getElectionVotes @ElectionID = 1;
SELECT @totalVotes; 

DECLARE @candList table;
EXEC @candList = dbo.getElectionCandidateList @ElectionID = 1;
SELECT @candList;

CREATE FUNCTION getOnlineVoteCount
(
@CandidateID int, 
@ElectionID int
)
RETURNS INT 
AS 
BEGIN

	DECLARE @OnlineVoteCount int

	SELECT @OnlineVoteCount = SUM(VoteCount) 
	FROM evsdb.dbo.ElectionCandidateOnlineVote
	WHERE ElectionID = @ElectionID AND CandidateID = @CandidateID

	RETURN @OnlineVoteCount
END

GO

DECLARE @totalVotes int;
EXEC @totalVotes = dbo.getOnlineVoteCount @CandidateID = 1, @ElectionID = 1;
SELECT @totalVotes; 

CREATE FUNCTION getManualVoteCount
(
@CandidateID int, 
@ElectionID int
)
RETURNS INT 
AS 
BEGIN

	DECLARE @ManualVoteCount int

	SELECT @ManualVoteCount = SUM(VoteCount) 
	FROM evsdb.dbo.ElectionCandidateManualVote
	WHERE ElectionID = @ElectionID AND CandidateID = @CandidateID

	RETURN @ManualVoteCount
END

GO

DECLARE @totalVotes int;
EXEC @totalVotes = dbo.getManualVoteCount @CandidateID = 1, @ElectionID = 1;
SELECT @totalVotes; 

CREATE FUNCTION getEVMVoteCount
(
@CandidateID int, 
@ElectionID int
)
RETURNS INT 
AS 
BEGIN

	DECLARE @EVMVoteCount int

	SELECT @EVMVoteCount = SUM(VoteCount) 
	FROM evsdb.dbo.ElectionCandidateEVMVote
	WHERE ElectionID = @ElectionID AND CandidateID = @CandidateID

	RETURN @EVMVoteCount
END

GO

DECLARE @totalVotes int;
EXEC @totalVotes = dbo.getEVMVoteCount @CandidateID = 1, @ElectionID = 1;
SELECT @totalVotes; 

CREATE FUNCTION getEVMVoteCountByPolingStationAddress
(
@CandidateID int, 
@ElectionID int
)
RETURNS INT 
AS 
BEGIN

	DECLARE @EVMVoteCount int

	SELECT a.street, a.city, a.country, @EVMVoteCount = SUM(VoteCount) EVM_COUNT
	FROM evsdb.dbo.ElectionCandidateEVMVote e
	INNER JOIN evsdb.dbo.EVM evm
	ON e.EVM_ID = evm.EVM_ID
	INNER JOIN evsdb.dbo.POLINGSTATION ps
	ON evm.PolilngStationID = ps.PolilngStationID
	INNER JOIN evsdb.dbo.Address a
	ON ps.AddressID = a.AddressID
	WHERE e.ElectionID = @ElectionID AND e.CandidateID = @CandidateID
	GROUP BY a.AddressID

	RETURN @EVMVoteCount
END

GO