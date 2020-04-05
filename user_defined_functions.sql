CREATE FUNCTION getCandidateElectionVoteCount
(
@CandidateID int, 
@ElectionID int
)
RETURNS INT
AS
BEGIN

	DECLARE @ManualVoteCount int, @OnlineVoteCount int, @EVMVoteCount int

	SELECT @ManualVoteCount = SUM(VoteCount) 
	FROM ElectionCandidateManualVote
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
BEGIN
	RETURN SELECT CandidateID FROM ElectionCandidates WHERE ElectionID = @ElectionID
END

GO

CREATE FUNCTION getElectionVotes
(
@ElectionID int
)
RETURNS int
AS
BEGIN

	DECLARE @VoteCount int
	SELECT @VoteCount = SUM(getCandidateElectionVoteCount(CandidateID)) FROM getElectionCandidateList(@ElectionID)
	RETURN
END

GO



