//
//  APIRequest.h
//  ios-test
//
//  Created by Vladimir Kopitsa on 12/5/15.
//  Copyright © 2015 Vladimir Kopitsa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIRequest : NSObject

- (void)GET:(NSString *)url
    success:(void (^)(id))success
    failure:(void (^)(NSError *error))failure;

- (void)POST:(NSString *)url
        data:(NSString *)data
     success:(void (^)(id))success
     failure:(void (^)(NSError *error))failure;

- (void)PUT:(NSString *)url
        data:(NSString *)data
     success:(void (^)(id))success
     failure:(void (^)(NSError *error))failure;

- (void)DELETE:(NSString *)url
    success:(void (^)(id))success
    failure:(void (^)(NSError *error))failure;

+ (id) sharedManager;

@end
