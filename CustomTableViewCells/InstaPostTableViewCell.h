//
//  InstaPostTableViewCell.h
//  CustomTableViewCells
//
//  Created by Justine Gartner on 9/24/15.
//  Copyright © 2015 Justine Gartner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InstaPostTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *likesLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagsLabel;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *fullName;
@property (weak, nonatomic) IBOutlet UIImageView *userMediaImageView;

@end
