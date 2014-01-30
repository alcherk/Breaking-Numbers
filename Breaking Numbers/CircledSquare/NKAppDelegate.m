//
//  NKAppDelegate.m
//  CircledSquare
//
//  Created by Nikita Kolmogorov on 28/01/14.
//  Copyright (c) 2014 Nikita Kolmogorov. All rights reserved.
//

#import "NKAppDelegate.h"

@implementation NKAppDelegate

- (BOOL) applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)application
{
    // Just close the app when there are no opened windows
    return YES;
}

@end
