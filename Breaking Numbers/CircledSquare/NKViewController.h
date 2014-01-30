//
//  NKViewController.h
//  CircledSquare
//
//  Created by Nikita Kolmogorov on 28/01/14.
//  Copyright (c) 2014 Nikita Kolmogorov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

@interface NKViewController : NSObject

@property (weak) IBOutlet NSTextField *textField;
@property (weak) IBOutlet WebView *resultWebView;

- (IBAction)showNumbersPressed:(NSButton *)sender;

@end
