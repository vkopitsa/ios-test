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

- (NSString *) authorization: (NSString *)login
                    password: (NSString *)password
                     success:(void (^)(NSDictionary *))success
                     failure:(void (^)(NSError *error))failure{
    
    [request POST:[route getRoute:@"login"]
             data:[NSString stringWithFormat:@"identifier=%@&password=%@", login, password]
          success:success
          failure:failure];
    
    return @"sdf";
    
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
