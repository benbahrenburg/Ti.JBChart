/**
 * Ti.JBChart (https://github.com/benbahrenburg/Ti.JBChart)
 *
 * Titanium code Copyright (c) 2009-2014 by Ben Bahrenburg. All Rights Reserved.
 * Licensed under the terms of the Apache 2.0 License
 * Please see the LICENSE included with this distribution for details.
 *
 * Ti.JBChart is a Titanium wrapper for JBChartView
 * for more information please visit https://github.com/Jawbone/JBChartView
 */

#import "TiJbchartModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#import "JBConstants.h"
#import "JBLineChartView.h"

@implementation TiJbchartModule


#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"27335bd3-8f5b-4ed8-afbe-4113ef13bdab";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"ti.jbchart";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];

	NSLog(@"[INFO] %@ loaded",self);
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably

	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup


#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

int const kBBAreaSmooth = 0;
int const kBBAreaDotted = 1;

MAKE_SYSTEM_UINT(CHART_LINE_SOLID, JBLineChartViewLineStyleSolid);
MAKE_SYSTEM_UINT(CHART_LINE_DASHED, JBLineChartViewLineStyleDashed);

MAKE_SYSTEM_UINT(CHART_AREA_SMOOTH, kBBAreaSmooth);
MAKE_SYSTEM_UINT(CHART_AREA_DOTTED, kBBAreaDotted);

@end
