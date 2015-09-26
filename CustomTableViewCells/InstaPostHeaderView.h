//
//  InstaPostHeaderView.h
//  CustomTableViewCells
//
//  Created by Justine Gartner on 9/26/15.
//  Copyright © 2015 Justine Gartner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InstaPostHeaderView : UITableViewHeaderFooterView

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateStampLabel;

@end
