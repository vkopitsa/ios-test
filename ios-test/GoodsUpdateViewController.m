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
@end
