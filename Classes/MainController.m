//
//  MainController.m
//  SwissAlert
//
//  Created by Adrian on 7/30/09.
//  Copyright 2009 akosma software. All rights reserved.
//

#import "MainController.h"

#define BUTTON_HAS_NUMBER_1 @"BUTTON_HAS_NUMBER_1"
#define BUTTON_HAS_NUMBER_2 @"BUTTON_HAS_NUMBER_2"
#define BUTTON_HAS_NUMBER_3 @"BUTTON_HAS_NUMBER_3"

#define BUTTON_HAS_IMAGE_1 @"BUTTON_HAS_IMAGE_1"
#define BUTTON_HAS_IMAGE_2 @"BUTTON_HAS_IMAGE_2"
#define BUTTON_HAS_IMAGE_3 @"BUTTON_HAS_IMAGE_3"

#define NUMBER_FOR_BUTTON_1 @"NUMBER_FOR_BUTTON_1"
#define NUMBER_FOR_BUTTON_2 @"NUMBER_FOR_BUTTON_2"
#define NUMBER_FOR_BUTTON_3 @"NUMBER_FOR_BUTTON_3"

#define TITLE_FOR_BUTTON_1 @"TITLE_FOR_BUTTON_1"
#define TITLE_FOR_BUTTON_2 @"TITLE_FOR_BUTTON_2"
#define TITLE_FOR_BUTTON_3 @"TITLE_FOR_BUTTON_3"

#define IMAGE_FOR_BUTTON_1 @"IMAGE_FOR_BUTTON_1"
#define IMAGE_FOR_BUTTON_2 @"IMAGE_FOR_BUTTON_2"
#define IMAGE_FOR_BUTTON_3 @"IMAGE_FOR_BUTTON_3"

// Adapted from
// http://discussions.apple.com/thread.jspa?messageID=8318238
static void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth, float ovalHeight)
{
    float fw, fh;
    if (ovalWidth == 0 || ovalHeight == 0) {
        CGContextAddRect(context, rect);
        return;
    }
    CGContextSaveGState(context);
    CGContextTranslateCTM (context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM (context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth (rect) / ovalWidth;
    fh = CGRectGetHeight (rect) / ovalHeight;
    CGContextMoveToPoint(context, fw, fh/2);
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1);
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1);
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

@interface MainController (Private)
- (void)showPeoplePicker;
- (void)roundCornersOfImage;
@end

@implementation MainController

#pragma mark -
#pragma mark dealloc method

- (void)dealloc 
{
    [_image release];
    [_firstName release];
    [_lastName release];
    [_selectedPhone release];
    [_peoplePicker release];
    [super dealloc];
}

#pragma mark -
#pragma mark IBAction methods

- (IBAction)call:(id)sender
{
    if (sender == _policeButton)
    {
        NSURL *url = [NSURL URLWithString:@"tel:117"];
        [[UIApplication sharedApplication] openURL:url];
    }
    else if (sender == _fireButton)
    {
        NSURL *url = [NSURL URLWithString:@"tel:118"];
        [[UIApplication sharedApplication] openURL:url];
    }
    else if (sender == _ambulanceButton)
    {
        NSURL *url = [NSURL URLWithString:@"tel:144"];
        [[UIApplication sharedApplication] openURL:url];
    }
    else if (sender == _regaButton)
    {
        NSURL *url = [NSURL URLWithString:@"tel:1414"];
        [[UIApplication sharedApplication] openURL:url];
    }
    else if (sender == _airGlaciersButton)
    {
        NSURL *url = [NSURL URLWithString:@"tel:1415"];
        [[UIApplication sharedApplication] openURL:url];
    }
    else if (sender == _tcsButton)
    {
        NSURL *url = [NSURL URLWithString:@"tel:140"];
        [[UIApplication sharedApplication] openURL:url];
    }
    else if (sender == _mainTendueButton)
    {
        NSURL *url = [NSURL URLWithString:@"tel:143"];
        [[UIApplication sharedApplication] openURL:url];
    }
    else if (sender == _proJuventuteButton)
    {
        NSURL *url = [NSURL URLWithString:@"tel:147"];
        [[UIApplication sharedApplication] openURL:url];
    }
    else if (sender == _toxButton)
    {
        NSURL *url = [NSURL URLWithString:@"tel:145"];
        [[UIApplication sharedApplication] openURL:url];
    }
    else 
    {
        // Custom buttons; if they have assigned numbers, call them
        // otherwise present the people picker and let them choose a number;
        // The _peoplePicker of the selected person appears in the button, if any
        
        _currentButton = sender;
        NSString *test = nil;
        NSString *key = nil;

        if (sender == _customButton1)
        {
            test = BUTTON_HAS_NUMBER_1;
            key = NUMBER_FOR_BUTTON_1;
        }
        else if (sender == _customButton2)
        {
            test = BUTTON_HAS_NUMBER_2;
            key = NUMBER_FOR_BUTTON_2;
        }
        else if (sender == _customButton3)
        {
            test = BUTTON_HAS_NUMBER_3;
            key = NUMBER_FOR_BUTTON_3;
        }
        if ([_defaults boolForKey:test])
        {
            NSString *number = [NSString stringWithFormat:@"tel:%@", [_defaults stringForKey:key]];
            NSURL *url = [NSURL URLWithString:number];
            [[UIApplication sharedApplication] openURL:url];
        }
        else 
        {
            [self showPeoplePicker];
        }        
    }
}

- (IBAction)clearPreferences:(id)sender
{
    [_defaults setBool:NO forKey:BUTTON_HAS_NUMBER_1];
    [_defaults setBool:NO forKey:BUTTON_HAS_NUMBER_2];
    [_defaults setBool:NO forKey:BUTTON_HAS_NUMBER_3];
    [_defaults setBool:NO forKey:BUTTON_HAS_IMAGE_1];
    [_defaults setBool:NO forKey:BUTTON_HAS_IMAGE_2];
    [_defaults setBool:NO forKey:BUTTON_HAS_IMAGE_3];
    [_defaults setObject:nil forKey:NUMBER_FOR_BUTTON_1];
    [_defaults setObject:nil forKey:NUMBER_FOR_BUTTON_2];
    [_defaults setObject:nil forKey:NUMBER_FOR_BUTTON_3];
    [_defaults setObject:nil forKey:TITLE_FOR_BUTTON_1];
    [_defaults setObject:nil forKey:TITLE_FOR_BUTTON_2];
    [_defaults setObject:nil forKey:TITLE_FOR_BUTTON_3];
    [_defaults setObject:nil forKey:IMAGE_FOR_BUTTON_1];
    [_defaults setObject:nil forKey:IMAGE_FOR_BUTTON_2];
    [_defaults setObject:nil forKey:IMAGE_FOR_BUTTON_3];
    
    [_customButton1 setTitle:nil forState:UIControlStateNormal];
    [_customButton1 setBackgroundImage:nil forState:UIControlStateNormal];
    [_customButton2 setTitle:nil forState:UIControlStateNormal];
    [_customButton2 setBackgroundImage:nil forState:UIControlStateNormal];
    [_customButton3 setTitle:nil forState:UIControlStateNormal];
    [_customButton3 setBackgroundImage:nil forState:UIControlStateNormal];
}

#pragma mark -
#pragma mark ABPeoplePickerNavigationControllerDelegate methods

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker 
      shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
    [_firstName release];
    [_lastName release];
    _firstName = (NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
    _lastName = (NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
    
    return YES;
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker 
      shouldContinueAfterSelectingPerson:(ABRecordRef)person 
                                property:(ABPropertyID)property 
                              identifier:(ABMultiValueIdentifier)identifier
{
    [_image release];
    if (ABPersonHasImageData(person))
    {
        CFDataRef data = ABPersonCopyImageData(person);
        _image = [[UIImage alloc] initWithData:(NSData *)data];
        [self roundCornersOfImage];
        CFRelease(data);
    }
    else 
    {
        _image = nil;
    }

    ABMultiValueRef phones = ABRecordCopyValue(person, property);
    CFStringRef phone = ABMultiValueCopyValueAtIndex(phones, identifier);
    _selectedPhone = [(NSString *)phone copy];
    CFRelease(phone);
    CFRelease(phones);
    
    NSString *alertTitle = [NSString stringWithFormat:@"%@ %@", _firstName, _lastName];
    NSString *question = NSLocalizedString(@"Use this phone number?", @"Question asked when the user selects a phone number");
    NSString *cancelWord = NSLocalizedString(@"Cancel", @"The 'cancel' word");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alertTitle
                                                    message:question
                                                   delegate:self 
                                          cancelButtonTitle:cancelWord 
                                          otherButtonTitles:@"OK", nil];
    [alert show];
    [alert release];
    
    return NO;
}

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    [_peoplePicker dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark UIAlertViewDelegate methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [_peoplePicker dismissModalViewControllerAnimated:YES];
        
        NSMutableString *phone = [[_selectedPhone mutableCopy] autorelease];
        [phone replaceOccurrencesOfString:@" " 
                               withString:@"" 
                                  options:NSLiteralSearch 
                                    range:NSMakeRange(0, [phone length])];
        [phone replaceOccurrencesOfString:@"(" 
                               withString:@"" 
                                  options:NSLiteralSearch 
                                    range:NSMakeRange(0, [phone length])];
        [phone replaceOccurrencesOfString:@")" 
                               withString:@"" 
                                  options:NSLiteralSearch 
                                    range:NSMakeRange(0, [phone length])];
        
        if (_currentButton == _customButton1)
        {
            [_defaults setBool:YES forKey:BUTTON_HAS_NUMBER_1];
            [_defaults setObject:phone forKey:NUMBER_FOR_BUTTON_1];
            [_defaults setObject:_firstName forKey:TITLE_FOR_BUTTON_1];
            [_defaults setBool:(_image != nil) forKey:BUTTON_HAS_IMAGE_1];
            [_defaults setObject:UIImagePNGRepresentation(_image) forKey:IMAGE_FOR_BUTTON_1];
        }
        else if (_currentButton == _customButton2)
        {
            [_defaults setBool:YES forKey:BUTTON_HAS_NUMBER_2];
            [_defaults setObject:phone forKey:NUMBER_FOR_BUTTON_2];
            [_defaults setObject:_firstName forKey:TITLE_FOR_BUTTON_2];
            [_defaults setBool:(_image != nil) forKey:BUTTON_HAS_IMAGE_2];
            [_defaults setObject:UIImagePNGRepresentation(_image) forKey:IMAGE_FOR_BUTTON_2];
        }
        else if (_currentButton == _customButton3)
        {
            [_defaults setBool:YES forKey:BUTTON_HAS_NUMBER_3];
            [_defaults setObject:phone forKey:NUMBER_FOR_BUTTON_3];
            [_defaults setObject:_firstName forKey:TITLE_FOR_BUTTON_3];
            [_defaults setBool:(_image != nil) forKey:BUTTON_HAS_IMAGE_3];
            [_defaults setObject:UIImagePNGRepresentation(_image) forKey:IMAGE_FOR_BUTTON_3];
        }
        
        if (_image == nil)
        {
            [_currentButton setTitle:_firstName forState:UIControlStateNormal];
        }
        else 
        {
            [_currentButton setBackgroundImage:_image forState:UIControlStateNormal];
        }

        [_defaults synchronize];
    }
}

#pragma mark -
#pragma mark UIViewController methods

- (void)viewDidLoad
{
    _defaults = [NSUserDefaults standardUserDefaults];
    
    if ([_defaults boolForKey:BUTTON_HAS_IMAGE_1])
    {
        UIImage *image = [UIImage imageWithData:[_defaults objectForKey:IMAGE_FOR_BUTTON_1]];
        [_customButton1 setBackgroundImage:image forState:UIControlStateNormal];
    }
    else 
    {
        [_customButton1 setTitle:[_defaults objectForKey:TITLE_FOR_BUTTON_1] forState:UIControlStateNormal];
    }

    if ([_defaults boolForKey:BUTTON_HAS_IMAGE_2])
    {
        UIImage *image = [UIImage imageWithData:[_defaults objectForKey:IMAGE_FOR_BUTTON_2]];
        [_customButton2 setBackgroundImage:image forState:UIControlStateNormal];
    }
    else 
    {
        [_customButton2 setTitle:[_defaults objectForKey:TITLE_FOR_BUTTON_2] forState:UIControlStateNormal];
    }

    if ([_defaults boolForKey:BUTTON_HAS_IMAGE_3])
    {
        UIImage *image = [UIImage imageWithData:[_defaults objectForKey:IMAGE_FOR_BUTTON_3]];
        [_customButton3 setBackgroundImage:image forState:UIControlStateNormal];
    }
    else 
    {
        [_customButton3 setTitle:[_defaults objectForKey:TITLE_FOR_BUTTON_3] forState:UIControlStateNormal];
    }
    
    [_defaults synchronize];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
    return NO;
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark Private methods

- (void)showPeoplePicker
{
    if (_peoplePicker == nil)
    {
        _peoplePicker = [[ABPeoplePickerNavigationController alloc] init];
        _peoplePicker.peoplePickerDelegate = self;
        _peoplePicker.title = NSLocalizedString(@"Choose a person", @"Title of the people picker");
        
        NSArray *properties = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:kABPersonFirstNameProperty],
                               [NSNumber numberWithInt:kABPersonLastNameProperty], 
                               [NSNumber numberWithInt:kABPersonPhoneProperty],
                               nil];
        _peoplePicker.displayedProperties = properties;
        [properties release];
    }
    [self presentModalViewController:_peoplePicker animated:YES];
}

- (void)roundCornersOfImage
{
    int w = _image.size.width;
    int h = _image.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    
    CGContextBeginPath(context);
    CGRect rect = CGRectMake(0, 0, w, w);
    addRoundedRectToPath(context, rect, 25, 25);
    CGContextClosePath(context);
    CGContextClip(context);
    
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), _image.CGImage);
    
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    [_image release];
    _image = [[UIImage alloc] initWithCGImage:imageMasked];
    CFRelease(imageMasked);
}

@end
