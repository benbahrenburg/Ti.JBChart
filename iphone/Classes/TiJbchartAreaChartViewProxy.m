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

#import "TiJbchartAreaChartViewProxy.h"
#import "TiUtils.h"
#import "TiJbchartAreaChartView.h"
@implementation TiJbchartAreaChartViewProxy

-(NSArray *)keySequence
{
    return [NSArray arrayWithObjects:
            @"data",
            @"toolTipData",
            @"selectionBarColor",
            @"selectionFillColor",
            @"selectedLineColor",
            @"barWidth",
            @"lineColor",
            @"fillColor",
            @"areaStyles",
            nil];
}

-(void)reloadData:(id)unused
{
  	if ([self viewAttached])
	{
		TiThreadPerformOnMainThread(^{[(TiJbchartAreaChartView*)[self view] reloadData:unused];}, NO);
	}
}
@end
