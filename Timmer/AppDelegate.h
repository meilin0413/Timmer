//
//  AppDelegate.h
//  Timmer
//
//  Created by mac on 11/19/17.
//  Copyright © 2017 Cisco. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TimmerViewController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
	TimmerViewController *_timmerViewContrl;
}

@property(nonatomic, retain) TimmerViewController *timmerViewContrl;
@end

