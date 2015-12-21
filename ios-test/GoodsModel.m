//
//  GoodsModel.m
//  ios-test
//
//  Created by Vladimir Kopitsa on 12/5/15.
//  Copyright © 2015 Vladimir Kopitsa. All rights reserved.
//

#import "GoodsModel.h"

@implementation GoodsModel

@synthesize uid;
@synthesize name;
@synthesize price;
@synthesize count;
@synthesize image;
@synthesize createdAt;
@synthesize updatedAt;

- (id)initWithDictionary:(NSDictionary *)object
{
    self = [super init];
    if (self) {
        uid = [object[@"id"] copy];
        name = [object[@"name"] copy];
        price = [object[@"price"] copy];
        count = [object[@"count"] copy];
        image = [object[@"image"] copy];
        //createdAt = [self.class.dateFormatter dateFromString:object[@"createdAt"]];
        //updatedAt = [self.class.dateFormatter dateFromString:object[@"updatedAt"]];
        
    }
    return self;
}

+ (NSDateFormatter *)dateFormatter {
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSS'Z'"];
    return dateFormatter;
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [self init];
    if (self == nil) return nil;
    
    uid = [coder decodeObjectForKey:@"uid"];
    name = [coder decodeObjectForKey:@"name"];
    price = [coder decodeObjectForKey:@"price"];
    count = [coder decodeObjectForKey:@"count"];
    image = [coder decodeObjectForKey:@"image"];
    createdAt = [coder decodeObjectForKey:@"createdAt"];
    updatedAt = [coder decodeObjectForKey:@"updatedAt"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    if (self.uid != nil) [coder encodeObject:self.uid forKey:@"uid"];
    if (self.name != nil) [coder encodeObject:self.name forKey:@"name"];
    if (self.price != nil) [coder encodeObject:self.price forKey:@"price"];
    if (self.count != nil) [coder encodeObject:self.count forKey:@"count"];
    if (self.image != nil) [coder encodeObject:self.image forKey:@"image"];
    if (self.createdAt != nil) [coder encodeObject:self.createdAt forKey:@"createdAt"];
    if (self.updatedAt != nil) [coder encodeObject:self.updatedAt forKey:@"updatedAt"];
}

- (id)copyWithZone:(NSZone *)zone {
    GoodsModel *goods = [[self.class allocWithZone:zone] init];
    goods->uid = self.uid;
    goods->name = self.name;
    goods->price = self.price;
    goods->count = self.count;
    goods->image = self.image;
    goods->createdAt = self.createdAt;
    goods->updatedAt = self.updatedAt;
    
    return goods;
}

- (NSUInteger)hash {
    NSLog(@"Goods id %@ hash is %lu", self.uid, (unsigned long)self.uid.hash);
    return self.uid.hash;
}

- (BOOL)isEqual:(GoodsModel *)goods {
    if (![goods isKindOfClass:GoodsModel.class]) return NO;
    
    return [self.uid isEqual:goods.uid] && [self.name isEqual:goods.name] && [self.price isEqual:goods.price] && [self.count isEqual:goods.count] && [self.image isEqual:goods.image];
}

@end
