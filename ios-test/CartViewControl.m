//
//  CartViewControl.m
//  ios-test
//
//  Created by Vladimir Kopitsa on 12/10/15.
//  Copyright © 2015 Vladimir Kopitsa. All rights reserved.
//

#import "CartViewControl.h"

@interface CartViewControl ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation CartViewControl

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)_defaultInit {
//    self.clipsToBounds = YES;
//    self.layer.masksToBounds = YES;
    
//    self.direction = DirectionUp;
//    self.animatedHighlighting = YES;
//    self.collapseAfterSelection = YES;
//    self.animationDuration = kDefaultAnimationDuration;
//    self.standbyAlpha = 1.f;
//    self.highlightAlpha = 0.45f;
//    self.originFrame = self.frame;
//    self.buttonSpacing = 20.f;
//    _isCollapsed = YES;
//    
//    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_handleTapGesture:)];
//    self.tapGestureRecognizer.cancelsTouchesInView = NO;
//    self.tapGestureRecognizer.delegate = self;
//    
//    [self addGestureRecognizer:self.tapGestureRecognizer];
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(5.f, 0.f, 48.f, 48.f)];
    
    self.label.text = @"1";
    self.label.textColor = [UIColor blackColor];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.layer.cornerRadius = self.label.frame.size.height / 2.f;
    //label.backgroundColor =[UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.5f];
    self.label.clipsToBounds = YES;
    
    
    UIImage *homeLabel = [UIImage imageNamed:@"1449717971_shopping_cart_loaded.png"];

    UIImageView *imageView = [[UIImageView alloc] initWithImage:homeLabel];
    
    [self addSubview:imageView];
    
    [self addSubview:self.label];
    
}


- (void) setText: (NSString *) text{

    self.label.text = text;

}


//- (UIView *)createCartView {
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5.f, 0.f, 48.f, 48.f)];
//    
//    label.text = @"1";
//    label.textColor = [UIColor blackColor];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.layer.cornerRadius = label.frame.size.height / 2.f;
//    //label.backgroundColor =[UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.5f];
//    label.clipsToBounds = YES;
//    
//    
//    //UIImage *fgdfg = [[UIImage alloc] initWithContentsOfFile:@"1449717971_shopping_cart_loaded.png"];
//    
//    UIImage *homeLabel = [UIImage imageNamed:@"1449717971_shopping_cart_loaded.png"];
//    
//    // Create down menu button
//    //UIImage *homeLabel = [self createHomeButtonView];
//    
//    
//    
//    UIView * crat = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width - homeLabel.size.width - 20.f,
//                                                            self.view.frame.size.height - homeLabel.size.height - 60.f,
//                                                            homeLabel.size.width,
//                                                            homeLabel.size.height)];
//    //[crat setBackgroundColor:[UIColor yellowColor]];
//    
//    
//    
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:homeLabel];
//    
//    [crat addSubview:imageView];
//    
//    [crat addSubview:label];
//    
//    
//    return crat;
//}



- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self _defaultInit];
    }
    return self;
}


@end
