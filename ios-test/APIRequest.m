//
//  APIRequest.m
//  ios-test
//
//  Created by Vladimir Kopitsa on 12/5/15.
//  Copyright © 2015 Vladimir Kopitsa. All rights reserved.
//

#import "APIRequest.h"
#import "APIAuth.h"


typedef NS_ENUM(NSUInteger, APIRequestMathod)
{
    APIRequestMathodGet,
    APIRequestMathodPost,
    APIRequestMathodPut,
    APIRequestMathodDelete
};

@implementation APIRequest {
    
    NSURL *baseUrl;
    
}


- (id) init {
    
    self = [super init];
    if (!self) {
        return nil;
    }
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"setting" ofType:@"plist"];
    NSString *host = [[[NSDictionary alloc] initWithContentsOfFile:path] valueForKey:@"url"];
    NSString *protocol = [[[NSDictionary alloc] initWithContentsOfFile:path] valueForKey:@"protocol"];
    
    
    baseUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", protocol, host]];
    
    return self;
}

- (NSURL *) getUrl: (NSString *) url{
    return [NSURL URLWithString:url relativeToURL:baseUrl];
    
}

- (NSMutableURLRequest *) getRequest: (NSString *) url {
    
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[self getUrl:url]];
    
    [request setValue: [NSString stringWithFormat:@"Bearer %@", [[APIAuth sharedManager] getToken]] forHTTPHeaderField:@"Authorization"];
    
    return request;
}

- (void)GET:(NSString *)url
    success:(void (^)(id))success
    failure:(void (^)(NSError *error))failure{
    
    NSURLSessionDataTask *task =
    [[NSURLSession sharedSession] dataTaskWithRequest:[self getRequest:url]
                                    completionHandler:^(NSData *data,
                                                        NSURLResponse *response,
                                                        NSError *error) {
                                        // Code to run when the response completes...
                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                        
                                        // is not connected
                                        if (data == nil) {
                                            return failure(error);
                                        }

                                        
                                        NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                        
                                        NSError *jsonError = nil;
                                        
                                        
                                        NSObject* json = [NSJSONSerialization JSONObjectWithData:data
                                                                                         options:kNilOptions
                                                                                           error:&jsonError];
                                        
                                        
                                        if ((long)[httpResponse statusCode] == 200 && jsonError == nil) {
                                            if([json isKindOfClass:[NSArray class]]){
                                                //Is array
                                                success([NSMutableArray arrayWithArray:[NSJSONSerialization JSONObjectWithData:data
                                                                                                                       options:kNilOptions
                                                                                                                         error:&jsonError]]);
                                            }else if([json isKindOfClass:[NSDictionary class]]){
                                                //is dictionary
                                                success([NSJSONSerialization JSONObjectWithData:data
                                                                                        options:kNilOptions
                                                                                          error:&jsonError]);
                                            }else{
                                                //is something else
                                                success([NSJSONSerialization JSONObjectWithData:data
                                                                                        options:kNilOptions
                                                                                          error:&jsonError]);
                                            }
                                            
                                        }else{
                                            failure(error);
                                        }
                                        
                                        
                                    }];
    [task resume];
    
}

- (void)POST:(NSString *)url
        data:(NSString *)data
     success:(void (^)(id))success
     failure:(void (^)(NSError *error))failure{
    
    NSMutableURLRequest *request = [self getRequest:url];
    
    [request setHTTPMethod:[self getMathod:APIRequestMathodPost]];
    [request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask *task =
    [[NSURLSession sharedSession] dataTaskWithRequest:request
                                    completionHandler:^(NSData *data,
                                                        NSURLResponse *response,
                                                        NSError *error) {
                                        // Code to run when the response completes...
                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                        
                                        // is not connected
                                        if (data == nil) {
                                            return failure(error);
                                        }
                                        
                                        NSError *jsonError = nil;
                                        
                                        
                                        NSObject* json = [NSJSONSerialization JSONObjectWithData:data
                                                                                         options:kNilOptions
                                                                                           error:&jsonError];
                                        
                                        
                                        if ((long)[httpResponse statusCode] == 200 && jsonError == nil) {
                                            if([json isKindOfClass:[NSArray class]]){
                                                //Is array
                                                success([NSMutableArray arrayWithArray:[NSJSONSerialization JSONObjectWithData:data
                                                                                                                       options:kNilOptions
                                                                                                                         error:&jsonError]]);
                                            }else if([json isKindOfClass:[NSDictionary class]]){
                                                //is dictionary
                                                success([NSJSONSerialization JSONObjectWithData:data
                                                                                        options:kNilOptions
                                                                                          error:&jsonError]);
                                            }else{
                                                //is something else
                                                success([NSJSONSerialization JSONObjectWithData:data
                                                                                        options:kNilOptions
                                                                                          error:&jsonError]);
                                            }
                                            
                                        }else{
                                            failure(error);
                                        }
                                        
                                        
                                    }];
    [task resume];
    
}


- (void)PUT:(NSString *)url
        data:(NSString *)data
     success:(void (^)(id))success
     failure:(void (^)(NSError *error))failure{
    
    NSMutableURLRequest *request = [self getRequest:url];
    
    [request setHTTPMethod:[self getMathod:APIRequestMathodPut]];
    [request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    
    NSURLSessionDataTask *task =
    [[NSURLSession sharedSession] dataTaskWithRequest:request
                                    completionHandler:^(NSData *data,
                                                        NSURLResponse *response,
                                                        NSError *error) {
                                        // Code to run when the response completes...
                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                        
                                        // is not connected
                                        if (data == nil) {
                                            return failure(error);
                                        }
                                        
                                        NSError *jsonError = nil;
                                        
                                        
                                        NSObject* json = [NSJSONSerialization JSONObjectWithData:data
                                                                                         options:kNilOptions
                                                                                           error:&jsonError];
                                        
                                        
                                        if ((long)[httpResponse statusCode] == 200 && jsonError == nil) {
                                            if([json isKindOfClass:[NSArray class]]){
                                                //Is array
                                                success([NSMutableArray arrayWithArray:[NSJSONSerialization JSONObjectWithData:data
                                                                                                                       options:kNilOptions
                                                                                                                         error:&jsonError]]);
                                            }else if([json isKindOfClass:[NSDictionary class]]){
                                                //is dictionary
                                                success([NSJSONSerialization JSONObjectWithData:data
                                                                                        options:kNilOptions
                                                                                          error:&jsonError]);
                                            }else{
                                                //is something else
                                                success([NSJSONSerialization JSONObjectWithData:data
                                                                                        options:kNilOptions
                                                                                          error:&jsonError]);
                                            }
                                            
                                        }else{
                                            failure(error);
                                        }
                                        
                                        
                                    }];
    [task resume];
    
}


- (void)DELETE:(NSString *)url
    success:(void (^)(id))success
    failure:(void (^)(NSError *error))failure{
    
    NSMutableURLRequest *request = [self getRequest:url];
    
    [request setHTTPMethod:[self getMathod:APIRequestMathodDelete]];
    //[request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSessionDataTask *task =
    [[NSURLSession sharedSession] dataTaskWithRequest:request
                                    completionHandler:^(NSData *data,
                                                        NSURLResponse *response,
                                                        NSError *error) {
                                        // Code to run when the response completes...
                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                        
                                        // is not connected
                                        if (data == nil) {
                                            return failure(error);
                                        }
                                        
                                        NSError *jsonError = nil;
                                        
                                        
                                        NSObject* json = [NSJSONSerialization JSONObjectWithData:data
                                                                                         options:kNilOptions
                                                                                           error:&jsonError];
                                        
                                        
                                        if ((long)[httpResponse statusCode] == 200 && jsonError == nil) {
                                            if([json isKindOfClass:[NSArray class]]){
                                                //Is array
                                                success([NSMutableArray arrayWithArray:[NSJSONSerialization JSONObjectWithData:data
                                                                                                                       options:kNilOptions
                                                                                                                         error:&jsonError]]);
                                            }else if([json isKindOfClass:[NSDictionary class]]){
                                                //is dictionary
                                                success([NSJSONSerialization JSONObjectWithData:data
                                                                                        options:kNilOptions
                                                                                          error:&jsonError]);
                                            }else{
                                                //is something else
                                                success([NSJSONSerialization JSONObjectWithData:data
                                                                                        options:kNilOptions
                                                                                          error:&jsonError]);
                                            }
                                            
                                        }else{
                                            failure(error);
                                        }
                                        
                                        
                                    }];
    [task resume];
    
}


+ (id) sharedManager {
    static APIRequest * _object = nil;
    
    static dispatch_once_t onceToken1;
    dispatch_once(&onceToken1, ^{
        _object = [[self alloc] init];
    });
    
    return _object;
}

- (NSString*) getMathod:(APIRequestMathod) mathod {
    NSString *result = nil;
    
    switch(mathod) {
        case APIRequestMathodGet:
            result = @"GET";
            break;
        case APIRequestMathodPost:
            result = @"POST";
            break;
        case APIRequestMathodPut:
            result = @"PUT";
            break;
        case APIRequestMathodDelete:
            result = @"DELETE";
            break;
            
        default:
            result = @"unknown";
    }
    
    return result;
}

@end
