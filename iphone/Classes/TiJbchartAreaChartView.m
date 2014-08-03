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

#import "TiJbchartAreaChartView.h"
#import "JBConstants.h"
#import "TiJbchartModule.h"

@implementation TiJbchartAreaChartView

// Numerics
CGFloat const kJBAreaChartViewControllerChartHeaderPadding = 20.0f;
CGFloat const kJBAreaChartViewControllerChartLineWidth = 2.0f;
CGFloat const kJBAreaAnimationDuration = 0.25f;


-(void)reloadData:(id)unused
{
    [self.lineChart reloadData];
}

-(void)initializeState
{
	[super initializeState];
    _selectionBarColor = [UIColor whiteColor];
    _barWidth = kJBAreaChartViewControllerChartLineWidth;
}

#pragma mark - Property Section

-(void)setBarWidth_:(id)value
{
	ENSURE_TYPE_OR_NIL(value,NSNumber);
    _barWidth = [value floatValue];
}

-(void)setSelectionBarColor_:(id)color
{
    TiColor *newColor = [TiUtils colorValue:color];
	UIColor *clr = [newColor _color];
    _selectionBarColor = clr;
}

-(void)setData_:(id)value
{
	ENSURE_TYPE_OR_NIL(value,NSArray);
    _chartData = [NSArray arrayWithArray:value];
}

-(void)setToolTipData_:(id)value
{
	ENSURE_TYPE_OR_NIL(value,NSArray);
    _tooltipData = [NSArray arrayWithArray:value];
}

-(void)setSelectedLineColor_:(id)value
{
	ENSURE_TYPE_OR_NIL(value,NSArray);
    _selectionColorForLineColors = [NSArray arrayWithArray:value];
}

-(void)setSelectedFillColor_:(id)value
{
	ENSURE_TYPE_OR_NIL(value,NSArray);
    _selectionColorForFillColors = [NSArray arrayWithArray:value];
}

-(void)setLineColor_:(id)value
{
	ENSURE_TYPE_OR_NIL(value,NSArray);
    _colorForLineColors = [NSArray arrayWithArray:value];
}

-(void)setFillColor_:(id)value
{
	ENSURE_TYPE_OR_NIL(value,NSArray);
    _colorForFillColors = [NSArray arrayWithArray:value];
}

-(void)setAreaStyles_:(id)value
{
	ENSURE_TYPE_OR_NIL(value,NSArray);
    _areaStyles = [NSArray arrayWithArray:value];
}

#pragma mark - Helper Section

-(UIColor *)findForColor:(NSUInteger)index withColorArray:(NSArray*)colorsToQuery withDefaultColor:(UIColor *) defColor
{
    if(colorsToQuery == nil){
        return defColor;
    }

    if(([colorsToQuery count] == 0)||([colorsToQuery count] < (index+1))){
        return defColor;
    }

    return [[TiUtils colorValue:[colorsToQuery objectAtIndex:index]] _color];
}

-(NSInteger)findStyle:(NSUInteger)index
{
    if(_areaStyles == nil){
        return kBBAreaSmooth;
    }

    if(([_areaStyles count] == 0)||([_areaStyles count] < (index+1))){
        return kBBAreaSmooth;
    }

    return [TiUtils floatValue:[_areaStyles objectAtIndex:index]];
}

-(BOOL) hasToolTip:(NSUInteger)index
{
    if(_tooltipData == nil){
        return NO;
    }

    if(([_tooltipData count] == 0)||([_tooltipData count] < (index+1))){
        return NO;
    }

    return YES;
}

#pragma mark - Tooltip Section

- (void)setTooltipVisible:(BOOL)tooltipVisible animated:(BOOL)animated atTouchPoint:(CGPoint)touchPoint
{
    _tooltipVisible = tooltipVisible;

    JBChartView *chartView = [self chartView];

    if (!chartView)
    {
        return;
    }

    if (!self.tooltipView)
    {
        self.tooltipView = [[JBChartTooltipView alloc] init];
        self.tooltipView.alpha = 0.0;
        [self addSubview:self.tooltipView];
    }

    if (!self.tooltipTipView)
    {
        self.tooltipTipView = [[JBChartTooltipTipView alloc] init];
        self.tooltipTipView.alpha = 0.0;
        [self addSubview:self.tooltipTipView];
    }

    dispatch_block_t adjustTooltipPosition = ^{

        CGPoint originalTouchPoint = [self convertPoint:touchPoint fromView:chartView];
        CGPoint convertedTouchPoint = originalTouchPoint; // modified
        JBChartView *chartView = [self chartView];
        if (chartView)
        {
            CGFloat minChartX = (chartView.frame.origin.x + ceil(self.tooltipView.frame.size.width * 0.5));
            if (convertedTouchPoint.x < minChartX)
            {
                convertedTouchPoint.x = minChartX;
            }
            CGFloat maxChartX = (chartView.frame.origin.x + chartView.frame.size.width - ceil(self.tooltipView.frame.size.width * 0.5));
            if (convertedTouchPoint.x > maxChartX)
            {
                convertedTouchPoint.x = maxChartX;
            }
            self.tooltipView.frame = CGRectMake(convertedTouchPoint.x - ceil(self.tooltipView.frame.size.width * 0.5), CGRectGetMaxY(chartView.headerView.frame), self.tooltipView.frame.size.width, self.tooltipView.frame.size.height);

            CGFloat minTipX = (chartView.frame.origin.x + self.tooltipTipView.frame.size.width);
            if (originalTouchPoint.x < minTipX)
            {
                originalTouchPoint.x = minTipX;
            }
            CGFloat maxTipX = (chartView.frame.origin.x + chartView.frame.size.width - self.tooltipTipView.frame.size.width);
            if (originalTouchPoint.x > maxTipX)
            {
                originalTouchPoint.x = maxTipX;
            }
            self.tooltipTipView.frame = CGRectMake(originalTouchPoint.x - ceil(self.tooltipTipView.frame.size.width * 0.5), CGRectGetMaxY(self.tooltipView.frame), self.tooltipTipView.frame.size.width, self.tooltipTipView.frame.size.height);
        }
    };

    dispatch_block_t adjustTooltipVisibility = ^{
        self.tooltipView.alpha = _tooltipVisible ? 1.0 : 0.0;
        self.tooltipTipView.alpha = _tooltipVisible ? 1.0 : 0.0;
	};

    if (tooltipVisible)
    {
        adjustTooltipPosition();
    }

    if (animated)
    {
        [UIView animateWithDuration:kJBAreaAnimationDuration animations:^{
            adjustTooltipVisibility();
        } completion:^(BOOL finished) {
            if (!tooltipVisible)
            {
                adjustTooltipPosition();
            }
        }];
    }
    else
    {
        adjustTooltipVisibility();
    }
}

- (void)setTooltipVisible:(BOOL)tooltipVisible animated:(BOOL)animated
{
    [self setTooltipVisible:tooltipVisible animated:animated atTouchPoint:CGPointZero];
}

- (void)setTooltipVisible:(BOOL)tooltipVisible
{
    [self setTooltipVisible:tooltipVisible animated:NO];
}

#pragma mark - JBLineChartViewDelegate

- (CGFloat)lineChartView:(JBLineChartView *)lineChartView verticalValueForHorizontalIndex:(NSUInteger)horizontalIndex atLineIndex:(NSUInteger)lineIndex
{
    return [[[self.chartData objectAtIndex:lineIndex] objectAtIndex:horizontalIndex] floatValue];
}

- (void)lineChartView:(JBLineChartView *)lineChartView didSelectLineAtIndex:(NSUInteger)lineIndex horizontalIndex:(NSUInteger)horizontalIndex touchPoint:(CGPoint)touchPoint
{
    if([self hasToolTip:horizontalIndex] == YES){
        [self setTooltipVisible:YES animated:YES atTouchPoint:touchPoint];
        [self.tooltipView setText:[[self.tooltipData objectAtIndex:horizontalIndex] uppercaseString]];
    }

    if ([self.proxy _hasListeners:@"selected"]) {
		NSDictionary *event = [NSDictionary dictionaryWithObjectsAndKeys:
							   [NSNumber numberWithInteger:lineIndex],@"dataIndex",
                               [NSNumber numberWithInteger:horizontalIndex],@"columnIndex",
							   nil
							   ];

		[self.proxy fireEvent:@"selected" withObject:event];
	}
}

- (void)didDeselectLineInLineChartView:(JBLineChartView *)lineChartView
{
    [self setTooltipVisible:NO animated:YES];
    if ([self.proxy _hasListeners:@"unselected"]) {
		NSDictionary *event = [NSDictionary dictionaryWithObjectsAndKeys:
                               NUMBOOL(YES),@"success",
							   nil
							   ];
		[self.proxy fireEvent:@"unselected" withObject:event];
	}
}

#pragma mark - JBLineChartViewDataSource

- (NSUInteger)numberOfLinesInLineChartView:(JBLineChartView *)lineChartView
{
    return [self.chartData count];
}

- (NSUInteger)lineChartView:(JBLineChartView *)lineChartView numberOfVerticalValuesAtLineIndex:(NSUInteger)lineIndex
{
    return [[self.chartData objectAtIndex:lineIndex] count];
}

- (UIColor *)lineChartView:(JBLineChartView *)lineChartView colorForLineAtLineIndex:(NSUInteger)lineIndex
{
    return [self findForColor:lineIndex withColorArray:_colorForLineColors withDefaultColor:kJBColorAreaChartDefaultSunLineColor];
}

- (UIColor *)lineChartView:(JBLineChartView *)lineChartView fillColorForLineAtLineIndex:(NSUInteger)lineIndex
{
    return [self findForColor:lineIndex withColorArray:_colorForFillColors withDefaultColor:kJBColorAreaChartDefaultSunAreaColor];
}

- (UIColor *)lineChartView:(JBLineChartView *)lineChartView colorForDotAtHorizontalIndex:(NSUInteger)horizontalIndex atLineIndex:(NSUInteger)lineIndex
{
    return kJBColorAreaChartDefaultSunLineColor;
}

- (CGFloat)lineChartView:(JBLineChartView *)lineChartView widthForLineAtLineIndex:(NSUInteger)lineIndex
{
    return kJBAreaChartViewControllerChartLineWidth;
}

- (UIColor *)verticalSelectionColorForLineChartView:(JBLineChartView *)lineChartView
{
    return _selectionBarColor;
}

- (UIColor *)lineChartView:(JBLineChartView *)lineChartView selectionColorForLineAtLineIndex:(NSUInteger)lineIndex
{
    return [self findForColor:lineIndex withColorArray:_selectionColorForLineColors withDefaultColor:kJBColorAreaChartDefaultSunSelectedLineColor];
}

- (UIColor *)lineChartView:(JBLineChartView *)lineChartView selectionFillColorForLineAtLineIndex:(NSUInteger)lineIndex
{
    return [self findForColor:lineIndex withColorArray:_selectionColorForFillColors withDefaultColor:kJBColorAreaChartDefaultSunSelectedAreaColor];
}

- (UIColor *)lineChartView:(JBLineChartView *)lineChartView selectionColorForDotAtHorizontalIndex:(NSUInteger)horizontalIndex atLineIndex:(NSUInteger)lineIndex
{
    return [self findForColor:lineIndex withColorArray:_selectionColorForFillColors withDefaultColor:kJBColorAreaChartDefaultSunSelectedAreaColor];
}

- (JBLineChartViewLineStyle)lineChartView:(JBLineChartView *)lineChartView lineStyleForLineAtLineIndex:(NSUInteger)lineIndex
{
    return [self findStyle:lineIndex];
}

- (BOOL)lineChartView:(JBLineChartView *)lineChartView showsDotsForLineAtLineIndex:(NSUInteger)lineIndex
{
    return ([self findStyle:lineIndex] == kBBAreaDotted);
}

- (BOOL)lineChartView:(JBLineChartView *)lineChartView smoothLineAtLineIndex:(NSUInteger)lineIndex
{
    return ([self findStyle:lineIndex] == kBBAreaSmooth);
}

#pragma mark - Overrides

- (JBChartView *)chartView
{
    if (self.lineChart==nil)
	{
        self.lineChart = [[JBLineChartView alloc] initWithFrame:[self bounds]];
        self.lineChart.delegate = self;
        self.lineChart.dataSource = self;
        self.lineChart.headerPadding =kJBAreaChartViewControllerChartHeaderPadding;

        id backgroundColor = [self.proxy valueForUndefinedKey:@"chartBackgroundColor"];
        if(backgroundColor == nil){
             self.lineChart.backgroundColor = kJBColorLineChartBackground;
        }else{
            TiColor *newColor = [TiUtils colorValue:backgroundColor];
            UIColor *clr = [newColor _color];
             self.lineChart.backgroundColor = clr;
        }

		[self addSubview:self.lineChart];
        [self.lineChart reloadData];
	}

    return self.lineChart;
}

-(void)frameSizeChanged:(CGRect)frame bounds:(CGRect)bounds
{
    [TiUtils setView:self.chartView positionRect:bounds];
}

@end
