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

#import "TiUIView.h"
#import "JBChartTooltipView.h"
#import "JBChartTooltipTipView.h"
#import "JBBarChartView.h"

@interface TiJbchartBarChartView : TiUIView<JBBarChartViewDelegate, JBBarChartViewDataSource>{
@private
    UIColor * _selectionBarColor;
    float _barCount;
    float _barPadding;
    BOOL _debug;
}

@property (nonatomic, strong) JBChartTooltipView *tooltipView;
@property (nonatomic, strong) JBChartTooltipTipView *tooltipTipView;
@property (nonatomic, assign) BOOL tooltipVisible;
@property (nonatomic, strong) JBBarChartView * barChart;
@property (nonatomic, strong) NSArray *chartData;
@property (nonatomic, strong) NSArray *tooltipData;

@property (nonatomic, strong) NSArray *barColors;

-(void)reloadData:(id)unused;

@end
