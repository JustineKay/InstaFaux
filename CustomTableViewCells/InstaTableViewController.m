//
//  InstaTableViewController.m
//  CustomTableViewCells
//
//  Created by Justine Gartner on 9/24/15.
//  Copyright © 2015 Justine Gartner. All rights reserved.
//

#import "InstaTableViewController.h"
#import "APIManager.h"
#import "InstaPost.h"
#import "InstaPostTableViewCell.h"
#import <AFNetworking/AFNetworking.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "InstaPostHeaderView.h"

@interface InstaTableViewController ()

@property (nonatomic) NSMutableArray *searchResults;

@end

@implementation InstaTableViewController

-(void)pulledToRefresh: (UIRefreshControl *)sender{
    [self fetchInstagramData];
    [sender endRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self fetchInstagramData];
    
    //set up pull to refresh
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(pulledToRefresh:) forControlEvents:UIControlEventValueChanged];
    
    //tell the table view to auto adjust the height of each cell
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44;
    
    
    
    //grab the nib from the main bundle
    UINib *nib = [UINib nibWithNibName:@"InstaPostTableViewCell" bundle:nil];
    
    //register the nib for the cell identifier
    [self.tableView registerNib:nib forCellReuseIdentifier:@"InstaPostCellIdentifier"];
    
    //do the same thing here in one line:
    [self.tableView registerNib:[UINib nibWithNibName:@"InstaPostHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"InstaPostHeaderIdentifier"];
    
}

- (IBAction)refreshButtonTapped:(UIBarButtonItem *)sender {
    
    [self fetchInstagramData];
}


-(void)fetchInstagramData{
    
    //create an instagram url
    NSString *instagramURL = @"https://api.instagram.com/v1/tags/wanderlust/media/recent?client_id=ac0ee52ebb154199bfabfb15b498c067";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:instagramURL parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSArray *results = responseObject[@"data"];
        
        //reset my array
        self.searchResults = [[NSMutableArray alloc] init];
        
        //loop through all posts
        for (NSDictionary *result in results){
            
            //create new post from json
            InstaPost *post = [[InstaPost alloc] initWithJSON:result];
            
            //add post to array
            [self.searchResults addObject:post];
        }
        
        NSLog(@"%@", responseObject);
        
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
    
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.searchResults.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    InstaPostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InstaPostCellIdentifier" forIndexPath:indexPath];
    
    InstaPost *post = self.searchResults[indexPath.section];
    
    cell.usernameLabel.text = [NSString stringWithFormat:@"@%@", post.username];
    cell.likesLabel.text = [NSString stringWithFormat:@"Likes: %ld",post.likeCount];
    cell.tagsLabel.text = [NSString stringWithFormat:@"Tags: %ld", post.tags.count];
    cell.captionLabel.text = post.caption[@"text"];
    cell.fullName.text = post.fullName;
    
    NSURL *url = [NSURL URLWithString:post.imageURL];
    
    [cell.userMediaImageView sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        cell.userMediaImageView.image = image;
    }];
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    InstaPostHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"InstaPostHeaderIdentifier"];
    
    InstaPost *post = self.searchResults[section];
    
    headerView.usernameLabel.text = post.username;
    headerView.fullNameLabel.text = post.fullName;
    
    headerView.backgroundView = [[UIView alloc] initWithFrame:headerView.bounds];
    headerView.backgroundView.backgroundColor = [UIColor whiteColor];
    
    
    NSURL *avatarURL = [NSURL URLWithString:post.avatarImageURL];
    
    [headerView.imageView sd_setImageWithURL:avatarURL completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        headerView.imageView.image = image;
    }];
    
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 60.0;
}


@end
