//
//  InstaPost.m
//  CustomTableViewCells
//
//  Created by Justine Gartner on 9/24/15.
//  Copyright © 2015 Justine Gartner. All rights reserved.
//

#import "InstaPost.h"

@implementation InstaPost

-(instancetype)initWithJSON: (NSDictionary *)json{
    
    //call super init, return self
    
    if (self = [super init]){
        
        self.tags = [json objectForKey:@"tags"];
        self.commentCount = [json[@"comments"][@"count"]integerValue];
        self.likeCount = [json[@"likes"][@"count"]integerValue];
        
        self.username = json[@"user"][@"username"];
        self.fullName = json[@"user"][@"full_name"];
        self.caption = json[@"caption"];
        
        self.imageURL = json[@"images"][@"standard_resolution"][@"url"];
        
        self.avatarImageURL = json[@"user"][@"profile_picture"];
        
        return self;
    
    }
    return nil;
    
}

@end
