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
#import "JBLineChartView.h"
#import "JBChartTooltipView.h"
#import "JBChartTooltipTipView.h"

@interface TiJbchartAreaChartView : TiUIView<JBLineChartViewDelegate, JBLineChartViewDataSource> {
@private
    UIColor * _selectionBarColor;
    CGFloat _barWidth;
}
@property (nonatomic, strong) JBChartTooltipView *tooltipView;
@property (nonatomic, strong) JBChartTooltipTipView *tooltipTipView;
@property (nonatomic, assign) BOOL tooltipVisible;
@property (nonatomic, strong) JBLineChartView * lineChart;
@property (nonatomic, strong) NSArray *chartData;
@property (nonatomic, strong) NSArray *tooltipData;
@property (nonatomic, strong) NSArray *selectionColorForLineColors;
@property (nonatomic, strong) NSArray *selectionColorForFillColors;

@property (nonatomic, strong) NSArray *colorForLineColors;
@property (nonatomic, strong) NSArray *colorForFillColors;
@property (nonatomic, strong) NSArray *areaStyles;

-(void)reloadData:(id)unused;

@end
