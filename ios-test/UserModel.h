//
//  UserModel.h
//  ios-test
//
//  Created by Vladimir Kopitsa on 12/5/15.
//  Copyright © 2015 Vladimir Kopitsa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, copy, readonly) NSNumber *uid;
@property (nonatomic, copy, readonly) NSString *email;
@property (nonatomic, copy, readonly) NSString *username;
@property (nonatomic, copy, readonly) NSDate *createdAt;
@property (nonatomic, copy, readonly) NSDate *updatedAt;
@property (nonatomic, copy, readonly) NSString *accessToken;

- (id)initWithDictionary:(NSDictionary *)user;

@end
