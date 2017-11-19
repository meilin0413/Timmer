//
//  TimmerView.h
//  Timmer
//
//  Created by mac on 11/19/17.
//  Copyright © 2017 Cisco. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef enum
{
	NonState = 0,
	InprocessState,
	PauseState,
	StopState
}RecordState;

@protocol TimmerViewUpdateDelegate <NSObject>

- (void)startTimmer;
- (void)pauseTimmer;
- (void)stopTimmer;

@end

@interface TimmerView : NSView
{
	NSTextField *_stateTextField;
	NSTextField *_timmerTextField;
	NSButton *_startBtn;
	NSButton *_stopButton;
	
	RecordState _state;
	NSString *_timmerString;
	id<TimmerViewUpdateDelegate> _timmerViewUpdateDelegate;
}

@property (nonatomic, assign) RecordState state;
@property (nonatomic, retain) NSString *timmerString;
@property (nonatomic, assign) id<TimmerViewUpdateDelegate> timmerViewUpdateDelegate;

- (void)updateTimmerString:(NSString *)timeString;
@end
