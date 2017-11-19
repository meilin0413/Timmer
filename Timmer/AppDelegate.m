//
//  AppDelegate.m
//  Timmer
//
//  Created by mac on 11/19/17.
//  Copyright © 2017 Cisco. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (assign) IBOutlet NSWindow *window;
@end

@implementation AppDelegate
@synthesize timmerViewContrl = _timmerViewContrl;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application
	[self.window setBackgroundColor:[NSColor whiteColor]];
	
	[self.window.contentView addSubview:self.timmerViewContrl.view];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
	// Insert code here to tear down your application
}

- (void)dealloc
{
	if (_timmerViewContrl)
	{
		[_timmerViewContrl release];
		_timmerViewContrl = nil;
	}
	
	[super dealloc];
}

#pragma mark - setter/getter

- (TimmerViewController *)timmerViewContrl
{
	if (!_timmerViewContrl)
	{
		_timmerViewContrl = [[TimmerViewController alloc] init];
	}
	return _timmerViewContrl;
}

@end
