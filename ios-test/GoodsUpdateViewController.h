//
//  GoodsUpdateViewController.h
//  ios-test
//
//  Created by Vladimir Kopitsa on 12/7/15.
//  Copyright © 2015 Vladimir Kopitsa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsModel.h"
#import "APIManager.h"

@interface GoodsUpdateViewController : UIViewController
- (IBAction)cancelButton:(id)sender;

@property (strong, nonatomic) GoodsModel *goods;
@property (nonatomic, strong) NSMutableArray * goodsList;


@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *price;
@property (weak, nonatomic) IBOutlet UITextField *image;
@property (weak, nonatomic) IBOutlet UITextField *amount;
- (IBAction)save:(id)sender;

@property (weak, nonatomic) IBOutlet UIScrollView *viewScroll;

@property (nonatomic, assign) UITextField* activeTextField;

@end
