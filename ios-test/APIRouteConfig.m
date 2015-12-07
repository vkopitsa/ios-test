//
//  APIRouteConfig.m
//  ios-test
//
//  Created by Vladimir Kopitsa on 12/5/15.
//  Copyright © 2015 Vladimir Kopitsa. All rights reserved.
//

#import "APIRouteConfig.h"

@implementation APIRouteConfig {
    
    NSDictionary *config;
    
}

- (id) init {
    
    self = [super init];
    if (!self) {
        return nil;
    }
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"setting" ofType:@"plist"];
    config = [[[NSDictionary alloc] initWithContentsOfFile:path] valueForKey:@"route"];
    
    return self;
}

- (NSString *) getRoute: (NSString *) name{
    
    NSString * route;
    if([config valueForKey:name] != nil){
        route = [config valueForKey:name];
    }
    
    return route;
    
}


+ (id) sharedManager {
    static APIRouteConfig * _routeConfig = nil;
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        _routeConfig = [[self alloc] init];
    });
    
    return _routeConfig;
}

@end
