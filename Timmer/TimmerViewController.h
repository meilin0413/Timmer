//
//  TimmerViewController.h
//  Timmer
//
//  Created by mac on 11/19/17.
//  Copyright © 2017 Cisco. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TimmerView.h"

@interface TimmerViewController : NSViewController <TimmerViewUpdateDelegate>
{
	NSTimer *_updateTimerString;
	NSInteger _time;
}

@property(nonatomic,assign) NSInteger time;

@end
