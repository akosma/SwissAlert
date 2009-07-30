//
//  SwissAlertAppDelegate.h
//  SwissAlert
//
//  Created by Adrian on 7/30/09.
//  Copyright akosma software 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainController;

@interface SwissAlertAppDelegate : NSObject <UIApplicationDelegate> 
{
@private
    IBOutlet UIWindow *_window;
    IBOutlet MainController *_mainController;
    IBOutlet UIViewController *_aboutController;
}

- (IBAction)about:(id)sender;
- (IBAction)back:(id)sender;
- (IBAction)akosma:(id)sender;

@end
