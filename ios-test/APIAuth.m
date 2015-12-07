//
//  APIAuth.m
//  ios-test
//
//  Created by Vladimir Kopitsa on 12/5/15.
//  Copyright © 2015 Vladimir Kopitsa. All rights reserved.
//

#import "APIAuth.h"
#import "APIManager.h"
#import "UserModel.h"


@implementation APIAuth {
    
    APIManager * _APIManager;
    
}


- (id) init {
    
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _APIManager = [APIManager sharedManager];
    
    return self;
}

- (void) authorization: (NSString *)login
              password: (NSString *)password
               success:(void (^)(UserModel *))success
               failure:(void (^)(NSError *error))failure{
    
    [_APIManager authorization:login password:password success:^(NSDictionary * data){
        
        UserModel * user = [[UserModel alloc] initWithDictionary:data];
        
        [self saveUser:user key:@"user"];
        
        success(user);
        
        
    } failure:failure];
}

- (void) registration: (NSString *)login
             username: (NSString *)username
             password: (NSString *)password
              success:(void (^)(UserModel *))success
              failure:(void (^)(NSError *error))failure{
    
    [_APIManager registration:login username:username password:password success:^(NSDictionary * data){
        
        UserModel * user = [[UserModel alloc] initWithDictionary:data];
        
        [self saveUser:user key:@"user"];
        
        success(user);
        
        
    } failure:failure];
}

- (BOOL)isAuthorization {
    
    return [self loadUser:@"user"].uid != nil;
}

- (void) logout {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:nil forKey:@"user"];
    [defaults synchronize];
}


- (void)saveUser:(UserModel *)object key:(NSString *)key {
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:object];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:encodedObject forKey:key];
    [defaults synchronize];
    
}

- (UserModel *)loadUser:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:key];
    UserModel *object = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    return object;
}

+ (id) sharedManager {
    static APIAuth * _object = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _object = [[self alloc] init];
    });
    
    return _object;
}

@end
