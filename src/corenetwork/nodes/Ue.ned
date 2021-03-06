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


package lte.corenetwork.nodes;

import inet.applications.ITCPApp;
import inet.applications.IUDPApp;
import inet.base.NotificationBoard;
import inet.mobility.IMobility;
import inet.networklayer.common.InterfaceTable;
import inet.networklayer.ipv4.ErrorHandling;
import inet.networklayer.ipv4.ICMP;
import inet.networklayer.ipv4.RoutingTable;
import inet.transport.tcp.TCP;
import inet.transport.udp.UDP;
import lte.corenetwork.lteip.LteIp;
import lte.stack.phy.LteNicUe;


// 
// User Equipment Module
//
module Ue
{
    parameters:
        @node();
        @display("i=device/pocketpc;bgb=400,400");

        //# Mobility
        string mobilityType = default("StationaryMobility");

        //# Apps
        int numTcpApps = default(0);  // no of TCP apps. Specify the app types in INI file with tcpApp[0..1].typename="TCPEchoApp" syntax
        int numUdpApps = default(0);  // no of UDP apps. Specify the app types in INI file with udpApp[0..1].typename="UDPVideoStreamCli" syntax

        //# Node specs
        string nodeType = "UE";  // DO NOT CHANGE
        int masterId;
        int macNodeId = default(0); // TODO: this is not a real parameter
        int macCellId = default(0); // TODO: this is not a real parameter

    gates:
        input radioIn @directIn;     // connection to master

    submodules:
        notificationBoard: NotificationBoard {
            @display("p=50,25;is=s");
        }
        interfaceTable: InterfaceTable {
            @display("p=50,75;is=s");
        }
        routingTable: RoutingTable {
            @display("p=50,125;is=s");
        }
        mobility: <mobilityType> like IMobility {
            @display("p=50,175;is=s");
        }
        tcpApp[numTcpApps]: <> like ITCPApp {
            @display("p=175,50,row");
        }
        tcp: TCP if numTcpApps>0 {
            @display("p=175,150");
        }
        udpApp[numUdpApps]: <> like IUDPApp {
            @display("p=325,50,row");
        }
        udp: UDP if numUdpApps>0 {
            @display("p=325,150");
        }
        lteIp: LteIp {
            @display("p=250,250");
            nodeType = nodeType;
            protocolMapping = "6:0,17:1,1:2";
            gates:
                transportIn[3];
                transportOut[3];
        }
        // NOTE: instance must be named "nic"
        nic: LteNicUe {
            @display("p=250,350");
        }
        errorHandling: ErrorHandling {
            @display("p=119,250");
        }
        icmp: ICMP {
            @display("p=195,250");
        }
    connections allowunconnected:
        //# 
        //# Internal TCP/UDP applications connections with IP stack
        //#

        for i=0..numTcpApps-1 {
            tcpApp[i].tcpOut --> tcp.appIn++;
            tcpApp[i].tcpIn <-- tcp.appOut++;
        }

        tcp.ipOut --> lteIp.transportIn[0] if numTcpApps>0;
        tcp.ipIn <-- lteIp.transportOut[0] if numTcpApps>0;

        for i=0..numUdpApps-1 {
            udpApp[i].udpOut --> udp.appIn++;
            udpApp[i].udpIn <-- udp.appOut++;
        }

        udp.ipOut --> lteIp.transportIn[1] if numUdpApps>0;
        udp.ipIn <-- lteIp.transportOut[1] if numUdpApps>0;

        icmp.localIn <-- lteIp.transportOut[2];
        icmp.sendOut --> lteIp.transportIn[2];

        icmp.errorOut --> errorHandling.in;  // log ICMP messages

		//#
		//# Internal LTE stack to PHY connections
		//#

        lteIp.stackLte$i <-- nic.upperLayerOut;	// LTE Stack data port
        lteIp.stackLte$o --> nic.upperLayerIn; // LTE Stack data port

        //# 
        //# External connection to air interface
        //#

        nic.radioIn <-- radioIn;
}
