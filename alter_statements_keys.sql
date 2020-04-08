ALTER TABLE vsdb.dbo.Election
ADD CONSTRAINT FK_Winner_Candidate FOREIGN KEY (Winner)
REFERENCES vsdb.dbo.Candidate (CandidateID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;

--------------------------

ALTER TABLE vsdb.dbo.Poll
ADD CONSTRAINT PK_Poll_Election PRIMARY KEY (ElectionID, VoterID)
;

ALTER TABLE vsdb.dbo.Poll
ADD CONSTRAINT FK_Poll_Election FOREIGN KEY (ElectionID)
REFERENCES vsdb.dbo.Election (ElectionID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;

ALTER TABLE vsdb.dbo.Poll
ADD CONSTRAINT FK_Poll_Voter FOREIGN KEY (VoterID)
REFERENCES vsdb.dbo.Voter (VoterID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;

ALTER TABLE vsdb.dbo.Poll
ADD CONSTRAINT FK_Poll_PollingStation FOREIGN KEY (PollingStationID)
REFERENCES vsdb.dbo.PollingStation (PollingStationID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;



--------------------------
ALTER TABLE vsdb.dbo.ElectionCandidates
ADD CONSTRAINT FK_ElectionCandidates_Election FOREIGN KEY (ElectionID)
REFERENCES vsdb.dbo.Election (ElectionID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;


ALTER TABLE vsdb.dbo.ElectionCandidates
ADD CONSTRAINT FK_ElectionCandidates_Candidate FOREIGN KEY (CandidateID)
REFERENCES vsdb.dbo.Candidate (CandidateID)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
;

-----------------------------------------------
ALTER TABLE vsdb.dbo.ElectionCandidateManualVote
ADD CONSTRAINT FK_ElectionCandidateManualVote_Election FOREIGN KEY (ElectionID)
REFERENCES vsdb.dbo.Election (ElectionID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;


ALTER TABLE vsdb.dbo.ElectionCandidateManualVote
ADD CONSTRAINT FK_ElectionCandidateManualVote_Candidate FOREIGN KEY (CandidateID)
REFERENCES vsdb.dbo.Candidate (CandidateID)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
;

ALTER TABLE vsdb.dbo.ElectionCandidateManualVote
ADD CONSTRAINT FK_ElectionCandidateManualVote_ManualCounter FOREIGN KEY (ManualCounterID)
REFERENCES vsdb.dbo.ManualCounter (ManualCounterID)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
;

ALTER TABLE vsdb.dbo.ElectionCandidateManualVote
ADD CONSTRAINT PK_ElectionCandidateManualVote PRIMARY KEY (ElectionID, CandidateID, ManualCounterID)
;

---------------------------------------
CREATE TABLE vsdb.dbo.OnlineInterface 
(
[OnlineID] int PRIMARY KEY
);
GO

ALTER TABLE vsdb.dbo.ElectionCandidateOnlineVote
ADD CONSTRAINT FK_ElectionCandidateOnlineVote_Election FOREIGN KEY (ElectionID)
REFERENCES vsdb.dbo.Election (ElectionID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;


ALTER TABLE vsdb.dbo.ElectionCandidateOnlineVote
ADD CONSTRAINT FK_ElectionCandidateOnlineVote_Candidate FOREIGN KEY (CandidateID)
REFERENCES vsdb.dbo.Candidate (CandidateID)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
;

ALTER TABLE vsdb.dbo.ElectionCandidateOnlineVote
ADD CONSTRAINT FK_ElectionCandidateOnlineVote_OnlineInterface FOREIGN KEY (OnlineID)
REFERENCES vsdb.dbo.OnlineInterface (OnlineID)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
;


-------------------------------------
ALTER TABLE vsdb.dbo.ElectionCandidateEVMVote
ADD CONSTRAINT FK_ElectionCandidateEVMVote_Election FOREIGN KEY (ElectionID)
REFERENCES vsdb.dbo.Election (ElectionID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;


ALTER TABLE vsdb.dbo.ElectionCandidateEVMVote
ADD CONSTRAINT FK_ElectionCandidateEVMVote_Candidate FOREIGN KEY (CandidateID)
REFERENCES vsdb.dbo.Candidate (CandidateID)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
;

ALTER TABLE vsdb.dbo.ElectionCandidateEVMVote
ADD CONSTRAINT FK_ElectionCandidateEVMVote_EVM FOREIGN KEY (EVM_ID)
REFERENCES vsdb.dbo.EVM (EVM_ID)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
;

ALTER TABLE vsdb.dbo.ElectionCandidateEVMVote
ADD CONSTRAINT PK_ElectionCandidateEVMVote PRIMARY KEY (ElectionID, CandidateID, EVM_ID)
;

-------------------------------
ALTER TABLE vsdb.dbo.PollingStation
ADD AddressID int;

ALTER TABLE vsdb.dbo.PollingStation
ADD CONSTRAINT FK_PollingStation_Address FOREIGN KEY (AddressID)
REFERENCES vsdb.dbo.Address (AddressID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;

------------------