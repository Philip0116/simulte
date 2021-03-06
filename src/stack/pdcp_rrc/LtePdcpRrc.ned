// 
//                           SimuLTE
// Copyright (C) 2012 Antonio Virdis, Daniele Migliorini, Giovanni
// Accongiagioco, Generoso Pagano, Vincenzo Pii.
// 
// This file is part of a software released under the license included in file
// "license.pdf". This license can be also found at http://www.ltesimulator.com/
// The above file and the present reference are part of the software itself, 
// and cannot be removed from it.
// 


package lte.stack.pdcp_rrc;



// 
// Interface for the PDCP/RRC layer of LTE Stack.
//
moduleinterface LtePdcpRrc {
	parameters:
	    @display("i=block/fork");
	    int headerCompressedSize @unit(B);
	    
	gates:
        inout DataPort;
        inout EUTRAN_RRC_Sap;
		inout TM_Sap;
        inout UM_Sap;
        inout AM_Sap;
}


// 
// Base module for the PDCP/RRC layer of LTE Stack.
//
simple LtePdcpRrcBase like LtePdcpRrc {
	    
	parameters:
	    @display("i=block/fork");
	    int headerCompressedSize @unit(B) = default(-1B);	// Header compressed size (bytes) ( -1B = compression disabled 
		int conversationalRlc @enum(TM, UM, AM, UNKNOWN_RLC_TYPE) = default(1);
		int streamingRlc @enum(TM, UM, AM, UNKNOWN_RLC_TYPE) = default(1);
		int interactiveRlc @enum(TM, UM, AM, UNKNOWN_RLC_TYPE) = default(1);
		int backgroundRlc @enum(TM, UM, AM, UNKNOWN_RLC_TYPE) = default(1);	    
		
		//#
    	//# Statistic recording: end2end delay and throughput at the mac layer
        //#
        @statistic[pdcpdrop0](title="Drop at PDCP layer 0"; unit=""; source="pdcpdrop0"; record=lteAvg);
        @statistic[pdcpdrop1](title="Drop at PDCP layer 1"; unit=""; source="pdcpdrop1"; record=lteAvg);
        @statistic[pdcpdrop2](title="Drop at PDCP layer 2"; unit=""; source="pdcpdrop2"; record=lteAvg);
        @statistic[pdcpdrop3](title="Drop at PDCP layer 3"; unit=""; source="pdcpdrop3"; record=lteAvg);
        @statistic[receivedPacketFromUpperLayer](source="receivedPacketFromUpperLayer"; record=count,"sum(packetBytes)","vector(packetBytes)"; interpolationmode=none);
        @statistic[receivedPacketFromLowerLayer](source="receivedPacketFromLowerLayer"; record=count,"sum(packetBytes)","vector(packetBytes)"; interpolationmode=none);
        @statistic[sentPacketToUpperLayer](source="sentPacketToUpperLayer"; record=count,"sum(packetBytes)","vector(packetBytes)"; interpolationmode=none);
        @statistic[sentPacketToLowerLayer](source="sentPacketToLowerLayer"; record=count,"sum(packetBytes)","vector(packetBytes)"; interpolationmode=none);
	gates:
        //# 
        //# Gates connecting UE/eNB and PDCP/RRC Layer
        //#     
        //# Data Ports

        inout DataPort;			// Port to transmit data packets

        //# Control Ports

        inout EUTRAN_RRC_Sap;	// Control of RRC Layer

        //# 
        //# Gates connecting PDCP/RRC and RLC Layer
        //#
        //# Data Ports

		inout TM_Sap;			// Transparent Mode SAP
        inout UM_Sap;			// Unacknowledged Mode SAP
        inout AM_Sap;			// Acknowledged Mode SAP
}

//
// User Equipment PDCP/RRC layer of LTE stack
//
simple LtePdcpRrcUe extends LtePdcpRrcBase {
    @class("LtePdcpRrcUe");
}

//
// eNodeB PDCP/RRC layer of LTE stack
//
simple LtePdcpRrcEnb extends LtePdcpRrcBase {
    @class("LtePdcpRrcEnb");
}

//
// Relay (UE side) PDCP/RRC layer of LTE stack
// Connection: eNodeB <--> Relay
//
simple LtePdcpRrcRelayUe extends LtePdcpRrcBase {
    @class("LtePdcpRrcRelayUe");
}

//
// Relay (eNB side) PDCP/RRC layer of LTE stack
// Connection: Relay <--> UE
//
simple LtePdcpRrcRelayEnb extends LtePdcpRrcBase {
    @class("LtePdcpRrcRelayEnb");
}
