//
//  CartManager.h
//  ios-test
//
//  Created by Vladimir Kopitsa on 12/12/15.
//  Copyright © 2015 Vladimir Kopitsa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodsModel.h"
#import "AppDelegate.h"

@interface CartManager : NSObject

+ (id) sharedManager;

- (void) addGoods: (NSNumber *) amount
            goods: (GoodsModel *) goods;

- (void) removeGoods: (NSNumber *) amount
               goods: (GoodsModel *) goods;

- (NSMutableArray *) getItemsInCart;

- (BOOL) isGoogsInCart: (GoodsModel *) goods;

- (NSNumber *) getCountAtGoods: (GoodsModel *) goods;

- (NSNumber *) getCountRemainsAtGoods: (GoodsModel *) goods;

- (NSNumber *) getCountGoodsInCart;

@end
