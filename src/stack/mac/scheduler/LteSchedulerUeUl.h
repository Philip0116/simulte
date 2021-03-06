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
#ifndef LTE_SCHEDULER_UE_UL_H_
#define LTE_SCHEDULER_UE_UL_H_

/**
 * @class LteSchedulerUeUl
 *
 * LTE Ue uplink scheduler.
 */

#include <LteCommon.h>

class LteMacUe;
class LcgScheduler;

class LteSchedulerUeUl
{

	protected:

	// MAC module, queried for parameters
	LteMacUe *mac_;

	// Schedule List
	LteMacScheduleList scheduleList_;

	// Inner Scheduler - default to Standard LCG
	LcgScheduler* lcgScheduler_;

	public:

	/* Performs the standard LCG scheduling algorithm
	 * @returns reference to scheduling list
	 */

	 LteMacScheduleList* schedule();

	/*
	 * constructor
	 */
	LteSchedulerUeUl(LteMacUe * mac);
};

#endif // LTE_SCHEDULER_UE_UL_H_
