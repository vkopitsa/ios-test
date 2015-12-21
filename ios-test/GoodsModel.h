//
//  GoodsModel.h
//  ios-test
//
//  Created by Vladimir Kopitsa on 12/5/15.
//  Copyright © 2015 Vladimir Kopitsa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, copy) NSNumber *uid;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSNumber *count;
@property (nonatomic, copy) NSDate *createdAt;
@property (nonatomic, copy) NSDate *updatedAt;

- (id)initWithDictionary:(NSDictionary *)object;

@end
