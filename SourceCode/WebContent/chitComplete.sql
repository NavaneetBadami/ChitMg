/*
SQLyog - Free MySQL GUI v5.02
Host - 5.0.19-nt : Database - chitfund
*********************************************************************
Server version : 5.0.19-nt
*/


create database if not exists `chitfund`;

USE `chitfund`;

/*Table structure for table `admin_details` */

DROP TABLE IF EXISTS `admin_details`;

CREATE TABLE `admin_details` (
  `ID` int(10) NOT NULL auto_increment,
  `AdmId` varchar(35) NOT NULL,
  `AdmFirstName` varchar(45) default NULL,
  `AdmLastName` varchar(45) default NULL,
  `AdmGender` varchar(6) default NULL,
  `AdmPassword` varchar(45) default NULL,
  `AdmContactNo` decimal(10,0) NOT NULL,
  `AdmEmailId` varchar(62) NOT NULL,
  `AdmAddress` varchar(200) default NULL,
  `AdmCity` varchar(50) default NULL,
  `AdmState` varchar(50) default NULL,
  `AdmPINCode` int(6) default NULL,
  PRIMARY KEY  (`ID`,`AdmId`,`AdmContactNo`,`AdmEmailId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `agent_details` */

DROP TABLE IF EXISTS `agent_details`;

CREATE TABLE `agent_details` (
  `ID` int(10) NOT NULL auto_increment,
  `AgtFirstName` varchar(45) default NULL,
  `AgtLastName` varchar(45) default NULL,
  `AgtID` varchar(50) NOT NULL,
  `AgtPassword` varchar(45) default NULL,
  `AgtEmail` varchar(65) NOT NULL,
  `AgtDOB` date default NULL,
  `AgtAddress` varchar(200) default NULL,
  `AgtState` varchar(25) default NULL,
  `AgtCity` varchar(25) default NULL,
  `AgtPINCode` int(6) default NULL,
  `AgtContactno` decimal(10,0) NOT NULL,
  `AgtGender` varchar(6) default NULL,
  `AgtNomineeName` varchar(60) default NULL,
  `AgtRelationship` varchar(50) default NULL,
  `AgtNomContactno` decimal(12,0) default NULL,
  `AgtPhoto` mediumblob,
  `AgtNomAdderss` varchar(200) default NULL,
  `AgtNomState` varchar(25) default NULL,
  `AgtNomCity` varchar(25) default NULL,
  `AgtNomPINCode` int(6) default NULL,
  `AgtNomEmail` varchar(65) default NULL,
  `AgtPanPhoto` mediumblob,
  `AgtIdProof` mediumblob,
  `AgtPANno` varchar(10) default NULL,
  `AgtChitPlan` int(10) default NULL,
  `AgtChitAvailable` int(10) default NULL,
  `AgtSchemeId` varchar(20) default NULL,
  `AgtModeOfPayment` varchar(10) default NULL,
  `AgtValidity` date default NULL,
  `AgtAccCreDate` date default NULL,
  `AgtAccCreTime` time default NULL,
  `AgtCreSys_IP` varchar(20) default NULL,
  PRIMARY KEY  (`ID`,`AgtID`,`AgtEmail`,`AgtContactno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `auction_details` */

DROP TABLE IF EXISTS `auction_details`;

CREATE TABLE `auction_details` (
  `id` int(10) NOT NULL auto_increment,
  `auctionId` varchar(35) NOT NULL,
  `memGrpId` varchar(35) NOT NULL,
  `memAgtId` varchar(35) default NULL,
  `memGrpName` varchar(35) default NULL,
  `chitAmt` decimal(10,0) default NULL,
  `totalmembers` int(10) default NULL,
  `memName` varchar(35) default NULL,
  `memId` varchar(35) NOT NULL,
  `memBidPer` decimal(10,0) default NULL,
  `bidAmt` decimal(35,0) default NULL,
  `bidMemAmt` decimal(10,0) default NULL,
  `agentPer` decimal(10,0) default NULL,
  `agentAmt` decimal(10,0) default NULL,
  `remaningAmt` decimal(10,0) default NULL,
  `monthlypremium` decimal(10,0) default NULL,
  `premiumReduced` decimal(10,0) default NULL,
  `premiumPaid` decimal(10,0) default NULL,
  `bidDate` date default NULL,
  `bidTime` time default NULL,
  `sys_IPAddress` varchar(20) default NULL,
  PRIMARY KEY  (`id`,`auctionId`,`memId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `contact` */

DROP TABLE IF EXISTS `contact`;

CREATE TABLE `contact` (
  `id` int(10) NOT NULL auto_increment,
  `name` varchar(50) default NULL,
  `email` varchar(50) default NULL,
  `contact` decimal(12,0) default NULL,
  `city` varchar(35) default NULL,
  `message` varchar(100) default NULL,
  `contactedDate` date default NULL,
  `contactedTime` time default NULL,
  `contactedIP_add` varchar(20) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `group_details` */

DROP TABLE IF EXISTS `group_details`;

CREATE TABLE `group_details` (
  `id` int(10) NOT NULL auto_increment,
  `agentid` varchar(35) default NULL,
  `groupid` varchar(15) NOT NULL,
  `groupname` varchar(15) default NULL,
  `agentname` varchar(50) default NULL,
  `agentComPer` decimal(10,0) default NULL,
  `chitamount` decimal(10,0) default NULL,
  `duration` int(10) default NULL,
  `totalAuctions` int(10) default NULL,
  `remainingAuctions` int(10) default NULL,
  `AvailablememberSlots` int(10) default NULL,
  `TotalmemberSlots` int(10) default NULL,
  `premium` decimal(10,0) default NULL,
  `grpcredate` date default NULL,
  `grpcretime` time default NULL,
  `grpStatus` varchar(10) default NULL,
  `grpsys_ip` varchar(10) default NULL,
  PRIMARY KEY  (`id`,`groupid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `members_details` */

DROP TABLE IF EXISTS `members_details`;

CREATE TABLE `members_details` (
  `id` int(10) NOT NULL auto_increment,
  `groupid` varchar(15) default NULL,
  `agentId` varchar(35) default NULL,
  `membfirstname` varchar(35) default NULL,
  `memblastname` varchar(35) default NULL,
  `membId` varchar(20) NOT NULL,
  `membidden` varchar(10) default NULL,
  `membpassword` varchar(50) default NULL,
  `membgender` varchar(7) default NULL,
  `membcontactno` decimal(12,0) NOT NULL,
  `membaddress` varchar(200) default NULL,
  `membpincode` int(6) default NULL,
  `membphoto` mediumblob,
  `membnomname` varchar(35) default NULL,
  `membnomrelation` varchar(15) default NULL,
  `membnomaddress` varchar(200) default NULL,
  `membnompincode` int(6) default NULL,
  `membnomcontactno` decimal(12,0) default NULL,
  `membsuretytype` varchar(30) default NULL,
  `membsuretyphoto` mediumblob,
  `membcredate` date default NULL,
  `membcretime` time default NULL,
  `membIP_addreess` varchar(25) default NULL,
  PRIMARY KEY  (`id`,`membId`,`membcontactno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `scheme_type` */

DROP TABLE IF EXISTS `scheme_type`;

CREATE TABLE `scheme_type` (
  `id` int(10) NOT NULL auto_increment,
  `admid` varchar(15) default NULL,
  `admfname` varchar(30) default NULL,
  `schmemeid` varchar(15) NOT NULL,
  `schemetype` int(10) default NULL,
  `amount` decimal(20,0) default NULL,
  `validity` decimal(20,0) default NULL,
  `schemeStatus` varchar(7) default NULL,
  `schCredate` date default NULL,
  `schCreTime` time default NULL,
  `schCre_SysIp` varchar(20) default NULL,
  PRIMARY KEY  (`id`,`schmemeid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
