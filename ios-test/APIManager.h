//
//  APIManager.h
//  ios-test
//
//  Created by Vladimir Kopitsa on 12/5/15.
//  Copyright © 2015 Vladimir Kopitsa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodsRequestModel.h"
#import "GoodsModel.h"

@interface APIManager : NSObject

- (void) authorization: (NSString *)login
                    password: (NSString *)password
                     success:(void (^)(NSDictionary *))success
                     failure:(void (^)(NSError *error))failure;

- (void) registration: (NSString *)login
                   username: (NSString *)username
                   password: (NSString *)password
                    success:(void (^)(NSDictionary *))success
                    failure:(void (^)(NSError *error))failure;

- (void) getGoods: (NSInteger *)limit
             skip: (NSInteger *)skip
          success:(void (^)(NSMutableArray *))success
          failure:(void (^)(NSError *error))failure;

- (void) createGoods: (GoodsModel *)goods
             success:(void (^)(NSDictionary *))success
             failure:(void (^)(NSError *error))failure;

- (void) updateGoods: (GoodsModel *)goods
             success:(void (^)(NSMutableArray *))success
             failure:(void (^)(NSError *error))failure;

- (void) removeGoods: (GoodsModel *)goods
             success:(void (^)(NSMutableArray *))success
             failure:(void (^)(NSError *error))failure;

+ (id) sharedManager;

@end
