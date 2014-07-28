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

#import "TiJbchartBarChartViewProxy.h"
#import "TiUtils.h"
#import "TiJbchartBarChartView.h"

@implementation TiJbchartBarChartViewProxy

-(NSArray *)keySequence
{
    return [NSArray arrayWithObjects:
            @"data",
            @"toolTipData",
            @"selectionBarColor",
            @"barColors",
            @"barPadding",
            nil];
}

-(void)reloadData:(id)unused
{
  	if ([self viewAttached])
	{
		TiThreadPerformOnMainThread(^{[(TiJbchartBarChartView*)[self view] reloadData:unused];}, NO);
	}
}

@end
