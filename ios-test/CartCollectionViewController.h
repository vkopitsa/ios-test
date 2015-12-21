//
//  CartCollectionViewController.h
//  ios-test
//
//  Created by Vladimir Kopitsa on 12/13/15.
//  Copyright © 2015 Vladimir Kopitsa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "CartManager.h"
#import "CartCollectionViewCell.h"
#import "GoodsModel.h"

@interface CartCollectionViewController : UICollectionViewController
- (IBAction)cancel:(id)sender;
- (IBAction)buy:(id)sender;

@end
