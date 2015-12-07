//
//  APIAuth.h
//  ios-test
//
//  Created by Vladimir Kopitsa on 12/5/15.
//  Copyright © 2015 Vladimir Kopitsa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

@interface APIAuth : NSObject

- (void) authorization: (NSString *)login
              password: (NSString *)password
               success:(void (^)(UserModel *))success
               failure:(void (^)(NSError *error))failure;

- (void) registration: (NSString *)login
            username: (NSString *)username
            password: (NSString *)password
            success:(void (^)(UserModel *))success
            failure:(void (^)(NSError *error))failure;

- (BOOL)isAuthorization;

- (void) logout;


+ (id) sharedManager;

@end
