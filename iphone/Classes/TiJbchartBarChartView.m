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

#import "TiJbchartBarChartView.h"
#import "JBConstants.h"
@implementation TiJbchartBarChartView

NSUInteger kJBBarChartViewControllerBarPadding = 1;
CGFloat const kJBBarChartViewControllerChartHeaderPadding = 10.0f;
CGFloat const kJBBarAnimationDuration = 0.25f;

-(void)reloadData:(id)unused
{
    [self.barChart reloadData];
}

-(void)initializeState
{
	[super initializeState];
    _debug = NO;
    _defaultBarColor = [UIColor greenColor];
    _selectionBarColor = [UIColor whiteColor];
    _barCount = 1;
    _barPadding = kJBBarChartViewControllerBarPadding;
}

#pragma mark - Property Section

-(void)setData_:(id)value
{
	ENSURE_TYPE_OR_NIL(value,NSArray);
    self.chartData = [NSArray arrayWithArray:value];
    _barCount = [self.chartData count];
}

-(void)setToolTipData_:(id)value
{
	ENSURE_TYPE_OR_NIL(value,NSArray);
    self.tooltipData = [NSArray arrayWithArray:value];
}

-(void)setSelectionBarColor_:(id)color
{
    TiColor *newColor = [TiUtils colorValue:color];
	UIColor *clr = [newColor _color];
    _selectionBarColor = clr;
}

-(void)setBarColors_:(id)value
{
	ENSURE_TYPE_OR_NIL(value,NSArray);
    _barColors = [NSArray arrayWithArray:value];
}

-(void)setDefaultBarColor_:(id)color
{
    TiColor *newColor = [TiUtils colorValue:color];
	_defaultBarColor = [newColor _color];
}

-(void)setBarPadding_:(id)value
{
	ENSURE_TYPE_OR_NIL(value,NSNumber);
    _barPadding = [value floatValue];
}

#pragma mark - Helper Section

-(BOOL) hasToolTip:(NSUInteger)index
{
    if(_tooltipData == nil){
        if(_debug){
            NSLog(@"[DEBUG] No Tip Data");
        }
        return NO;
    }

    if(([_tooltipData count] == 0)||([_tooltipData count] < (index+1))){
        if(_debug){
            NSLog(@"[DEBUG] No Tip Data");
        }
        return NO;
    }

    if(_debug){
        NSLog(@"[DEBUG] Has Tip Data");
    }
    return YES;
}

-(UIColor *)findForColor:(NSUInteger)index withColorArray:(NSArray*)colorsToQuery withDefaultColor:(UIColor *) defColor
{
    if(colorsToQuery == nil){
        if(_debug){
            NSLog(@"[DEBUG] findForColor: No colors, default color returned index %d",index);
        }
        return defColor;
    }

    if(([colorsToQuery count] == 0)||([colorsToQuery count] < (index+1))){
        if(_debug){
            NSLog(@"[DEBUG] findForColor: Out of Range, default color returned index %d",index);
        }
        return defColor;
    }

    return [[TiUtils colorValue:[colorsToQuery objectAtIndex:index]] _color];
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
        [UIView animateWithDuration:kJBBarAnimationDuration animations:^{
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

#pragma mark - JBBarChartViewDelegate

- (CGFloat)barChartView:(JBBarChartView *)barChartView heightForBarViewAtAtIndex:(NSUInteger)index
{
    if([[self.chartData objectAtIndex:index] floatValue] < 0){
        return 0;
    }else{
        return [[self.chartData objectAtIndex:index] floatValue];
    }
}

- (UIColor *)barChartView:(JBBarChartView *)barChartView colorForBarViewAtIndex:(NSUInteger)index
{
    return [self findForColor:index withColorArray:_barColors withDefaultColor:_defaultBarColor];
}

- (UIColor *)barSelectionColorForBarChartView:(JBBarChartView *)barChartView
{
    return _selectionBarColor;
}

- (NSUInteger)barPaddingForBarChartView:(JBBarChartView *)barChartView
{
    return _barPadding;
}


#pragma mark - JBBarChartViewDataSource

- (NSUInteger)numberOfBarsInBarChartView:(JBBarChartView *)barChartView
{
    return _barCount;
}

- (void)barChartView:(JBBarChartView *)barChartView didSelectBarAtIndex:(NSUInteger)index touchPoint:(CGPoint)touchPoint
{
    if([self hasToolTip:index] == YES){
        [self setTooltipVisible:YES animated:YES atTouchPoint:touchPoint];
        [self.tooltipView setText:[[self.tooltipData objectAtIndex:index] uppercaseString]];
    }
    if ([self.proxy _hasListeners:@"selected"]) {
		NSDictionary *event = [NSDictionary dictionaryWithObjectsAndKeys:
                               [NSNumber numberWithInteger:index],@"columnIndex",
							   nil
							   ];

		[self.proxy fireEvent:@"selected" withObject:event];
	}
}

- (void)didDeselectBarChartView:(JBBarChartView *)barChartView
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


#pragma mark - Overrides

- (JBChartView *)chartView
{
    if (self.barChart==nil)
	{
        self.barChart = [[JBBarChartView alloc] initWithFrame:[self bounds]];
        self.barChart.delegate = self;
        self.barChart.dataSource = self;
        self.barChart.headerPadding =kJBBarChartViewControllerChartHeaderPadding;
        self.barChart.minimumValue = 0.0f;

        id backgroundColor = [self.proxy valueForUndefinedKey:@"chartBackgroundColor"];
        if(backgroundColor == nil){
            self.barChart.backgroundColor = [UIColor whiteColor];
        }else{
            TiColor *newColor = [TiUtils colorValue:backgroundColor];
            UIColor *clr = [newColor _color];
            self.barChart.backgroundColor = clr;
        }

		[self addSubview:self.barChart];
        [self.barChart reloadData];
	}

    return self.barChart;
}


-(void)frameSizeChanged:(CGRect)frame bounds:(CGRect)bounds
{
    [TiUtils setView:self.chartView positionRect:bounds];
    [self.chartView setState:JBChartViewStateExpanded];
}


@end
