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
	FROM vsdb.dbo.ElectionCandidateManualVote
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

CREATE FUNCTION getElectionCandidateList
(
@ElectionID int
)
RETURNS TABLE
AS
	RETURN SELECT CandidateID FROM vsdb.dbo.ElectionCandidates WHERE ElectionID = @ElectionID
GO

CREATE FUNCTION getElectionVotes
(
@ElectionID int
)
RETURNS int
AS
BEGIN

	DECLARE @VoteCount int
	SELECT @VoteCount = SUM(vsdb.dbo.getCandidateElectionVoteCount(CandidateID, @ElectionID)) FROM getElectionCandidateList(@ElectionID)
	RETURN @VoteCount
END

GO

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
	FROM vsdb.dbo.ElectionCandidateOnlineVote
	WHERE ElectionID = @ElectionID AND CandidateID = @CandidateID

	RETURN @OnlineVoteCount
END

GO


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
	FROM vsdb.dbo.ElectionCandidateManualVote
	WHERE ElectionID = @ElectionID AND CandidateID = @CandidateID

	RETURN @ManualVoteCount
END

GO

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
	FROM vsdb.dbo.ElectionCandidateEVMVote
	WHERE ElectionID = @ElectionID AND CandidateID = @CandidateID

	RETURN @EVMVoteCount
END

GO


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
	FROM vsdb.dbo.ElectionCandidateEVMVote e
	INNER JOIN vsdb.dbo.EVM evm
	ON e.EVM_ID = evm.EVM_ID
	INNER JOIN vsdb.dbo.POLINGSTATION ps
	ON evm.PolilngStationID = ps.PolilngStationID
	INNER JOIN vsdb.dbo.Address a
	ON ps.AddressID = a.AddressID
	WHERE e.ElectionID = @ElectionID AND e.CandidateID = @CandidateID
	GROUP BY a.AddressID

	RETURN @EVMVoteCount
END

GO