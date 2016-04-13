//
//  WYSRecommendTagsViewController.m
//  百思不得姐
//
//  Created by 王亚帅 on 15/7/23.
//  Copyright (c) 2015年 Wong Stethen. All rights reserved.
//

#import "WYSRecommendTagsViewController.h"
#import "WYSRecommendTag.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import "WYSRecommendTagCell.h"

@interface WYSRecommendTagsViewController ()
/** 标签数据 */
@property (nonatomic, strong) NSArray *tags;
@end

static NSString * const WYSTagsId = @"tag";

@implementation WYSRecommendTagsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    [self loadTags];
}

- (void)loadTags
{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    // 发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        self.tags = [WYSRecommendTag mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
        
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载标签数据失败!"];
    }];
}

- (void)setupTableView
{
    self.title = @"推荐标签";
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WYSRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:WYSTagsId];
    self.tableView.rowHeight = 70;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = WYSGlobalBg;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WYSRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:WYSTagsId];
    
    cell.recommendTag = self.tags[indexPath.row];
    
    return cell;
}

@end
