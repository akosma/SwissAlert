//
//  SwissAlertAppDelegate.m
//  SwissAlert
//
//  Created by Adrian on 7/30/09.
//  Copyright akosma software 2009. All rights reserved.
//

#import "SwissAlertAppDelegate.h"
#import "MainController.h"

@implementation SwissAlertAppDelegate

#pragma mark -
#pragma mark UIApplicationDelegate methods

- (void)applicationDidFinishLaunching:(UIApplication *)application 
{
    [_window addSubview:_mainController.view];
    [_window makeKeyAndVisible];
}

#pragma mark -
#pragma mark dealloc method

- (void)dealloc 
{
    [super dealloc];
}

#pragma mark -
#pragma mark IBAction methods

- (IBAction)about:(id)sender
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.75];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft 
                           forView:_window 
                             cache:YES];
    
    [_mainController.view removeFromSuperview];
    [_window addSubview:_aboutController.view];
    
    [UIView commitAnimations];    
}

- (IBAction)back:(id)sender
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.75];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight
                           forView:_window 
                             cache:YES];
    
    [_aboutController.view removeFromSuperview];
    [_window addSubview:_mainController.view];
    
    [UIView commitAnimations];    
}

- (IBAction)akosma:(id)sender
{
    NSURL *url = [NSURL URLWithString:@"http://akosma.com/"];
    [[UIApplication sharedApplication] openURL:url];
}

@end
