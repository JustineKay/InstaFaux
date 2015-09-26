//
//  InstaPost.h
//  CustomTableViewCells
//
//  Created by Justine Gartner on 9/24/15.
//  Copyright © 2015 Justine Gartner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InstaPost : NSObject

@property (nonatomic) NSArray *tags;
@property (nonatomic) NSInteger commentCount;
@property (nonatomic) NSInteger likeCount;
@property (nonatomic) NSString *username;
@property (nonatomic) NSString *fullName;
@property (nonatomic) NSDictionary *caption;

@property (nonatomic) NSString *imageURL;
@property (nonatomic) NSString *avatarImageURL;

-(instancetype)initWithJSON: (NSDictionary *)json;

@end
