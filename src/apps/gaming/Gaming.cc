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


#include "Gaming.h"
Define_Module(Gaming);

Gaming::Gaming():UDPBasicApp() {
	// TODO Auto-generated constructor stub

}

Gaming::~Gaming() {
	// TODO Auto-generated destructor stub
}
cPacket *Gaming::createPacket()
{
    char msgName[32];
    sprintf(msgName,"Gaming");

    cPacket *payload = new cPacket(msgName);
    payload->setByteLength(par("messageLength").longValue());
    return payload;
}
