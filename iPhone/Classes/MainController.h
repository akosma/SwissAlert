//
//  MainController.h
//  SwissAlert
//
//  Created by Adrian on 7/30/09.
//  Copyright 2009 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h>

@interface MainController : UIViewController <ABPeoplePickerNavigationControllerDelegate>
{
@private
    IBOutlet UIButton *_policeButton;
    IBOutlet UIButton *_fireButton;
    IBOutlet UIButton *_ambulanceButton;
    
    IBOutlet UIButton *_airGlaciersButton;
    IBOutlet UIButton *_regaButton;
    IBOutlet UIButton *_tcsButton;
    
    IBOutlet UIButton *_mainTendueButton;
    IBOutlet UIButton *_proJuventuteButton;
    IBOutlet UIButton *_toxButton;
    
    IBOutlet UIButton *_customButton1;
    IBOutlet UIButton *_customButton2;
    IBOutlet UIButton *_customButton3;
    
    NSUserDefaults *_defaults;

    ABPeoplePickerNavigationController *_peoplePicker;
    NSString *_selectedPhone;
    UIButton *_currentButton;
    NSString *_firstName;
    NSString *_lastName;
    UIImage *_image;
}

- (IBAction)call:(id)sender;
- (IBAction)clearPreferences:(id)sender;

@end
