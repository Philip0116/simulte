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
#ifndef LTEMAXCI_H
#define LTEMAXCI_H

#include <LteScheduler.h>

class LteMaxCi : public virtual LteScheduler
{

	protected:	

	typedef SortedDesc<MacCid,unsigned int> ScoreDesc;
	typedef std::priority_queue<ScoreDesc> ScoreList;


	public:
	
	virtual void prepareSchedule();
	
	virtual void commitSchedule();

	// *****************************************************************************************

	void notifyActiveConnection ( MacCid cid );

	void removeActiveConnection ( MacCid cid );

	void updateSchedulingInfo();
};

#endif // LTEMAXCI_H
