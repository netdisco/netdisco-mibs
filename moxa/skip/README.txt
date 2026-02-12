0. Introduction
===============

	This document describes the group of the MIB package about

	1. The structure of the MOXA MIB group package
	2. Standard MIBs Installation Order
	3. How to import MIBs by function
	4. MIB tree

1. The structure of the MOXA MIB group package
==============================================

	Moxa support standard MIB and properties MIB. Below are all of folder and related MIB files.

	<Package File Lists> 

	EX. MOXA_MIB_XXX-XXXX_v1.0_YYYY_MMDD_HHMM.zip //XXX-XXXX means model name

		├──	Private 	// MOXA properties MIB
		│		│
		│		├── General 	// General group
		│		│   ├── mx1588.mib
		│		│   ├── mxDeviceIo.mib
		│		│   ├── mxDhcpRelay.mib
		│		│   ├── mxDhcpSvr.mib
		│		│   ├── mxEip.mib
		│		│   ├── mxEmailC.mib
		│		│   ├── mxEventLog.mib
		│		│   ├── mxGene.mib
		│		│   ├── mxGeneral.mib
		│		│   ├── mxIec6185093Profile.mib
		│		│   ├── mxIeeeC37238Profile.mib
		│		│   ├── mxLocator.mib
		│		│   ├── mxManagementIp.mib
		│		│   ├── mxMms.mib
		│		│   ├── mxModbusTcp.mib
		│		│   ├── mxPoee.mib
		│		│   ├── mxPorte.mib
		│		│   ├── mxProfinet.mib
		│		│   ├── mxPtp.mib
		│		│   ├── mxRelayC.mib
		│		│   ├── mxSnmp.mib
		│		│   ├── mxSwe.mib
		│		│   ├── mxSysLoginPolicySvr.mib
		│		│   ├── mxSyslogSvr.mib
		│		│   ├── mxSysPasswordPolicySvr.mib
		│		│   ├── mxSystemInfo.mib
		│		│   ├── mxSysTrustAccessSvr.mib
		│		│   ├── mxSysUtilSvr.mib
		│		│   ├── mxTimeSetting.mib
		│		│   ├── mxTimeZone.mib
		│		│   ├── mxTrapC.mib
		│		│   └── mxUiServiceMgmt.mib
		│		├── PoE 	// PoE group
		│		│   ├── mxPoe.mib
		│		│   └── mxPoeBt.mib
		│		├── Product_Information		// Product group
		│		│   ├── mxGeneralInfo.mib
		│		│   └── mxProductInfo.mib
		│		├── Switching	// Switching group
		|		|	├── mxDai.mib
		|		|	├── mxDhcpSnp.mib
		│		│	├── mxDot1x.mib
		│		│	├── mxDualHoming.mib
		│		│	├── mxFiberCheck.mib
		│		│	├── mxIgmpSnp.mib
		│		│	├── mxIpsg.mib
		│		│	├── mxLa.mib
		│		│	├── mxLhc.mib
		│		│	├── mxLldp.mib
		│		│	├── mxLp.mib
		│		│	├── mxMab.mib
		│		│	├── mxMacsec.mib
		│		│	├── mxPort.mib
		│		│	├── mxPortMirror.mib
		│		│	├── mxPsms.mib
		│		│	├── mxPssp.mib
		│		│	├── mxQos.mib
		│		│	├── mxRadius.mib
		│		│	├── mxRlps.mib
		│		│	├── mxRmon.mib
		│		│	├── mxRstp.mib
		│		│	├── mxStcl.mib
		│		│	├── mxSwitching.mib
		│		│	├── mxTc.mib
		│		│	├── mxTcst.mib
		│		│	├── mxTrv2.mib
		│		│	└── mxVlan.mib
		│		├── Routing	// Routing group
		│		    ├── mxArp.mib
		│		    ├── mxIpIf.mib
		│		    ├── mxOspf.mib
		│		    ├── mxRte.mib
		│		    ├── mxStaticRoute.mib
		│		    ├── mxUnicastRoutingTable.mib
		│		    └── mxVrrp.mib
		│
		├── Standard 	// Standard MIB
		│   ├── BRIDGE-MIB.mib
		│   ├── EtherLike-MIB.mib
		│   ├── IANA-ADDRESS-FAMILY-NUMBERS.mib
		│   ├── IANAifType-MIB.mib
		│   ├── IEC-62439-2.mib
		│   ├── IEEE8021-PAE-MIB.mib
		│   ├── IEEE8021-SPANNING-TREE-MIB.mib
		│   ├── IEEE8021-TC-MIB.mib
		│   ├── IEEE8023-LAG-MIB.mib
		│   ├── IEEE8023-MSTP-MIB.mib
		│   ├── IF-MIB.mib
		│   ├── INET-ADDRESS-MIB.mib
		│   ├── LLDP-EXT-DOT1-MIB.mib
		│   ├── LLDP-EXT-DOT3-MIB.mib
		│   ├── LLDP-EXT-ODVA-MIB.mib
		│   ├── LLDP-MIB.mib
		│   ├── P-BRIDGE-MIB.mib
		│   ├── Q-BRIDGE-MIB.mib
		│   ├── RFC1213-MIB.mib
		│   ├── RFC1271-MIB.mib
		│   ├── RMON2-MIB.mib
		│   ├── RMON-MIB.mib
		│   ├── SNMP-FRAMEWORK-MIB.mib
		│   ├── SNMPv2-CONF.mib
		│   ├── SNMPv2-MIB.mib
		│   ├── SNMPv2-SMI.mib
		│   ├── SNMPv2-TC.mib
		│   ├── OSPF-MIB.mib
		│   ├── PTPBASE-MIB.mib
		│   └── TOKEN-RING-RMON-MIB.mib
		│   └── IEEE8021-AS-MIB.mib
		│   └── IEEE8021-BRIDGE-MIB.mib
		│   └── IEEE8021-Q-BRIDGE-MIB.mib
		│   └── IEEE8021-ST-MIB.mib
		├── README.txt  	// this file

2. Standard MIBs Installation Order
===================================
If your tool need to import MIB one-by-one, please refer to the Standard MIBs Installation Order. 

  1.RFC1213-MIB.mib
  2.SNMP-FRAMEWORK-MIB.mib
  3.SNMPv2-SMI.mib
  4.SNMPv2-TC.mib
  5.SNMPv2-CONF.mib
  6.SNMPv2-MIB.mib
  7.IANAifType-MIB.mib
  8.IEEE8023-LAG-MIB.mib
  9.IF-MIB.mib
  10.EtherLike-MIB.mib
  11.IEEE8021-PAE-MIB.mib
  12.BRIDGE-MIB.mib
  13.P-BRIDGE-MIB.mib
  14.RFC1271-MIB.mib
  15.RMON-MIB.mib
  16.TOKEN-RING-RMON-MIB.mib
  17.RMON2-MIB.mib
  18.Q-BRIDGE-MIB.mib
  19.INET-ADDRESS-MIB.mib
  20.IEEE8021-TC-MIB.mib
  21.IEEE8021-SPANNING-TREE-MIB.mib
  22.IEEE8021-MSTP-MIB.mib
  23.IANA-ADDRESS-FAMILY-NUMBERS-MIB.mib
  24.LLDP-MIB.mib
  25.LLDP-EXT-DOT1-MIB.mib
  26.LLDP-EXT-DOT3-MIB.mib
  27.LLDP-EXT-ODVA-MIB.mib
  28.OSPF-MIB.mib
  29.PTPBASE-MIB.mib
  30.IEEE8021-AS-MIB.mib
  31.IEEE8021-BRIDGE-MIB.mib
  32.IEEE8021-ST-MIB.mib
  33.IEEE8021-Q-BRIDGE-MIB.mib

3. How to import MIBs by function
======================================

	If you want to install all MIBs, below are the steps
		- step 1: Based on "Standard MIBs Installation Order" to install all standard MIBs
		- step 2: To install Private\General\mxGeneral.mib and Private\Switching\mxSwitching.mib
		- step 3: To install other MOXA private MIBs
 	
	---------------------------------------------------------------------------------
	If you want to quickly find the feature's MIBs, you can refer tree as below.

	Feature Lists				:[FEATURE]
		├── Device Summary		:[LOCATOR],[PRODUCT INFORMAITON]
		├── System Feature
		│   ├── System Management	:[INFORMAITON SETTING],[MMS]
		│   ├── Account Management	:[PASSWORD POLICY]
		│   ├── Network		:[IP SETTING],[DHCP SERVER],[IPINTERFACE],[DHCP RELAY]
		│   ├── Time		:[TIME ZONE],[SYSTEM TIME],[PTP]
		├── Port				
		│   ├── Port Interface	:[PORT]
		│   ├── Link Aggregation	:[LA]
		│   ├── PoE			:[POE]
		├── Layer 2 Switching 			
		│   ├── VLAN		:[VLAN],[STATIC UNICAST]
		│   ├── GARP		:[GARP]
		│   ├── MAC			:[MAC]
		│   ├── QoS			:[QOS],[RLPS]
		│   ├── Multicast		:[IGMP SNOOPING],[GMRP],[STATIC MULTICAST]
		├── Layer 3 Routing
		│   ├── General	:[IP INTERFACE],[ARP]
		│   ├── Unicast Route	:[STATIC ROUTE],[OSPF],[ROUTING TABLE]
		├── Netowrk Redundancy			
		│   ├── Layer 2 Redundancy	:[LHC],[TURBO RING v2],[TURBO CHAIN],[DUAL HOMING],[RSTP]
		│   ├── Layer 3 Redundancy	:[VRRP]
		├── Management					
		│   ├── Network Management	:[SNMP],[SNMP TRAP/INFORM]
		├── Security					
		│   ├── Device Security	:[UI SERVICE MGMT],[LOGIN POLICY],[TRUST ACCESS]
		│   ├── Network Security	:[DOT1X],[PORT SECURITY],[STORM CTRL],[LP],[DHCP SNOOPING],[IP SOURCE GUARD],[MAC Authentication Bypass],[Dynamic ARP Inspection], [Media Access Control Security]
		│   ├── Authentication	:[RADIUS]
		├── Diagnostics					
		│   ├── System Status	:[SYSTEM UTILITY],[TCST],[IO]
		│   ├── Event Notification	:[EVENT],[RELAY],[EMAIL],[SYSLOG]
		│   ├── Diagnosis		:[LLDP],[PORT MIRROR],[EVENT LOG],[RMON],[FIBER CHECK]
		├── Industrial Protocol
        |   ├── Modbus TCP      :[MODBUS TCP]
		│   ├── PROFINET		:[PROFINET]

--------------------------------------------------------------------------------------------

	[LOCATOR]
		i.MIB file
		------------------------
		  mxLocator.mib         : All OIDs

		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- mxLocator.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib
		  3.mxGeneral.mib
		  4.mxLocator.mib		

	[PRODUCT INFORMAITON]
		i.MIB file
		------------------------
		  mxGeneralInfo.mib     : All OIDs
		  mxProductInfo.mib     : All OIDs
		  RFC1213-MIB.mib	: mib-2

		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- mxGeneralInfo.mib

		  1.mxGeneralInfo.mib

		- mxProductInfo.mib

		  1.mxProductInfo.mib

		- RFC1213-MIB.mib

		  1.RFC1213-MIB.mib

	[INFORMAITON SETTING]
		i.MIB file
		------------------------
		  mxSystemInfo.mib      : All OIDs

		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- mxSystemInfo.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib
		  3.mxGeneral.mib
		  4.mxSystemInfo.mib

	[PASSWORD POLICY]
		i.MIB file
		------------------------------
		  mxSysPasswordPolicySvr.mib  : All OIDs

		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- mxSysPasswordPolicySvr.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib
		  3.mxGeneral.mib
		  4.mxSysPasswordPolicySvr.mib

	[IP SETTING]
		i.MIB file
		------------------------
		  mxManagementIp.mib    : All OIDs

		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- mxManagementIp.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib
		  3.mxGeneral.mib
		  4.mxManagementIp.mib	

	[DHCP SERVER]
		i.MIB file
		------------------------
		  mxDhcpSvr.mib	        : All OIDs

		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- mxDhcpSvr.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib
		  3.mxGeneral.mib
		  4.mxDhcpSvr.mib	

	[TIME ZONE]
		i.MIB file
		------------------------
		  mxTimeZone.mib        : All OIDs

		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- mxTimeZone.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib
		  3.mxGeneral.mib
		  4.mxTimeZone.mib

	[SYSTEM TIME]
		i.MIB file
		------------------------
		  mxTimeSetting.mib	: All OIDs

		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- mxTimeSetting.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib
		  3.mxGeneral.mib
		  4.mxTimeSetting.mib

	[PTP]
		i.MIB file
		------------------------
		  mxPtp.mib					: Global PTP OIDs
		  mx1588.mib				: 1588 Default Profile OIDs
		  mxIec6185093Profile.mib	: IEC 61850-9-3 Profile OIDs
		  mxIeeeC37238Profile.mib	: IEEE C37.238 Profile OIDs

		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- mxPtp.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib
		  3.SNMPv2-CONF.mib
		  4.mxGeneral.mib
		  5.IF-MIB.mib
		  6.PTPBASE-MIB.mib
		  7.mxPtp.mib

		- mx1588.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib
		  3.SNMPv2-CONF.mib
		  4.mxGeneral.mib
		  5.IF-MIB.mib
		  6.PTPBASE-MIB.mib
		  7.mx1588.mib

		- mxIec6185093Profile.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib
		  3.SNMPv2-CONF.mib
		  4.mxGeneral.mib
		  5.IF-MIB.mib
		  6.PTPBASE-MIB.mib
		  7.mxIec6185093Profile.mib

		- mxIeeeC37238Profile.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib
		  3.SNMPv2-CONF.mib
		  4.mxGeneral.mib
		  5.IF-MIB.mib
		  6.PTPBASE-MIB.mib
		  7.mxIeeeC37238Profile.mib

	[PORT]
		i.MIB file
		------------------------
		  mxPort.mib		: All OIDs
		  IF-MIB.mib		: ifXTable, ifStackTable, ifRcvAddressTable, ifTable 	

		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- mxPort.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib
		  3.mxSwitching.mib
		  4.mxPort.mib

		- IF-MIB.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib
		  3.SNMPv2-CONF.mib
		  4.SNMPv2-MIB.mib
		  5.IANAifType-MIB.mib
		  6.IF-MIB.mib

	[LA]
		i.MIB file
		------------------------
		  mxLa.mib		: All OIDs
		  IEEE8023-LAG-MIB.mib	: dot3adAgg, dot3adAggPort 	
		  IF-MIB.mib		: ifXTable, ifStackTable, ifTable

		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- mxLa.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib
		  3.mxSwitching.mib
		  4.mxLa.mib

		- IEEE8023-LAG-MIB.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib
		  3.SNMPv2-CONF.mib
		  4.IEEE8023-LAG-MIB.mib

		- IF-MIB.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib
		  3.SNMPv2-CONF.mib
		  4.SNMPv2-MIB.mib
		  5.IANAifType-MIB.mib
		  6.IF-MIB.mib

	[POE]
		i.MIB file
		------------------------
		  mxPoe.mib             : PoE AT/AF OIDs
		  mxPoeBt.mib           : PoE BT OIDs

		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- mxPoe.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib
		  3.mxPoe.mib

		- mxPoeBt.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib
		  3.mxPoeBt.mib

	[VLAN]

		i.MIB file
		------------------------
		  mxVlan.mib            : All OIDs
		  Q-BRIDGE-MIB.mib      : dot1qBase, dot1qVlanStaticTable, dot1qVlanCurrentTable, dot1qPortVlanTable group OIDs

		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- mxVlan.mib

		  1.SNMPv2-SMI.mib
		  2.MOXA-SWITCHING-MIB.mib
		  3.mxVlan.mib

		- Q-BRIDGE-MIB.mib

		  1.SNMP-FRAMEWORK-MIB.mib
		  2.SNMPv2-SMI.mib
		  3.SNMPv2-TC.mib
		  4.SNMPv2-CONF.mib
		  5.SNMPv2-MIB.mib
		  6.IANAifType-MIB.mib
		  7.IF-MIB.mib
		  8.BRIDGE-MIB.mib
		  9.P-BRIDGE-MIB.mib
		  10.RFC1271-MIB.mib
		  11.RMON-MIB.mib
		  12.TOKEN-RING-RMON-MIB.mib
		  13.RMON2-MIB.mib
		  14.Q-BRIDGE-MIB.mib

	[STATIC UC]

		i.MIB file
		------------------------
		  Q-BRIDGE-MIB.mib      : dot1qStaticUnicastTable OIDs

		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- Q-BRIDGE-MIB.mib

		  1.SNMP-FRAMEWORK-MIB.mib
		  2.SNMPv2-SMI.mib
		  3.SNMPv2-TC.mib
		  4.SNMPv2-CONF.mib
		  5.SNMPv2-MIB.mib
		  6.IANAifType-MIB.mib
		  7.IF-MIB.mib
		  8.BRIDGE-MIB.mib
		  9.P-BRIDGE-MIB.mib
		  10.RFC1271-MIB.mib
		  11.RMON-MIB.mib
		  12.TOKEN-RING-RMON-MIB.mib
		  13.RMON2-MIB.mib
		  14.Q-BRIDGE-MIB.mib

	[GARP]

		i.MIB file
		------------------------
		  P-BRIDGE-MIB.mib      : dot1dGarp OIDs

		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- P-BRIDGE-MIB.mib

		  1.SNMP-FRAMEWORK-MIB.mib
		  2.SNMPv2-SMI.mib
		  3.SNMPv2-TC.mib
		  4.SNMPv2-CONF.mib
		  5.SNMPv2-MIB.mib
		  6.IANAifType-MIB.mib
		  7.IF-MIB.mib
		  8.BRIDGE-MIB.mib
		  9.P-BRIDGE-MIB.mib

	[MAC] - MAC table and Static Unicast

		i.MIB file
		------------------------
		  Q-BRIDGE-MIB.mib      : dot1qTpFdbTable, dot1qStaticUnicastTable group OIDs

		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- Q-BRIDGE-MIB.mib

		  1.SNMP-FRAMEWORK-MIB.mib
		  2.SNMPv2-SMI.mib
		  3.SNMPv2-TC.mib
		  4.SNMPv2-CONF.mib
		  5.SNMPv2-MIB.mib
		  6.IANAifType-MIB.mib
		  7.IF-MIB.mib
		  8.BRIDGE-MIB.mib
		  9.P-BRIDGE-MIB.mib
		  10.RFC1271-MIB.mib
		  11.RMON-MIB.mib
		  12.TOKEN-RING-RMON-MIB.mib
		  13.RMON2-MIB.mib
		  14.Q-BRIDGE-MIB.mib	

	[QOS] - Classification, Ingress Rate Limit, Scheduler, Egress Shaper

		i.MIB file
		------------------------
		  mxQos.mib             : All OIDs

		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- mxQos.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib		  
		  3.MOXA-SWITCHING-MIB.mib
		  4.mxQos.mib	

	[RLPS] - Ingress Rate Limit Port Shutdown

		i.MIB file
		------------------------
		  mxRlps.mib            : All OIDs

		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- mxRlps.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib		  
		  3.MOXA-SWITCHING-MIB.mib
		  4.mxRlps.mib	

	[IGMP SNOOPING]
	
		i.MIB file
		------------------------
		  mxIgmpSnp.mib         : All OIDs

		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- mxIgmpSnp.mib

		  1.SNMP-FRAMEWORK-MIB.mib
		  2.SNMPv2-SMI.mib
		  3.SNMPv2-TC.mib
		  4.SNMPv2-CONF.mib
		  5.SNMPv2-MIB.mib
		  6.IANAifType-MIB.mib
		  7.IF-MIB.mib
		  8.BRIDGE-MIB.mib
		  9.P-BRIDGE-MIB.mib
		  10.RFC1271-MIB.mib
		  11.RMON-MIB.mib
		  12.TOKEN-RING-RMON-MIB.mib
		  13.RMON2-MIB.mib
		  14.Q-BRIDGE-MIB.mib 
		  15.INET-ADDRESS-MIB.mib
		  16.mxIgmpSnp.mib

	[GMRP]

		i.MIB file
		------------------------
		  P-BRIDGE-MIB.mib      : dot1dExtBase, dot1dGmrp OIDs
		  Q-BRIDGE-MIB.mib      : dot1qTpGroupTable OIDs

		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- P-BRIDGE-MIB.mib

		  1.SNMP-FRAMEWORK-MIB.mib
		  2.SNMPv2-SMI.mib
		  3.SNMPv2-TC.mib
		  4.SNMPv2-CONF.mib
		  5.SNMPv2-MIB.mib
		  6.IANAifType-MIB.mib
		  7.IF-MIB.mib
		  8.BRIDGE-MIB.mib
		  9.P-BRIDGE-MIB.mib

		- Q-BRIDGE-MIB.mib

		  1.SNMP-FRAMEWORK-MIB.mib
		  2.SNMPv2-SMI.mib
		  3.SNMPv2-TC.mib
		  4.SNMPv2-CONF.mib
		  5.SNMPv2-MIB.mib
		  6.IANAifType-MIB.mib
		  7.IF-MIB.mib
		  8.BRIDGE-MIB.mib
		  9.P-BRIDGE-MIB.mib
		  10.RFC1271-MIB.mib
		  11.RMON-MIB.mib
		  12.TOKEN-RING-RMON-MIB.mib
		  13.RMON2-MIB.mib
		  14.Q-BRIDGE-MIB.mib

	[STATIC MC]

		i.MIB file
		------------------------
		  Q-BRIDGE-MIB.mib      : dot1qStaticMulticastTable OIDs

		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- Q-BRIDGE-MIB.mib

		  1.SNMP-FRAMEWORK-MIB.mib
		  2.SNMPv2-SMI.mib
		  3.SNMPv2-TC.mib
		  4.SNMPv2-CONF.mib
		  5.SNMPv2-MIB.mib
		  6.IANAifType-MIB.mib
		  7.IF-MIB.mib
		  8.BRIDGE-MIB.mib
		  9.P-BRIDGE-MIB.mib
		  10.RFC1271-MIB.mib
		  11.RMON-MIB.mib
		  12.TOKEN-RING-RMON-MIB.mib
		  13.RMON2-MIB.mib
		  14.Q-BRIDGE-MIB.mib

	[LHC] - Link Healthy Check

		i.MIB file
		------------------------
		  mxLhc.mib             : All OIDs

		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- mxLhc.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib		  
		  3.MOXA-SWITCHING-MIB.mib
		  4.mxLhc.mib	

	[TURBO RING V2]

		i.MIB file
		------------------------
		  mxTrv2.mib            : All OIDs

		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- mxTrv2.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib		  
		  3.MOXA-SWITCHING-MIB.mib
		  4.mxTrv2.mib

	[TURBO CHAIN]
 
		i.MIB file
		------------------------
		  mxTc.mib             	: All OIDs

		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- mxTc.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib		  
		  3.MOXA-SWITCHING-MIB.mib
		  4.mxTc.mib

	[DUAL HOMING]

		i.MIB file
		------------------------
		  mxDualHoming.mib      : All OIDs

		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- mxDualHoming.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib		  
		  3.MOXA-SWITCHING-MIB.mib
		  4.mxDualHoming.mib

	[RSTP]

		i.MIB file
		----------------------------------------
		  IEEE8021-SPANNING-TREE-MIB.mib	: ieee8021SpanningTreeTable, ieee8021SpanningTreePortTable group OIDs	
		  mxRstp.mib             		: All OIDs

		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- IEEE8021-SPANNING-TREE-MIB.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib
		  3.SNMPv2-CONF.mib
		  4.SNMPv2-MIB.mib
		  5.IANAifType-MIB.mib
		  6.IF-MIB.mib
		  7.IEEE8021-TC-MIB.mib
		  8.BRIDGE-MIB.mib
		  9.IEEE8021-SPANNING-TREE-MIB.mib

		- mxRstp.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib	
		  3.SNMPv2-CONF.mib
		  4.SNMPv2-MIB.mib
		  5.IANAifType-MIB.mib
		  6.IF-MIB.mib
		  7.IEEE8021-TC-MIB.mib
		  8.BRIDGE-MIB.mib
		  9.IEEE8021-SPANNING-TREE-MIB.mib		  
		  10.MOXA-SWITCHING-MIB.mib
		  11.mxRstp.mib

	[MSTP]

		i.MIB file
		----------------------------------------
		  IEEE8021-MSTP-MIB.mib : ieee8021MstpCistTable, ieee8021MstpTable, ieee8021MstpCistPortTable,
		                          ieee8021MstpPortTable, ieee8021MstpFidToMstiTable, ieee8021MstpFidToMstiV2Table,
		                          ieee8021MstpVlanTable, ieee8021MstpVlanV2Table, ieee8021MstpConfigIdTable,
		                          and ieee8021MstpCistPortExtensionTable group OIDs
		  mxRstp.mib            : All OIDs

		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- IEEE8021-MSTP-MIB.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib
		  3.SNMPv2-CONF.mib
		  4.SNMPv2-MIB.mib
		  5.IANAifType-MIB.mib
		  6.IF-MIB.mib
		  7.IEEE8021-TC-MIB.mib
		  8.BRIDGE-MIB.mib
		  9.IEEE8021-MSTP-MIB.mib

		- mxMstp.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib
		  3.SNMPv2-CONF.mib
		  4.SNMPv2-MIB.mib
		  5.IANAifType-MIB.mib
		  6.IF-MIB.mib
		  7.IEEE8021-TC-MIB.mib
		  8.BRIDGE-MIB.mib
		  9.IEEE8021-SPANNING-TREE-MIB.mib
		  10.MOXA-SWITCHING-MIB.mib
		  11.mxMstp.mib

	[SNMP]

		i.MIB file
		------------------------
		  SNMPv2-MIB.mib	: mib-2/snmp OIDs	
		  mxSnmp.mib            : All OIDs

		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- SNMPv2-MIB.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib
		  3.SNMPv2-CONF.mib
		  4.SNMPv2-MIB.mib

		- mxSnmp.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib	
		  3.mxSnmp.mib

	[SNMP TRAP/INFORM]

		i.MIB file
		------------------------
		  mxTrapC.mib           : All OIDs

		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- mxTrapC.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib	
		  3.mxTrapC.mib

	[UI SERVICE MGMT]

		i.MIB file
		------------------------
		  mxUiServiceMgmt.mib   : All OIDs

		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- mxUiServiceMgmt.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib	
		  3.mxGeneral.mib
		  4.mxUiServiceMgmt.mib

	[LOGIN POLICY]

		i.MIB file
		--------------------------------
		  mxSysLoginPolicySvr.mib	: All OIDs

		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- mxSysLoginPolicySvr.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib
		  3.mxGeneral.mib
		  4.mxSysLoginPolicySvr.mib

	[TRUST ACCESS]

		i.MIB file
		--------------------------------
		  mxSysTrustAccessSvr.mib	: All OIDs

		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- mxSysTrustAccessSvr.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib	
		  3.mxGeneral.mib
		  4.mxSysTrustAccessSvr.mib

	[DOT1X]

		i.MIB file
		------------------------
		  IEEE8021-PAE-MIB.mib	: paeMIBObjects related OIDs
		  mxDot1x.mib           : All OIDs

		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- IEEE8021-PAE-MIB.mib

	      1.SNMP-FRAMEWORK-MIB.mib
		  2.SNMPv2-SMI.mib
		  3.SNMPv2-TC.mib	
		  4.SNMPv2-CONF.mib
		  5.SNMPv2-MIB.mib
		  6.IANAifType-MIB.mib
		  7.IF-MIB.mib
		  8.IEEE8021-PAE-MIB.mib

		- mxDot1x.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib		  
		  3.MOXA-SWITCHING-MIB.mib
		  4.mxDot1x.mib

	[PORT SECURITY] - Mac-Sticky and Static Port Lock

		i.MIB file
		------------------------
		  mxPsms.mib		: All OIDs
		  mxPssp.mib            : All OIDs

		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- mxPsms.mib

		  1.SNMP-FRAMEWORK-MIB.mib
		  2.SNMPv2-SMI.mib
		  3.SNMPv2-TC.mib
		  4.SNMPv2-CONF.mib
		  5.SNMPv2-MIB.mib
		  6.IANAifType-MIB.mib
		  7.IF-MIB.mib
		  8.BRIDGE-MIB.mib
		  9.P-BRIDGE-MIB.mib
		  10.RFC1271-MIB.mib
		  11.RMON-MIB.mib
		  12.TOKEN-RING-RMON-MIB.mib
		  13.RMON2-MIB.mib
		  14.Q-BRIDGE-MIB.mib 
		  15.MOXA-SWITCHING-MIB.mib
		  16.mxPsms.mib
		  
		- mxPssp.mib

		  1.SNMP-FRAMEWORK-MIB.mib
		  2.SNMPv2-SMI.mib
		  3.SNMPv2-TC.mib
		  4.SNMPv2-CONF.mib
		  5.SNMPv2-MIB.mib
		  6.IANAifType-MIB.mib
		  7.IF-MIB.mib
		  8.BRIDGE-MIB.mib
		  9.P-BRIDGE-MIB.mib
		  10.RFC1271-MIB.mib
		  11.RMON-MIB.mib
		  12.TOKEN-RING-RMON-MIB.mib
		  13.RMON2-MIB.mib
		  14.Q-BRIDGE-MIB.mib 
		  15.MOXA-SWITCHING-MIB.mib
		  16.mxPssp.mib

	[STORM CTRL]

		i.MIB file
		------------------------
		  mxStcl.mib            : All OIDs

		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- mxStcl.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib		  
		  3.MOXA-SWITCHING-MIB.mib
		  4.mxStcl.mib

	[SYSTEM UTILITY]

		i.MIB file
		------------------------
		  mxSysUtilSvr.mib	: All OIDs

		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- mxSysUtilSvr.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib	
		  3.mxGeneral.mib
		  4.mxSysUtilSvr.mib

	[TCST] - Traffic Statistics

		i.MIB file
		------------------------
		  mxTcst.mib		: All OIDs

		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- mxTcst.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib	
		  3.MOXA-SWITCHING-MIB.mib
		  4.mxTcst.mib

	[IO] - Input / Output IO 

		i.MIB file
		------------------------
		  mxDeviceIo.mib	: All OIDs

		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- mxDeviceIo.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib	
		  3.mxGeneral.mib
		  4.mxDeviceIo.mib		

	[EVENT]  

		i.MIB file
		------------------------
		  mxGene.mib        : All OIDs
		  mxPoee.mib        : All OIDs
		  mxPorte.mib       : All OIDs
		  mxSwe.mib         : All OIDs

		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- mxGene.mib
		- mxPoee.mib
		- mxPorte.mib
		- mxSwe.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib	
		  3.mxGeneral.mib
		  4.mxGene.mib / mxPoee.mib / mxPorte.mib / mxSwe.mib

	[RELAY]  

		i.MIB file
		------------------------
		  mxRelayC.mib		: All OIDs

		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- mxRelayC.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib	
		  3.mxGeneral.mib
		  4.mxRelayC.mib 

	[EMAIL]

		i.MIB file
		------------------------
		  mxEmailC.mib		: All OIDs

		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- mxEmailC.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib
		  3.mxGeneral.mib
		  4.mxEmailC.mib 

	[SYSLOG]

		  i.MIB file
		------------------------
		  mxSyslogSvr.mib	: All OIDs

		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- mxSyslogSvr.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib	
		  3.mxGeneral.mib
		  4.mxSyslogSvr.mib 

	[LLDP]

		i.MIB file
		------------------------
		  LLDP-MIB.mib		: lldpObjects OIDs
		  LLDP-EXT-DOT1-MIB.mib	: lldpXdot1ConfigPortVlanTable, lldpXdot1ConfigVlanNameTable, lldpXdot1LocVlanNameTable, lldpXdot1LocTable related OIDs
		  LLDP-EXT-DOT3-MIB.mib	: lldpXdot3PortConfigTable, lldpXdot3LocPortTable, lldpXdot3LocLinkAggTable, lldpXdot3LocMaxFrameSizeTable
		  LLDP-EXT-ODVA-MIB.mib : lldpXOdvaLocTable, lldpXOdvaRemTable

		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- LLDP-MIB.mib

		  1.SNMP-FRAMEWORK-MIB.mib
		  2.SNMPv2-SMI.mib
		  3.SNMPv2-TC.mib
		  4.SNMPv2-CONF.mib
		  5.SNMPv2-MIB.mib
		  6.IANAifType-MIB.mib
		  7.RFC1271-MIB.mib
		  8.RMON-MIB.mib
		  9.TOKEN-RING-RMON-MIB.mib
		  10.RMON2-MIB.mib
		  11.IANA-ADDRESS-FAMILY-NUMBERS-MIB.mib
		  12.LLDP-MIB.mib

		- LLDP-EXT-DOT1-MIB.mib

		  1.SNMP-FRAMEWORK-MIB.mib
		  2.SNMPv2-SMI.mib
		  3.SNMPv2-TC.mib
		  4.SNMPv2-CONF.mib
		  5.SNMPv2-MIB.mib
		  6.IANAifType-MIB.mib
		  7.RFC1271-MIB.mib
		  8.RMON-MIB.mib
		  9.TOKEN-RING-RMON-MIB.mib
		  10.RMON2-MIB.mib
		  11.IANA-ADDRESS-FAMILY-NUMBERS-MIB.mib
		  12.LLDP-MIB.mib
		  13.BRIDGE-MIB.mib
		  14.P-BRIDGE-MIB.mib
		  15.Q-BRIDGE-MIB.mib
		  16.LLDP-EXT-DOT1-MIB.mib

		- LLDP-EXT-DOT3-MIB.mib

		  1.SNMP-FRAMEWORK-MIB.mib
		  2.SNMPv2-SMI.mib
		  3.SNMPv2-TC.mib
		  4.SNMPv2-CONF.mib
		  5.SNMPv2-MIB.mib
		  6.IANAifType-MIB.mib
		  7.RFC1271-MIB.mib
		  8.RMON-MIB.mib
		  9.TOKEN-RING-RMON-MIB.mib
		  10.RMON2-MIB.mib
		  11.IANA-ADDRESS-FAMILY-NUMBERS-MIB.mib
		  12.LLDP-MIB.mib
		  13.LLDP-EXT-DOT3-MIB.mib

	  - LLDP-EXT-ODVA-MIB.mib

		  1.SNMP-FRAMEWORK-MIB.mib
		  2.SNMPv2-SMI.mib
		  3.SNMPv2-TC.mib
		  4.SNMPv2-CONF.mib
		  5.SNMPv2-MIB.mib
		  6.IANAifType-MIB.mib
		  7.RFC1271-MIB.mib
		  8.RMON-MIB.mib
		  9.TOKEN-RING-RMON-MIB.mib
		  10.RMON2-MIB.mib
		  11.IANA-ADDRESS-FAMILY-NUMBERS-MIB.mib
		  12.LLDP-MIB.mib
		  13.LLDP-EXT-ODVA-MIB.mib

	[LP]
		i.MIB file
		------------------------
		  mxLp.mib         : All OIDs

		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- mxLp.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib
		  3.MOXA-SWITCHING-MIB.mib
		  4.mxLp.mib

	[PORT MIRROR]

		i.MIB file
		------------------------
		  mxPortMirror.mib	: All OIDs

		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- mxPortMirror.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib	
		  3.MOXA-SWITCHING-MIB.mib
		  4.mxPortMirror.mib

	[EVENT LOG]

		i.MIB file
		------------------------
		  mxEventLog.mib        : All OIDs


		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- mxEventLog.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib	
		  3.mxGeneral.mib
		  4.mxEventLog.mib 

	[RMON]

		i.MIB file
		------------------------
		  RMON-MIB.mib          : statistics, history, alarm, and event related OIDs

		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- mxPsms.mib

		  1.SNMP-FRAMEWORK-MIB.mib
		  2.SNMPv2-SMI.mib
		  3.SNMPv2-TC.mib
		  4.SNMPv2-CONF.mib
		  5.SNMPv2-MIB.mib
		  6.IANAifType-MIB.mib
		  7.IF-MIB.mib
		  8.RFC1271-MIB.mib
		  9.RMON-MIB.mib

	[ARP]

		i.MIB file
		------------------------
		  mxArp.mib          : All OIDs

		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- mxArp.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib
		  3.mxArp.mib

	[IPINTERFACE]

		i.MIB file
		------------------------
		  mxIpIf.mib          : All OIDs

		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- mxIpIf.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib
		  3.mxIpIf.mib

	[OSPF]

		i.MIB file
		------------------------
		  mxOspf.mib          : All OIDs

		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- mxOspf.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib
		  3.mxOspf.mib

	[ROUTING EVENT]

		i.MIB file
		------------------------
		  mxRte.mib          : All OIDs

		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- mxRte.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib
		  3.MOXA-GENERAL-MIB.mib
		  4.mxRte.mib

	[STATIC ROUTE]

		i.MIB file
		------------------------
		  mxStaticRoute.mib          : All OIDs

		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- mxStaticRoute.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib
		  3.mxStaticRoute.mib

	[UNICAST ROUTING TABLE]

		i.MIB file
		------------------------
		  mxUnicastRoutingTable.mib          : All OIDs

		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- mxUnicastRoutingTable.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib
		  3.mxUnicastRoutingTable.mib

	[VRRP]

		i.MIB file
		------------------------
		  mxVrrp.mib          : All OIDs

		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- mxVrrp.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib
		  3.mxVrrp.mib

	[MMS]
		i.MIB file
		------------------------
		  mxMms.mib         : All OIDs

		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- mxMms.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib
		  3.mxMms.mib

	[DHCP SNOOPING]
		i.MIB file
		------------------------
		  mxDhcpSnp.mib         : All OIDs

		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- mxDhcpSnp.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib
		  3.MOXA-SWITCHING-MIB.mib
		  4.mxDhcpSnp.mib

	[DHCP RELAY]
		i.MIB file
		------------------------
		  mxDhcpRelay.mib	        : All OIDs

		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- mxDhcpRelay.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib
		  3.mxGeneral.mib
		  4.mxDhcpRelay.mib

	[IP SOURCE GUARD]
		i.MIB file
		------------------------
		  mxIpsg.mib         : All OIDs

		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- mxIpsg.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib
		  3.MOXA-SWITCHING-MIB.mib
		  4.mxIpsg.mib

	[FIBER CHECK]

		i.MIB file
		------------------------
		  mxFiberCheck.mib        : All OIDs


		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- mxFiberCheck.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib
		  3.MOXA-SWITCHING-MIB.mib
		  4.mxFiberCheck.mib

	[MODBUS TCP]
        i.MIB file
        ------------------------
          mxModbusTcp.mib         : All OIDs

		ii.Import MIB flow
        ------------------------
          No other MIBs are needed to pre-load first before import the customer user MIB.
          So below lists the loading steps:

        - mxLocator.mib

          1.mxLocator.mib

	[PROFINET]
		i.MIB file
		------------------------
		  mxProfinet.mib    : All OIDs

		ii.Import MIB flow
		------------------------
		  No other MIBs are needed to pre-load first before import the customer user MIB.
		  So below lists the loading steps:

		- mxProfinet.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib
		  3.mxProfinet.mib

	[MAC Authentication Bypass]

		i.MIB file
		------------------------
		  mxMab.mib		: All OIDs

		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- mxMab.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib
		  3.MOXA-SWITCHING-MIB.mib
		  4.mxMab.mib

	[Dynamic ARP Inspection]
		i.MIB file
		------------------------
		  mxDai.mib         : All OIDs

		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- mxDai.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib
		  3.MOXA-SWITCHING-MIB.mib
		  4.mxDai.mib

	[Media Access Control Security]
		i.MIB file
		------------------------
		  mxMacsec.mib         : All OIDs

		ii.Import MIB flow
		------------------------
		  Some MIB browser or compilers need pre-load related MIBs first before import the customer user MIB.
		  So below lists the loading steps:

		- mxMacsec.mib

		  1.SNMPv2-SMI.mib
		  2.SNMPv2-TC.mib
		  3.MOXA-SWITCHING-MIB.mib
		  4.mxMacsec.mib

	[EtherNet/IP]

		i.MIB file
		------------------------
		  mxEip.mib		: All OIDs

		ii.Import MIB flow
		------------------------
		  No other MIBs are needed to pre-load first before import the customer user MIB.
		  So below lists the loading steps:

		- mxLocator.mib

		  1.mxLocator.mib

4. MIB tree 
===========

iso(1)
     |-std(0)-iso8802(8802)-ieee802dot1(1)-ieee802dot1mibs(1)
     |                                                     |-ieee8021paeMIB(1) 				: IEEE8021-PAE-MIB.mib
     |                                                     |-ieee8021SpanningTreeMib(3) 	: IEEE8021-SPANNING-TREE-MIB.mib
     |-org(3)
           |-dod(6)-internet(1)
           |                 |-mgmt(2)-mib-2(1)  									: SNMPv2-MIB.mib
           |                 |               |-system(1) 							: RFC1213-MIB.mib
           |                 |      	     |-interface(2) 						: RFC1213-MIB.mib
           |                 |               |-at(3) 								: RFC1213-MIB.mib 
           |                 |               |-snmp(11)								: RFC1213-MIB.mib
           |                 |               |-ospf(14)								: OSPF-MIB.mib
           |                 |               |-rmon(16)								: RMON-MIB.mib
           |                 |               |-dot1dBridge(17)  					: BRIDGE-MIB.mib, P-BRIDGE-MIB.mib, Q-BRIDGE-MIB.mib 
           |                 |               |-ifMIB(31)							: IF-MIB.mib 
           |                 |               |-etherMIB(35)							: EtherLike-MIB.mib 
           |                 |-private(4)-moxa(8691)
           |                 |                   |-product(600)						: mxGeneralInfo.mib, mxProductInfo.mib,
           |                 |                   |-general(602)						: mxGeneral.mib, mxDeviceIo.mib, mxDhcpRelay.mib, mxDhcpSvr.mib, mxEmailC.mib, 
           |                 |                   |									: mxEventLog.mib, mxGene.mib, mxLocator.mib, mxManagementIp.mib, mxPoee.mib,
           |                 |                   |									: mxPorte.mib, mxRelayC.mib, mxSnmp.mib, mxSwe.mib, mxSysLoginPolicySvr.mib,
           |                 |                   |									: mxSyslogSvr.mib, mxSysPasswordPolicySvr.mib, mxSystemInfo.mib,
           |                 |                   |									: mxSysTrustAccessSvr.mib, mxSysUtilSvr.mib, mxTimeSetting.mib,
           |                 |                   |									: mxTimeZone.mib, mxTrapC.mib, mxUiServiceMgmt.mib, mxRte.mib, mxMms.mib,
           |                 |                   |									: mxPtp.mib, mx1588.mib, mxIec6185093Profile.mib, mxIeeeC37238Profile.mib, mxModbusTcp.mib, mxProfinet.mib, mxEip.mib
           |                 |                   |-switching(603)					: mxSwitching.mib
           |                 |                   |            |- portInterfacce 	: mxPort.mib, mxLa.mib
           |                 |                   |            |- basicLayer2		: mxLhc.mib, mxQos, mxVlan.mib
           |                 |                   |            |- layer2Redundancy	: mxRstp.mib, mxTrv2.mib, mxTurboChain.mib, mxDualHoming.mib
           |                 |                   |            |- layer2Security		: mxStcl.mib, mxRlps.mib, mxPssp.mib, mxPsms.mib, mxDot1x.mib, mxRadius.mib, mxLp.mib, mxDhcpSnp.mib, mxIpsg.mib, mxMab.mib, mxDai.mib, mxMacsec.mib
           |                 |                   |            |- layer2Diagnosic	: mxLldp.mib, mxTcst.mib, mxPortMirror.mib, mxRmon.mib, mxFiberCheck.mib
           |                 |                   |            |- layer3Diagnosic
           |                 |                   |            |- layer2Multicast	: mxIgmpSnp.mib
           |                 |                   |            |- layer3Multicast
           |                 |                   |-routing(605)
           |                 |                   |            |- l3Genral		: mxIpIf.mib, mxArp.mib
           |                 |                   |            |- unicastRouting		: mxUnicastRoutingTable.mib, mxStaticRoute.mib, mxOspf.mib
           |                 |                   |            |- l3Redundant		: mxVrrp.mib
           |                 |                   |-poe(608)  						: mxPoe.mib                    
           |                 |-snmpV2(6)-snmpModules(3)
           |                        	             |-snmpFrameworkMIB(10)			: SNMP-FRAMEWORK.mib 
           |
           |-ieee(111)-standards-association-numbers-series-standards(2)-lan-man-stds(802)-ieee802dot1(1)-ieee802dot1mibs(1)-ieee8021SpanningTreeMib(3)	
																					: IEEE8021-SPANNING-TREE-MIB.mib

END OF README.txt
