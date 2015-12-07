//
//  LoginViewController.m
//  ios-test
//
//  Created by Vladimir Kopitsa on 11/24/15.
//  Copyright © 2015 Vladimir Kopitsa. All rights reserved.
//

#import "LoginViewController.h"
#import "APIAuth.h"
#import "UserModel.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    
    //    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]
    //                                       initWithTarget:self
    //                                       action:@selector(showMessage)];
    //
    //    [self.view addGestureRecognizer:pinch];
    
    
//    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [self.loader stopAnimating];
}

-(void)viewDidUnload {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.email || textField == self.password || textField == self.username) {
        
        NSInteger nextTag = textField.tag + 1;
        UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
        
        if (nextResponder) {
            // next field
            [nextResponder becomeFirstResponder];
        } else {
            // hide keyboard
            [textField resignFirstResponder];
            
            if (textField.tag == 1) {
                [self login];
            }else{
                [self registration];
            }
            
        }
        
    }
    
    return YES;
}

-(void)dismissKeyboard {
    [self.email resignFirstResponder];
    [self.password resignFirstResponder];
}


- (void)orientationChanged:(NSNotification *)notification {
    // Respond to changes in device orientation
    UIInterfaceOrientation newOrientation =  [UIApplication sharedApplication].statusBarOrientation;
    if ((newOrientation == UIInterfaceOrientationLandscapeLeft || newOrientation == UIInterfaceOrientationLandscapeRight))
    {
        
    }
    NSLog(@"%ld", (long)newOrientation);
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)fbLogin:(id)sender {
    
    [[UIApplication sharedApplication]
     openURL:[NSURL URLWithString:@"https://m.facebook.com/v2.5/dialog/oauth?client_id=273156676148911&default_audience=friends&display=touch&e2e=%7B%22init%22:603703.403987068%7D&fbapp_pres=0&redirect_uri=fb273156676148911://authorize/&response_type=token"]];
    
    
}


-(void) viewDidDisappear {
    // Request to stop receiving accelerometer events and turn off accelerometer
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
}


- (void)keyboardWasShown:(NSNotification *)notification
{
    
    // Step 1: Get the size of the keyboard.
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    
    // Step 2: Adjust the bottom content inset of your scroll view by the keyboard height.
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0);
    self.viewScroll.contentInset = contentInsets;
    self.viewScroll.scrollIndicatorInsets = contentInsets;
    
    
    // Step 3: Scroll the target text field into view.
    CGRect aRect = self.view.frame;
    aRect.size.height -= keyboardSize.height;
    if (!CGRectContainsPoint(aRect, self.activeTextField.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, self.activeTextField.frame.origin.y - (keyboardSize.height-15));
        [self.viewScroll setContentOffset:scrollPoint animated:YES];
    }
}


- (void) keyboardWillHide:(NSNotification *)notification {
    
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.viewScroll.contentInset = contentInsets;
    self.viewScroll.scrollIndicatorInsets = contentInsets;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.activeTextField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.activeTextField = nil;
}


- (IBAction)singIn:(id)sender {

    [self login];

}

- (void) login{

    [self.loader startAnimating];
    
    NSString * email = self.email.text;
    NSString * password = self.password.text;
    
    [[APIAuth sharedManager] authorization:email password:password success:^(UserModel *user) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.loader stopAnimating];

            [self showShop];
        });
        
    } failure:^(NSError *error) {
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.loader stopAnimating];
            
            [self showMessage: @"Incorrect login or password!"];
        });
        
    }];

}

- (IBAction)singUp:(id)sender {
    [self registration];
}

- (void) registration {
    
    [self.loader startAnimating];
    
    NSString * email = self.email.text;
    NSString * username = self.username.text;
    NSString * password = self.password.text;
    
    [[APIAuth sharedManager] registration:email username:username password:password success:^(UserModel *user) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.loader stopAnimating];
            
            [self showShop];
        });
        
    } failure:^(NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.loader stopAnimating];
            
            [self showMessage: @"Incorrect login or password or username!"];
            
        });
        
    }];

    
}

- (void) showShop {
    
    UIViewController *initialViewController = nil;
    
    UIStoryboard *loginRegistation = [UIStoryboard storyboardWithName:@"Shop" bundle:nil];
    
    // Instantiate the initial view controller object from the storyboard
    //initialViewController = [loginRegistation instantiateViewControllerWithIdentifier:@"shop"];
    initialViewController = [loginRegistation instantiateInitialViewController];
    
    UIWindow *mWindow = self.view.window;
    
    for (UIView *view in [self.view subviews])
                                {
                                    [view removeFromSuperview];
                                }
    
    [mWindow setRootViewController:initialViewController];
    [mWindow makeKeyAndVisible];
//    [UIView transitionWithView:self.view
//                      duration:0.50
//                       options:UIViewAnimationOptionTransitionNone
//                    animations:^{
//                        
//                        //remove all sub views
//                        for (UIView *view in [self.view subviews])
//                        {
//                            [view removeFromSuperview];
//                        }
//                        [self.view addSubview:initialViewController.view];
//                        
//                    }
//                    completion:^(BOOL finished){
//                        //At completion set the new view controller.
//                        //[mWindow setRootViewController:initialViewController];
//                        //[mWindow makeKeyAndVisible];
//                    }];
    
    
}

-(void)showMessage: (NSString *) message {
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:message
                                  message:nil
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [alert dismissViewControllerAnimated:YES completion:^{
            // do something ?
        }];
    });
    
}

@end
