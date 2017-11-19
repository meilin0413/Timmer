//
//  TimmerView.m
//  Timmer
//
//  Created by mac on 11/19/17.
//  Copyright © 2017 Cisco. All rights reserved.
//

#import "TimmerView.h"

#define VIEW_WIDTH					276
#define VIEW_HEIGHT					270
#define BUTTON_HEIGHT				32
#define BUTTON_WIDTH				32
#define STATETEXTFIELD_HEIGHT		19
#define TIMMERTEXTFIELD_HEIGHT		50
#define TEXTFIELD_WIDTH				276

#define BOTTOM_GAP					60
#define TEXTFIELD_BOTTOM_GAP		20

@implementation TimmerView

@synthesize state = _state;
@synthesize timmerString = _timmerString;
@synthesize timmerViewUpdateDelegate = _timmerViewUpdateDelegate;

#pragma mark - life cycle

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
	self.wantsLayer = YES;
	self.layer.borderWidth = 2.0f;
	self.layer.borderColor = [NSColor blueColor].CGColor;
	
	switch(_state)
	{
		case NonState:
			[self drawNonState];
			break;
		case InprocessState:
			[self drawInprocessState];
			break;
		case PauseState:
			[self drawPauseState];
			break;
		case StopState:
			[self drawStopProcess];
			break;
		default:
			break;
	}
}

- (id)init
{
	self = [super initWithFrame:NSMakeRect(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
	if (self)
	{
		[self initStopButton];
		[self initStartButton];
		[self initStateTextField];
		[self initTimmerTextField];
		[self layoutSubviews];
		[self setState:StopState];
	}
	return self;
}

- (void)dealloc
{
	[_timmerString release];
	_timmerString = nil;
	
	[_startBtn release];
	_startBtn = nil;
	
	[_stopButton release];
	_stopButton = nil;
	
	[_timmerTextField release];
	_timmerTextField = nil;
	
	[_stateTextField release];
	_stateTextField = nil;
	
	[super dealloc];
}

#pragma mark - pulic method

- (void)updateTimmerString:(NSString *)timeString
{
	[_timmerTextField setStringValue:timeString];
}

#pragma mark - setter/getter

- (void)setState:(RecordState)state
{
	if (_state == state)
		return;
	_state = state;
	[self setNeedsDisplay:YES];
}

- (void)setTimmerString:(NSString *)timmerString
{
	if (_timmerString)
	{
		[_timmerString release];
		_timmerString = nil;
	}
	_timmerString = [timmerString retain];
	[self drawTimmerTextField];
}
#pragma mark - private method

- (void)initStartButton
{
	if (!_startBtn)
	{
		_startBtn = [[NSButton alloc] initWithFrame:NSMakeRect(0, 0, BUTTON_WIDTH, BUTTON_HEIGHT)];
		_startBtn.title = @"Record";
		_startBtn.target = self;
		_startBtn.action = @selector(startRecording:);
		
		[self addSubview:_startBtn];
	}
}

- (void)initStopButton
{
	if (!_stopButton)
	{
		_stopButton = [[NSButton alloc] initWithFrame:NSMakeRect(0, 0, BUTTON_WIDTH, BUTTON_HEIGHT)];
		_stopButton.title = @"Stop";
		_stopButton.enabled = NO;
		_stopButton.target = self;
		_stopButton.action = @selector(stopRecording:);
		
		[self addSubview:_stopButton];
	}
}

- (void)initTimmerTextField
{
	if (!_timmerTextField)
	{
		_timmerTextField = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, TEXTFIELD_WIDTH, TIMMERTEXTFIELD_HEIGHT)];
		_timmerTextField.alignment = NSCenterTextAlignment;
		_timmerTextField.bordered = NO;
		_timmerTextField.editable = NO;
		[_timmerTextField setStringValue:@"00:00:00"];
		
		[self addSubview:_timmerTextField];
	}
}

- (void)initStateTextField
{
	if (!_stateTextField)
	{
		_stateTextField = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, TEXTFIELD_WIDTH, STATETEXTFIELD_HEIGHT)];
		_stateTextField.alignment = NSCenterTextAlignment;
		_stateTextField.bordered = NO;
		_stateTextField.editable = NO;
		[_stateTextField setStringValue:@"Click button to record on server"];
		
		[self addSubview:_stateTextField];
	}
}

- (void)drawNonState
{
	_timmerTextField.stringValue = @"00:00:00";
	_startBtn.enabled = NO;
	_stopButton.enabled = NO;
	_stateTextField.stringValue = @"Connecting to the recording server";
}

- (void)drawInprocessState
{
	_startBtn.title = @"Pause";
	_startBtn.enabled = YES;
	
	_stopButton.title = @"Stop";
	_stopButton.enabled = YES;
	
	_stateTextField.stringValue = @"Recording";
	
}

- (void)drawPauseState
{
	_startBtn.title = @"Record";
	_startBtn.enabled = YES;
	
	_stopButton.title = @"Stop";
	_stopButton.enabled = YES;
	
	_stateTextField.stringValue = @"Pause the recording";
}

- (void)drawStopProcess
{
	_timmerTextField.stringValue = @"00:00:00";
	_startBtn.enabled = YES;
	_startBtn.title = @"Record";
	
	_stopButton.title = @"Stop";
	_stopButton.enabled = NO;
	
	_stateTextField.stringValue = @"Click button to record on server";
}

- (void)drawTimmerTextField
{
	
}

- (void)drawStateTextField
{
	
}

- (void)layoutSubviews
{
	[self layoutStopBtn];
	[self layoutStartBtn];
	[self layoutStateTextField];
	[self layoutTimmerTextField];
}

- (void)layoutStartBtn
{
	NSPoint btnOrigin = NSZeroPoint;
	btnOrigin.x = [self frame].size.width/4 - [_startBtn frame].size.width/2;
	btnOrigin.y = BOTTOM_GAP;
	
	[_startBtn setFrameOrigin:btnOrigin];
}

- (void)layoutStopBtn
{
	NSPoint btnOrigin = NSZeroPoint;
	btnOrigin.x = [self frame].size.width/4 * 3 - [_stopButton frame].size.width/2;
	btnOrigin.y = BOTTOM_GAP;
	
	[_stopButton setFrameOrigin:btnOrigin];
}

- (void)layoutStateTextField
{
	NSPoint textFieldOrigin = NSZeroPoint;
	textFieldOrigin.x = [self frame].size.width/2 - [_stateTextField frame].size.width/2;
	textFieldOrigin.y = [self frame].size.height - [_stateTextField frame].size.height - 5;
	
	[_stateTextField setFrameOrigin:textFieldOrigin];
}

- (void)layoutTimmerTextField
{
	NSPoint textFieldOrigin = NSZeroPoint;
	textFieldOrigin.x = [self frame].size.width/2 - [_timmerTextField frame].size.width/2;
	textFieldOrigin.y = [self frame].size.height/2 + TEXTFIELD_BOTTOM_GAP;
	
	[_timmerTextField setFrameOrigin:textFieldOrigin];
}

#pragma mark - UI action

- (void)startRecording:(id)sender
{
	if (_state == StopState)
	{
		self.state = InprocessState;
		if (_timmerViewUpdateDelegate && [_timmerViewUpdateDelegate respondsToSelector:@selector(startTimmer)])
		{
			[_timmerViewUpdateDelegate startTimmer];
		}
		return;
	}
	if (_state == InprocessState)
	{
		self.state = PauseState;
		if (_timmerViewUpdateDelegate && [_timmerViewUpdateDelegate respondsToSelector:@selector(pauseTimmer)])
		{
			[_timmerViewUpdateDelegate pauseTimmer];
		}
		return;
	}
	if (_state == PauseState)
	{
		self.state = InprocessState;
		if (_timmerViewUpdateDelegate && [_timmerViewUpdateDelegate respondsToSelector:@selector(startTimmer)])
		{
			[_timmerViewUpdateDelegate startTimmer];
		}
		return;
	}
}

- (void)stopRecording:(id)sender
{
	self.state = StopState;
	if (_timmerViewUpdateDelegate && [_timmerViewUpdateDelegate respondsToSelector:@selector(stopTimmer)])
	{
		[_timmerViewUpdateDelegate stopTimmer];
	}
}
@end
