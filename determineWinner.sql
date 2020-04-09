
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[determineWinner]
	@ElectionID int
AS
BEGIN TRY

	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	BEGIN TRANSACTION
	DECLARE @winnerID int;
	 SELECT @winnerID = e.CandidateID FROM (SELECT TOP 1 dbo.getCandidateElectionVoteCount(ec.CandidateID, ec.ElectionID) as Votes, ec.CandidateID as CandidateID FROM dbo.ElectionCandidates as ec WHERE ElectionID = @ElectionID ORDER BY Votes DESC) AS e
	 IF (@winnerID IS NOT NULL)
	 BEGIN
		UPDATE Election SET Winner = @winnerID WHERE ElectionID = @ElectionID
	 END
	 COMMIT

END TRY
BEGIN CATCH
	ROLLBACK
END CATCH
GO
