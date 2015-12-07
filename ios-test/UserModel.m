//
//  UserModel.m
//  ios-test
//
//  Created by Vladimir Kopitsa on 12/5/15.
//  Copyright © 2015 Vladimir Kopitsa. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

@synthesize uid;
@synthesize email;
@synthesize username;
@synthesize createdAt;
@synthesize updatedAt;
@synthesize accessToken;

- (id)initWithDictionary:(NSDictionary *)user
{
    self = [super init];
    if (self) {
        uid = [user[@"user"][@"id"] copy];
        email = [user[@"user"][@"email"] copy];
        username = [user[@"user"][@"username"] copy];
        accessToken = [user[@"accessToken"] copy];
        createdAt = [self.class.dateFormatter dateFromString:user[@"user"][@"createdAt"]];
        updatedAt = [self.class.dateFormatter dateFromString:user[@"user"][@"updatedAt"]];
        
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
    email = [coder decodeObjectForKey:@"email"];
    username = [coder decodeObjectForKey:@"username"];
    accessToken = [coder decodeObjectForKey:@"accessToken"];
    createdAt = [coder decodeObjectForKey:@"createdAt"];
    updatedAt = [coder decodeObjectForKey:@"updatedAt"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    if (self.uid != nil) [coder encodeObject:self.uid forKey:@"uid"];
    if (self.email != nil) [coder encodeObject:self.email forKey:@"email"];
    if (self.username != nil) [coder encodeObject:self.username forKey:@"username"];
    if (self.accessToken != nil) [coder encodeObject:self.accessToken forKey:@"accessToken"];
    if (self.createdAt != nil) [coder encodeObject:self.createdAt forKey:@"createdAt"];
    if (self.updatedAt != nil) [coder encodeObject:self.updatedAt forKey:@"updatedAt"];
}

- (id)copyWithZone:(NSZone *)zone {
    UserModel *user = [[self.class allocWithZone:zone] init];
    user->uid = self.uid;
    user->email = self.email;
    user->username = self.username;
    user->accessToken = self.accessToken;
    user->createdAt = self.createdAt;
    user->updatedAt = self.updatedAt;
    
    return user;
}

- (NSUInteger)hash {
    return self.uid.hash;
}

- (BOOL)isEqual:(UserModel *)user {
    if (![user isKindOfClass:UserModel.class]) return NO;
    
    return [self.uid isEqual:user.uid] && [self.email isEqual:user.email] && [self.username isEqual:user.username];
}

@end
