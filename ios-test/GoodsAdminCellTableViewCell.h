//
//  GoodsAdminCellTableViewCell.h
//  ios-test
//
//  Created by Vladimir Kopitsa on 12/6/15.
//  Copyright © 2015 Vladimir Kopitsa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsAdminCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *count;

@end
