//
//  GoodsViewController.h
//  ios-test
//
//  Created by Vladimir Kopitsa on 12/8/15.
//  Copyright © 2015 Vladimir Kopitsa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsModel.h"

@interface GoodsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) GoodsModel *goods;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *amount;
- (IBAction)amountPlus:(id)sender;
- (IBAction)amountMinus:(id)sender;
- (IBAction)buy:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *buyOutlet;

@end
