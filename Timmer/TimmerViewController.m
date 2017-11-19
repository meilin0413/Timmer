//
//  TimmerViewController.m
//  Timmer
//
//  Created by mac on 11/19/17.
//  Copyright © 2017 Cisco. All rights reserved.
//

#import "TimmerViewController.h"

@interface TimmerViewController ()

@end

@implementation TimmerViewController

@synthesize time = _time;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}
- (void)dealloc
{
	[self stopTimer];
	
	[super dealloc];
}

- (void)loadView
{
	TimmerView *timmerView = [[TimmerView alloc] init];
	timmerView.timmerViewUpdateDelegate = self;
	[self setView:timmerView];
	
	[timmerView release];
}

#pragma mark - setter/getter

- (void)setTime:(NSInteger)time
{
	_time = time;
	
	TimmerView *timmerView = (TimmerView *)self.view;
	NSString *timeString = [self computeTimeString];

	[timmerView updateTimmerString:timeString];
}


#pragma mark - private method
- (void)startTimer
{
	_updateTimerString = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
}

- (void)stopTimer
{
	if (_updateTimerString)
	{
		[_updateTimerString invalidate];
		_updateTimerString = nil;
	}
}

- (void)updateTime
{
	self.time = _time + 1;
	
}

- (void)initTime
{
	self.time = 0;
}

- (NSString *)computeTimeString
{
	NSString *timeString = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",_time/3600,(_time/60)%60,_time%60];
	
	return timeString;
}

#pragma mark - TimmerViewUpdateDelegate
- (void)startTimmer
{
	[self startTimer];
}

- (void)pauseTimmer
{
	[self stopTimer];
}

- (void)stopTimmer
{
	[self stopTimer];
	[self initTime];
}
@end
