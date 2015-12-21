//
//  CartCollectionViewCell.m
//  ios-test
//
//  Created by Vladimir Kopitsa on 12/13/15.
//  Copyright © 2015 Vladimir Kopitsa. All rights reserved.
//

#import "CartCollectionViewCell.h"

@implementation CartCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    // standard background (deselected)
//    UIView *bgView = [[UIView alloc]initWithFrame:self.bounds];
//    self.backgroundView = bgView;
//    self.backgroundView.backgroundColor = [UIColor blueColor];
    
    // selected background
    UIView *selectedView = [[UIView alloc]initWithFrame:self.bounds];
    self.selectedBackgroundView = selectedView;
    self.selectedBackgroundView.backgroundColor = [UIColor grayColor];
}

@end
