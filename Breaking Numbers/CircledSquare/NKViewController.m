//
//  NKViewController.m
//  CircledSquare
//
//  Created by Nikita Kolmogorov on 28/01/14.
//  Copyright (c) 2014 Nikita Kolmogorov. All rights reserved.
//

/* There are couple of things to point out:
 - I used WebView instead of NSTextView because it allows us to build HTML tables
 - I decided to make a dummy array of capacity [side][side] - usual way to represent a square
 - The app consequently puts numbers from 1 to side*side by building smaller and smaller rectangles untill the center is faced
 */

#import "NKViewController.h"

@implementation NKViewController

#pragma mark - View Controller life cycle -

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // Hide WebView background
    self.resultWebView.drawsBackground = NO;
}

#pragma mark - Buttons methods -

- (IBAction)showNumbersPressed:(NSButton *)sender
{
    // Get the number
    int number = [self.textField intValue];
    
    // Print error message if it is not even a number, or 0
    if (!number) {
        [self printErrorMessage];
        return;
    }
    
    // Reset WebView text
    [self.resultWebView.mainFrame loadHTMLString:@"" baseURL:nil];
    
    // Get array of numbers
    NSArray *result = [self getNumbersArrayForSide:number];
    
    // Print this array
    [self printResult:result];
}

#pragma mark - General methods -

/**
 *  Method to print error message to WebView
 */
- (void)printErrorMessage
{
    // A simple css to set font and it's size
    NSString *css = @"<style>*{font-size:17px; font-family:\"Helvetica\";}</style>";
    // Make a string with error message and css
    NSString *result = [css stringByAppendingString:@"Don't try to fool me! I am the Danger!"];
    // Show error message in WebView
    [self.resultWebView.mainFrame loadHTMLString:result baseURL:nil];
}

/**
 *  Method to get array with arrays of numbers to use for printing a square afterwards
 *
 *  @param side Required side of the square
 *
 *  @return Array of arrays of numbers like [[1,2,3],[8,9,4],[7,6,5]]
 */
- (NSArray *)getNumbersArrayForSide:(int)side
{
    // Prepare a dummy for a resulting array
    NSMutableArray *result = [NSMutableArray array];
    
    // Fill dummy array with enough dummy arrays with enough dummy values (nulls)
    for (int i = 0; i < side; i++) {
        NSMutableArray *temp = [NSMutableArray array];
        for (int j = 0; j < side; j++)
            [temp addObject:[NSNull null]];
        [result addObject:temp];
    }
    
    // Current side of a square that we a drawing
    int currentSide = side;
    // Current offset for a square that we are drawing
    int offset = 0;
    int currentNumber = 1;
    
    // Repeat drawing a new square untill the app faces center
    while (offset < (side/2.0)) {
        // Draw upper line
        for (int i = 0; i < currentSide; i++) {
            result[offset][offset+i] = @(currentNumber);
            currentNumber++;
        }
        
        // Draw right line
        for (int i = 0; i < currentSide-2; i++) {
            result[1+offset+i][side-1-offset] = @(currentNumber);
            currentNumber++;
        }

        // Draw bottom line
        if (side/2 - offset > 0) {
            for (int i = 0; i < currentSide; i++) {
                result[side-1-offset][side-1-i-offset] = @(currentNumber);
                currentNumber++;
            }
        }

        // Draw left line
        for (int i = 0; i < currentSide-2; i++) {
            result[side-2-offset-i][offset] = @(currentNumber);
            currentNumber++;
        }
        
        // Increment offset and decrease current side by 2
        offset++;
        currentSide-=2;
    }
    
    return result;
}

/**
 *  Method to print array of numbers to WebView
 *
 *  @param result Array of numbers to print
 */
- (void)printResult:(NSArray *)result
{
    // Build a simple css with font, size and table text alignment
    NSString *css = @"<style>*{font-size:17px; font-family:\"Helvetica\";}  td{text-align:center;}</style>";
    
    // Build string with previous css and start table
    NSMutableString *resultString = [NSMutableString stringWithFormat:@"%@<table>",css];
    
    // Iterate over the main array (of arrays)
    for (NSArray *inner in result) {
        // Start row in a table
        [resultString appendString:@"<tr>"];
        
        // Iterate over inner array of numbers
        for (NSNumber *number in inner) {
            // Start column in a row
            [resultString appendString:@"<td>"];
            
            // Print the number
            [resultString appendString:[number stringValue]];
            
            // End column in a row
            [resultString appendString:@"</td>"];
        }
        
        // End row in a table
        [resultString appendString:@"</tr>"];
    }
    
    // End table
    [resultString appendString:@"</table>"];
    
    // Show HTML string in WebView
    [self.resultWebView.mainFrame loadHTMLString:resultString baseURL:nil];
}

@end
