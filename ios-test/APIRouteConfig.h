//
//  APIRouteConfig.h
//  ios-test
//
//  Created by Vladimir Kopitsa on 12/5/15.
//  Copyright © 2015 Vladimir Kopitsa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIRouteConfig : NSObject

+ (id) sharedManager;

- (NSString *) getRoute: (NSString *) name;

@end
