//
//  LoginViewController.h
//  ios-test
//
//  Created by Vladimir Kopitsa on 11/24/15.
//  Copyright © 2015 Vladimir Kopitsa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *username;

@property (weak, nonatomic) IBOutlet UIScrollView *viewScroll;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loader;

- (IBAction)singIn:(id)sender;
- (IBAction)singUp:(id)sender;

@property (nonatomic, assign) UITextField* activeTextField;

- (IBAction)fbLogin:(id)sender;

@end
