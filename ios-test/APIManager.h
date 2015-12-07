//
//  APIManager.h
//  ios-test
//
//  Created by Vladimir Kopitsa on 12/5/15.
//  Copyright © 2015 Vladimir Kopitsa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodsRequestModel.h"

@interface APIManager : NSObject

- (NSString *) authorization: (NSString *)login
                    password: (NSString *)password
                     success:(void (^)(NSDictionary *))success
                     failure:(void (^)(NSError *error))failure;

- (void) registration: (NSString *)login
                   username: (NSString *)username
                   password: (NSString *)password
                    success:(void (^)(NSDictionary *))success
                    failure:(void (^)(NSError *error))failure;

+ (id) sharedManager;

@end
