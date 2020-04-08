CREATE SCHEMA `vsdb`;

CREATE TABLE IF NOT EXISTS `VSDB`.`Address` (
  `AddressID` INT NOT NULL AUTO_INCREMENT,
  `Street` VARCHAR(120) NOT NULL,
  `City` VARCHAR(120) NOT NULL,
  `Country` VARCHAR(120) NOT NULL,
  `PostalCode` VARCHAR(8) NOT NULL,
  PRIMARY KEY (`AddressID`));
  
CREATE TABLE IF NOT EXISTS `VSDB`.`Contact` (                                                                                       
  `ContactID` INT NOT NULL AUTO_INCREMENT,
  `CellPhone` VARCHAR(120) NOT NULL,
  `Telephone` INT NULL,
  `Email` VARCHAR(120) NOT NULL,
  `Fax` VARCHAR(120) NOT NULL,
  PRIMARY KEY (`ContactID`));
  
  CREATE TABLE IF NOT EXISTS `VSDB`.`Party` (
  `PartyID` INT NOT NULL,
  `Name` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`PartyID`));
  
  CREATE TABLE IF NOT EXISTS `VSDB`.`Citizen` (
  `CitizenID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(120) NOT NULL,
  `Surname` VARCHAR(120) NULL,
  `IDNumber` INT NOT NULL,
  `AddressID` INT NULL,
  `ContactID` INT NULL ,
  PRIMARY KEY (`CitizenID`),
  FOREIGN KEY (`AddressID`) references `VSDB`.`Address`(`AddressID`),
  FOREIGN KEY (`ContactID`) references `VSDB`.`Contact`(`ContactID`));

CREATE TABLE IF NOT EXISTS `VSDB`.`User` (
  `UserID` INT NOT NULL AUTO_INCREMENT,
  `CitizenID` VARCHAR(120) NOT NULL,
  PRIMARY KEY (`UserID`));
  
  CREATE TABLE IF NOT EXISTS `VSDB`.`Status` (
  `StatusID` INT NOT NULL AUTO_INCREMENT,
  `Description` VARCHAR(120) NOT NULL,
  PRIMARY KEY (`statusID`));
  
  CREATE TABLE IF NOT EXISTS `VSDB`.`Voter` (
  `VoterID` INT NOT NULL AUTO_INCREMENT,
  `CitizenID` INT NOT NULL,
  PRIMARY KEY (`VoterID`),
  FOREIGN KEY (`CitizenID`) references `VSDB`.`Citizen`(`CitizenID`),
  UNIQUE INDEX `id_UNIQUE` (`VoterID` ASC));
  
CREATE TABLE IF NOT EXISTS `VSDB`.`Permisision` (
  `PermissionID` INT NOT NULL AUTO_INCREMENT,
  `Description` VARCHAR(120) NOT NULL,
  PRIMARY KEY (`PermissionID`));

CREATE TABLE IF NOT EXISTS `VSDB`.`ElectionUsers` (
  `ElectionID` INT NOT NULL AUTO_INCREMENT,
  `UserID` INT NOT NULL,
  `PermissionID` INT NOT NULL,
  PRIMARY KEY (`ElectionID`, `UserID`),
  FOREIGN KEY (`PermissionID`) references `VSDB`.`Permisision`(`PermissionID`));
  
CREATE TABLE IF NOT EXISTS `VSDB`.`Candidate` (
  `CandidateID` INT NOT NULL,
  `CitizenID` INT NOT NULL,
  PRIMARY KEY (`CandidateID`),
  FOREIGN KEY (`CitizenID`) references `VSDB`.`Citizen`(`CitizenID`));
  
CREATE TABLE IF NOT EXISTS `VSDB`.`EVM` (
  `EVM_ID` INT NOT NULL,
  `PollingStationID` INT NOT NULL,
  `AddressID` INT NOT NULL,
  PRIMARY KEY (`EVM_ID`),
  FOREIGN KEY (`PollingStationID`) references `VSDB`.`Citizen`(`CitizenID`),
  FOREIGN KEY (`AddressID`) references `VSDB`.`Address`(`AddressID`));

CREATE TABLE IF NOT EXISTS `VSDB`.`PollingStation` (
  `PollingStationID` INT NOT NULL,
  `Name` varchar(120) NOT NULL,
  `AddressID` INT NOT NULL,
  `ElectionID` INT NOT NULL,
  PRIMARY KEY (`PollingStationID`),
  FOREIGN KEY (`AddressID`) references `VSDB`.`Address`(`AddressID`));


CREATE TABLE IF NOT EXISTS `VSDB`.`ManualCounter` (
  `ManualCounterID` INT NOT NULL,
  `PollingStationID` INT NOT NULL,
  `CitizenID` INT NOT NULL,
  PRIMARY KEY (`ManualCounterID`),
  FOREIGN KEY (`PollingStationID`) references `VSDB`.`PollingStation`(`PollingStationID`),
  FOREIGN KEY (`CitizenID`) references `VSDB`.`Citizen`(`CitizenID`));
  
CREATE TABLE IF NOT EXISTS `VSDB`.`ElectionCandidates` (
  `ElectionID` INT NOT NULL,
  `CandidateID` INT NOT NULL,
  `PartyID` INT NOT NULL,
  PRIMARY KEY (`ElectionID`,`CandidateID`),
  FOREIGN KEY (`PartyID`) references `VSDB`.`Party`(`PartyID`));

CREATE TABLE IF NOT EXISTS `VSDB`.`ElectionCandidateManualVote` (
  `ElectionID` INT NOT NULL,
  `CandidateID` INT NOT NULL,
  `ManualCounterID` INT NOT NULL,
  `VoteCount` INT NOT NULL,
  PRIMARY KEY (`ElectionID`,`CandidateID`));

CREATE TABLE IF NOT EXISTS `VSDB`.`ElectionCandidateOnlineVote` (
  `ElectionID` INT NOT NULL,
  `CandidateID` INT NOT NULL,
  `OnlineID` INT NOT NULL,
  `VoteCount` INT NOT NULL,
  PRIMARY KEY (`ElectionID`,`CandidateID`, `OnlineID`));

  CREATE TABLE IF NOT EXISTS `VSDB`.`ElectionCandidateEVMVote` (
  `ElectionID` INT NOT NULL,
  `CandidateID` INT NOT NULL,
  `EVM_ID` INT NOT NULL,
  `VoteCount` INT NOT NULL,
  PRIMARY KEY (`ElectionID`));
  
CREATE TABLE IF NOT EXISTS `VSDB`.`Election` (
  `ElectionID` INT NOT NULL AUTO_INCREMENT,
  `ElectionName` VARCHAR(120) NOT NULL,
  `DateCreated` date NOT NULL,
  `DateConducted` date NOT NULL,
  `ResultsDate` date NOT NULL,
  `Status` INT NOT NULL,
  `Winner` INT NOT NULL,
  `Creator`INT NOT NULL,
  PRIMARY KEY (`ElectionID`),
  FOREIGN KEY (`Status`) references `VSDB`.`Status`(`StatusID`),
  FOREIGN KEY (`Creator`) references `VSDB`.`User`(`UserID`));

 CREATE TABLE IF NOT EXISTS `VSDB`.`Poll` (
  `ElectionID` INT NOT NULL,
  `VoterID` INT NOT NULL,
  `HasVoted` BOOLEAN NOT NULL,
  `PollingStationID` INT NOT NULL,
  PRIMARY KEY (`PollingStationID`,`VoterID`), 
  FOREIGN KEY (`PollingStationID`) references `VSDB`.`PollingStation`(`PollingStationID`),
  UNIQUE INDEX `id_UNIQUE` (`PollingStationID` ASC));



-- Add Constraint
ALTER TABLE `VSDB`.`PollingStation`
    ADD CONSTRAINT `fk_PollingStation` FOREIGN KEY (`ElectionID`) references `VSDB`.`Election`(`ElectionID`);





