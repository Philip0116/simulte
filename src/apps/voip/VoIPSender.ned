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

package lte.apps.voip;

import inet.applications.IUDPApp;


simple VoIPSender like IUDPApp
{
    parameters:
        int localPort = default(-1);
        int destPort = default(3000);
        string destAddress;
        int PacketSize = default(40);
        double shape_talk = default(0.824);
        double scale_talk = default(1.423);
        double shape_sil = default(1.089);
        double scale_sil = default(0.899);
        bool is_talk = default(true);
        double sampling_time = default(0.02);
        double startTime @unit("s") = default(0);

        @display("i=block/source");
    gates:
        output udpOut;
        input udpIn;
}
