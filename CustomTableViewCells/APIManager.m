//
//  APIManager.m
//  API-Practice
//
//  Created by Justine Gartner on 9/20/15.
//  Copyright © 2015 Justine Gartner. All rights reserved.
//

#import "APIManager.h"

@implementation APIManager


//we make this a class method +
//because the method is stateless.
//this way we don't have to initialize objects to use it

+ (void)GetRequestWithURL: (NSURL *)url
       completionHandler: (void(^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler {
    
    //CREATING REQUEST:
    
    //create session
    NSURLSession *session = [NSURLSession sharedSession];
    
    //create task
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        //NSLog(@"%@", data);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            completionHandler(data, response, error);
            
        });
    }];
    
    //PERFORMING REQUEST:
    
    [task resume];
    
}


@end
