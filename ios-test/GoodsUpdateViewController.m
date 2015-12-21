//
//  GoodsUpdateViewController.m
//  ios-test
//
//  Created by Vladimir Kopitsa on 12/7/15.
//  Copyright © 2015 Vladimir Kopitsa. All rights reserved.
//

#import "GoodsUpdateViewController.h"

@interface GoodsUpdateViewController ()

@end

@implementation GoodsUpdateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.name.text = self.goods.name;
    self.price.text = [NSString stringWithFormat:@"%@", self.goods.price];
    self.amount.text = [NSString stringWithFormat:@"%@", self.goods.count];
    self.image.text = self.goods.image;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cancelButton:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)save:(id)sender {
    
    
        self.goods.name = self.name.text;
        self.goods.count = [NSNumber numberWithInt:[self.amount.text intValue]];
        self.goods.price = self.price.text;
    
    
    if (self.goods.uid != nil) {
        [[APIManager sharedManager] updateGoods:self.goods success:^(NSMutableArray * data){
            
            
            GoodsModel * new_googs = [[GoodsModel alloc] initWithDictionary:[data objectAtIndex:0]];
            
            
            self.goods = new_googs;
            
            NSLog(@"success");
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            });
            
        } failure:^(NSError *error) {
            NSLog(@"failure");
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            });
            
        }];
    }else{
    
        [[APIManager sharedManager] createGoods:self.goods success:^(NSDictionary * data){
            
            
            GoodsModel * new_googs = [[GoodsModel alloc] initWithDictionary:data];
            
            
            //self.goods = new_googs;
            [self.goodsList addObject:new_googs];
            
            NSLog(@"success");
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            });
            
        } failure:^(NSError *error) {
            NSLog(@"failure");
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            });
            
        }];
    
    }
    
    

    
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


@end
