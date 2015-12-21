//
//  APIManager.m
//  ios-test
//
//  Created by Vladimir Kopitsa on 12/5/15.
//  Copyright © 2015 Vladimir Kopitsa. All rights reserved.
//

#import "APIManager.h"
#import "APIRequest.h"
#import "APIRouteConfig.h"

@implementation APIManager {
    
    APIRequest * request;
    APIRouteConfig * route;
    
}

- (void) authorization: (NSString *)login
                    password: (NSString *)password
                     success:(void (^)(NSDictionary *))success
                     failure:(void (^)(NSError *error))failure{
    
    [request POST:[route getRoute:@"login"]
             data:[NSString stringWithFormat:@"identifier=%@&password=%@", login, password]
          success:success
          failure:failure];
}

- (void) registration: (NSString *)login
             username: (NSString *)username
             password: (NSString *)password
              success:(void (^)(NSDictionary *))success
              failure:(void (^)(NSError *error))failure{
    
    [request POST:[route getRoute:@"register"]
             data:[NSString stringWithFormat:@"email=%@&username=%@&password=%@", login, username, password]
          success:success
          failure:failure];
    
}

- (void) getGoods: (NSInteger *)limit
                         skip: (NSInteger *)skip
                      success:(void (^)(NSMutableArray *))success
                      failure:(void (^)(NSError *error))failure {
    
    [request GET:[route getRoute:@"goods"]
          success:success
          failure:failure];
}

- (void) createGoods: (GoodsModel *)goods
             success:(void (^)(NSDictionary *))success
             failure:(void (^)(NSError *error))failure {
    
    [request POST:[route getRoute:@"goods"]
            data:[NSString stringWithFormat:@"name=%@&count=%@&price=%@",
                  goods.name,
                  goods.count,
                  goods.price]
         success:success
         failure:failure];
}

- (void) updateGoods: (GoodsModel *)goods
          success:(void (^)(NSMutableArray *))success
          failure:(void (^)(NSError *error))failure {
    
    [request PUT:[NSString stringWithFormat:[route getRoute:@"oneGoods"], goods.uid]
             data:[NSString stringWithFormat:@"name=%@&count=%@&price=%@",
                   goods.name,
                   goods.count,
                   goods.price]
         success:success
         failure:failure];
}

- (void) removeGoods: (GoodsModel *)goods
             success:(void (^)(NSMutableArray *))success
             failure:(void (^)(NSError *error))failure {
    
    [request DELETE:[NSString stringWithFormat:[route getRoute:@"oneGoods"], goods.uid]
         success:success
         failure:failure];
}

- (id) init {
    
    self = [super init];
    if (!self) {
        return nil;
    }
    
    
    request = [APIRequest sharedManager];
    route = [APIRouteConfig sharedManager];
    
    return self;
}

+ (id) sharedManager {
    static APIManager * _sessionManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sessionManager = [[self alloc] init];
    });
    
    return _sessionManager;
}

@end
