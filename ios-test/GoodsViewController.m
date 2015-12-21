//
//  GoodsViewController.m
//  ios-test
//
//  Created by Vladimir Kopitsa on 12/8/15.
//  Copyright © 2015 Vladimir Kopitsa. All rights reserved.
//

#import "GoodsViewController.h"
#import "CartViewControl.h"
#import "AppDelegate.h"
#import "CartManager.h"

@interface GoodsViewController ()

//@property (nonatomic, strong) CartViewControl *cart;

@end

@implementation GoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.name.text = self.goods.name;
    self.price.text = [NSString stringWithFormat:@"%@", self.goods.price];
    self.amount.text = [NSString stringWithFormat:@"%d", 0];
    
    [self disableBuy];
    
}


- (void) viewDidAppear:(BOOL)animated {


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

- (IBAction)amountPlus:(id)sender {
    
    int x = [self.amount.text intValue];
    x++;
    int countRemainsInCart = [[[CartManager sharedManager] getCountRemainsAtGoods:self.goods] intValue];
    int countInCart = [[[CartManager sharedManager] getCountAtGoods:self.goods] intValue];

    
    if (countInCart >= 1 && countRemainsInCart == 0) {
        [self showMessage:[NSString stringWithFormat:@"All available goods in your shopping cart."]];
    }else if (x > countRemainsInCart) {
        [self showMessage:[NSString stringWithFormat:@"You can not select more than %d goods", countRemainsInCart]];
    }else{
        self.amount.text = [NSString stringWithFormat:@"%d", x];
        [self enableBuy];
    }
    
}

- (IBAction)amountMinus:(id)sender {

    int x = [self.amount.text intValue];
    x--;
    if (x == 0) {
        self.amount.text = [NSString stringWithFormat:@"%d", x];
        [self disableBuy];
    }else if (x < 0){
        [self showMessage:@"You can not choose less than 0 goods"];
        [self disableBuy];
    }else{
        self.amount.text = [NSString stringWithFormat:@"%d", x];
        [self enableBuy];
    }

}

- (IBAction)buy:(id)sender {
    
    int countInCart = [[[CartManager sharedManager] getCountRemainsAtGoods:self.goods] intValue];
    
    if (countInCart >= 1) {
        if ([self.goods.count intValue] == 0) {
            self.buyOutlet.hidden =YES;
        }
        
        [[CartManager sharedManager] addGoods:[NSNumber numberWithInt:[self.amount.text intValue]] goods:self.goods];
        
        [self disableBuy];
        self.amount.text = [NSString stringWithFormat:@"%d", 0];
        
    }else{
        [self showMessage:@"Something went wrong."];
    }
}

- (void)showMessage: (NSString *) message {
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

- (void) disableBuy {
    self.buyOutlet.backgroundColor = [UIColor grayColor];
    [self.buyOutlet setEnabled:NO];
}

- (void) enableBuy {
    self.buyOutlet.backgroundColor = [UIColor colorWithRed:0.459029 green:0.657679 blue:1 alpha:1];
    //2015-12-13 14:59:34.951 ios-test[11278:332983] color is UIDeviceRGBColorSpace 0.459029 0.657679 1 1
    [self.buyOutlet setEnabled:YES];
}

@end
