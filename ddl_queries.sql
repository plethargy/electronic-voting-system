CREATE DATABASE  evsdb ;

CREATE TABLE    [Address]  (
   AddressID  INT NOT NULL IDENTITY(1,1),
   Street  VARCHAR(120) ,
   City  VARCHAR(120) ,
   Country  VARCHAR(120) ,
   PostalCode  VARCHAR(8) ,
  PRIMARY KEY ( AddressID ));
  
CREATE TABLE    Contact  (                                                                                       
   ContactID  INT NOT NULL IDENTITY(1,1),
   CellPhone  VARCHAR(120) ,
   Telephone  VARCHAR(120) ,
   Email  VARCHAR(120) ,
   Fax  VARCHAR(120) ,
  PRIMARY KEY ( ContactID ));
  
  CREATE TABLE    Party  (
   PartyID  INT NOT NULL,
   [Name]  VARCHAR(60) ,
  PRIMARY KEY ( PartyID ));
  
CREATE TABLE    Citizen  (
   CitizenID  INT NOT NULL IDENTITY(1,1),
   [Name]  VARCHAR(120) ,
   Surname  VARCHAR(120) ,
   IDNumber  INT ,
   AddressID  INT ,
   ContactID  INT  ,
   Ethnicity VARCHAR(40),
  PRIMARY KEY ( CitizenID ),
  FOREIGN KEY ( AddressID ) references   [Address] ( AddressID ),
  FOREIGN KEY ( ContactID ) references   Contact ( ContactID ));

CREATE TABLE [User]  (
   UserID  INT NOT NULL IDENTITY(1,1),
   CitizenID  INT ,
  PRIMARY KEY ( UserID ),
  FOREIGN KEY ( CitizenID ) references   Citizen ( CitizenID ));
  
  CREATE TABLE    [Status]  (
   StatusID  INT NOT NULL IDENTITY(1,1),
   [Description]  VARCHAR(120) ,
  PRIMARY KEY ( statusID ));
  
  CREATE TABLE    Voter  (
   VoterID  INT NOT NULL IDENTITY(1,1),
   CitizenID  INT ,
  PRIMARY KEY ( VoterID ),
  FOREIGN KEY ( CitizenID ) references   Citizen ( CitizenID ));
  
CREATE TABLE    Permission  (
   PermissionID  INT NOT NULL IDENTITY(1,1),
   [Description]  VARCHAR(120),
  PRIMARY KEY ( PermissionID ));

CREATE TABLE    ElectionUsers  (
   ElectionID  INT NOT NULL,
   UserID  INT NOT NULL,
   PermissionID  INT,
  PRIMARY KEY ( ElectionID ,  UserID ),
  FOREIGN KEY ( PermissionID ) references   Permission ( PermissionID ),
  FOREIGN KEY ( ElectionID ) references   Election ( ElectionID ),
  FOREIGN KEY ( UserID ) references   [User] ( UserID ));
  
CREATE TABLE    Candidate  (
   CandidateID  INT NOT NULL IDENTITY(1,1),
   CitizenID  INT ,
  PRIMARY KEY ( CandidateID ),
  FOREIGN KEY ( CitizenID ) references   Citizen ( CitizenID ));
  
CREATE TABLE    EVM  (
   EVM_ID  INT NOT NULL IDENTITY(1,1),
   PollingStationID  INT,
  PRIMARY KEY ( EVM_ID ),
  FOREIGN KEY ( PollingStationID ) references   PollingStation ( PollingStationID ));

CREATE TABLE    PollingStation  (
   PollingStationID  INT NOT NULL IDENTITY(1,1),
   [Name]  varchar(120) ,
   AddressID  INT ,
   ElectionID  INT ,
  PRIMARY KEY ( PollingStationID ),
  FOREIGN KEY ( AddressID ) references   [Address] ( AddressID ),
  FOREIGN KEY ( ElectionID ) references   Election ( ElectionID ));


CREATE TABLE    ManualCounter  (
   ManualCounterID  INT NOT NULL IDENTITY(1,1),
   PollingStationID  INT ,
   CitizenID  INT ,
  PRIMARY KEY ( ManualCounterID ),
  FOREIGN KEY ( PollingStationID ) references   PollingStation ( PollingStationID ),
  FOREIGN KEY ( CitizenID ) references   Citizen ( CitizenID ));
  
CREATE TABLE    ElectionCandidates  (
   ElectionID  INT NOT NULL,
   CandidateID  INT NOT NULL,
   PartyID  INT ,
  PRIMARY KEY ( ElectionID , CandidateID ),
  FOREIGN KEY ( PartyID ) references   Party ( PartyID ),
  FOREIGN KEY (ElectionID) REFERENCES Election (ElectionID),
  FOREIGN KEY (CandidateID) REFERENCES Candidate (CandidateID));

CREATE TABLE    ElectionCandidateManualVote  (
   ElectionID  INT NOT NULL,
   CandidateID  INT NOT NULL,
   ManualCounterID  INT NOT NULL,
   VoteCount  INT ,
  PRIMARY KEY ( ElectionID , CandidateID, ManualCounterID ),
  FOREIGN KEY (ElectionID) REFERENCES Election (ElectionID),
  FOREIGN KEY (CandidateID) REFERENCES Candidate (CandidateID),
  FOREIGN KEY (ManualCounterID) REFERENCES ManualCounter (ManualCounterID));

CREATE TABLE    ElectionCandidateOnlineVote  (
   ElectionID  INT NOT NULL,
   CandidateID  INT NOT NULL,
   OnlineID  INT NOT NULL,
   VoteCount  INT ,
  PRIMARY KEY ( ElectionID , CandidateID ,  OnlineID ),
  FOREIGN KEY (ElectionID) REFERENCES Election (ElectionID),
  FOREIGN KEY (CandidateID) REFERENCES Candidate (CandidateID),
   FOREIGN KEY (OnlineID) REFERENCES OnlineInterface (OnlineID));

  CREATE TABLE    ElectionCandidateEVMVote  (
   ElectionID  INT NOT NULL,
   CandidateID  INT NOT NULL,
   EVM_ID  INT NOT NULL,
   VoteCount  INT ,
  PRIMARY KEY ( ElectionID, CandidateID, EVM_ID ),
  FOREIGN KEY (ElectionID) REFERENCES Election (ElectionID),
  FOREIGN KEY (CandidateID) REFERENCES Candidate (CandidateID),
  FOREIGN KEY (EVM_ID) REFERENCES EVM (EVM_ID))
;
  
CREATE TABLE    Election  (
   ElectionID  INT NOT NULL IDENTITY(1,1),
   ElectionName  VARCHAR(120) ,
   DateCreated  date,
   DateConducted  date,
   ResultsDate  date,
   [Status]  INT ,
   Winner  INT ,
   Creator INT ,
  PRIMARY KEY ( ElectionID ),
  FOREIGN KEY ( [Status] ) references   [Status] ( StatusID ),
  FOREIGN KEY ( Creator ) references   [User] ( UserID ),
  FOREIGN KEY (Winner) REFERENCES Candidate (CandidateID));

 CREATE TABLE    Poll  (
   ElectionID  INT NOT NULL,
   VoterID  INT NOT NULL,
   HasVoted  bit ,
   PollingStationID  INT ,
  PRIMARY KEY ( ElectionID , VoterID ), 
  FOREIGN KEY ( PollingStationID ) references   PollingStation ( PollingStationID ),
  FOREIGN KEY (ElectionID) REFERENCES Election (ElectionID),
  FOREIGN KEY (VoterID) REFERENCES Voter (VoterID));

 CREATE TABLE OnlineInterface 
(
	[OnlineID] int NOT NULL PRIMARY KEY IDENTITY(1,1)
);