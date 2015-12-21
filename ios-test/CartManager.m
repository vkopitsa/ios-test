//
//  CartManager.m
//  ios-test
//
//  Created by Vladimir Kopitsa on 12/12/15.
//  Copyright © 2015 Vladimir Kopitsa. All rights reserved.
//

#import "CartManager.h"

@implementation CartManager {

    NSMutableDictionary * items;

}

- (void) addGoods: (NSNumber *) amount
            goods: (GoodsModel *) goods{
    
    if ([items objectForKey: goods.uid]) {
        
        NSMutableDictionary * data = [items objectForKey: goods.uid];
        
        int sum = [[data objectForKey:@"amount"] intValue] + [amount intValue];
        
        [items setObject:@{
                           @"model" : goods,
                           @"amount" : [[NSNumber alloc] initWithInt:sum]
                           } forKey:goods.uid];
        
        // change count in control cart
        [(AppDelegate *)[UIApplication sharedApplication].delegate startCart: [NSString stringWithFormat:@"%d", sum]];
    }else{
        [items setObject:@{
                           @"model" : goods,
                           @"amount" : amount
                           } forKey:goods.uid];
        
        [(AppDelegate *)[UIApplication sharedApplication].delegate startCart: [NSString stringWithFormat:@"%d", [amount intValue]]];

    }
    
}

- (void) removeGoods: (NSNumber *) amount
               goods: (GoodsModel *) goods{
    
    [items removeObjectForKey: goods.uid];
    
}

- (NSMutableArray *) getItemsInCart{
    
    NSMutableArray * data = [[NSMutableArray alloc] init];
    
    for (id key in items) {
        
        id value = [items objectForKey:key];
        
        [data addObject:value];
        
        //count += [[value objectForKey:@"amount"] intValue];
    }
    
    
    return data;
}

- (BOOL) isGoogsInCart: (GoodsModel *) goods {
    return !![items objectForKey: goods.uid];
}

- (NSNumber *) getCountAtGoods: (GoodsModel *) goods{
    NSMutableDictionary * data = [items objectForKey: goods.uid];
    
    return [NSNumber numberWithInt: [[data objectForKey:@"amount"] intValue]];
}

- (NSNumber *) getCountRemainsAtGoods: (GoodsModel *) goods {
    NSNumber * countInCart = [self getCountAtGoods: goods];

    return [NSNumber numberWithInt: [goods.count intValue] - [countInCart intValue]];
}

- (NSNumber *) getCountGoodsInCart {
    int count = 0;
    for (id key in items) {
        
        id value = [items objectForKey:key];
        
        count += [[value objectForKey:@"amount"] intValue];
    }
    
    return [NSNumber numberWithInt:count];
}

- (id) init {
    
    self = [super init];
    if (!self) {
        return nil;
    }
    
    items = [[NSMutableDictionary alloc] init];
    
    return self;
}

+ (id) sharedManager {
    static CartManager * _object = nil;
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        _object = [[self alloc] init];
    });
    
    return _object;
}

@end
