//
//  WYSCommentViewController.m
//  百思不得姐
//
//  Created by xiaomage on 15/8/2.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "WYSCommentViewController.h"
#import "WYSTopicCell.h"
#import "WYSTopic.h"
#import <MJRefresh.h>
#import <AFNetworking.h>
#import "WYSComment.h"
#import <MJExtension.h>
#import "WYSCommentHeaderView.h"
#import "WYSCommentCell.h"

static NSString * const WYSCommentId = @"comment";

@interface WYSCommentViewController () <UITableViewDelegate, UITableViewDataSource>
/** 工具条底部间距 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSapce;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** 最热评论 */
@property (nonatomic, strong) NSArray *hotComments;
/** 最新评论 */
@property (nonatomic, strong) NSMutableArray *latestComments;

/** 保存帖子的top_cmt */
@property (nonatomic, strong) WYSComment *saved_top_cmt;

/** 保存当前的页码 */
@property (nonatomic, assign) NSInteger page;

@end

@implementation WYSCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupBasic];

    [self setupHeader];

    [self setupRefresh];
}

- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    [self.tableView.mj_header beginRefreshing];

    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
    self.tableView.mj_footer.hidden = YES;
}

- (void)loadMoreComments
{
    // 页码
    NSInteger page = self.page + 1;

    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"page"] = @(page);
    WYSComment *cmt = [self.latestComments lastObject];
    params[@"lastcid"] = cmt.ID;
    NSString *urlString = @"http://api.budejie.com/api/api_open.php";
    [[WYSHttpTools sharedWYSHttpTools] GET:urlString parameter:params success:^(NSURLSessionDataTask *task, id responseObject) {
        // 没有数据
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            self.tableView.mj_footer.hidden = YES;
            return;
        }

        // 最新评论
        NSArray *newComments = [WYSComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.latestComments addObjectsFromArray:newComments];

        // self.latestComments = @[1, 3, 0, 9]
        // newComments = @[2, 8]
        //        [self.latestComments addObject:newComments];
        // self.latestComments = @[1, 3, 0, 9, @[2, 8]]

        // 页码
        self.page = page;

        // 刷新数据
        [self.tableView reloadData];

        // 控制footer的状态
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.latestComments.count >= total) { // 全部加载完毕
            self.tableView.mj_footer.hidden = YES;
        } else {
            // 结束刷新状态
            [self.tableView.mj_footer endRefreshing];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_footer endRefreshing];
    }];

}

- (void)loadNewComments
{
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @"1";
    NSString *urlString = @"http://api.budejie.com/api/api_open.php";
    [[WYSHttpTools sharedWYSHttpTools] GET:urlString parameter:params success:^(NSURLSessionDataTask *task, id responseObject) {
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            [self.tableView.mj_header endRefreshing];
            return;
        } // 说明没有评论数据

        // 最热评论
        self.hotComments = [WYSComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        // 最新评论
        self.latestComments = [WYSComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];

        // 页码
        self.page = 1;

        // 刷新数据
        [self.tableView reloadData];
        // 结束刷新
        [self.tableView.mj_header endRefreshing];

        // 控制footer的状态
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.latestComments.count >= total) { // 全部加载完毕
            self.tableView.mj_footer.hidden = YES;
        }

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];

}

- (void)setupHeader
{
    // 创建header
    UIView *header = [[UIView alloc] init];

    // 清空top_cmt
    if (self.topic.top_cmt) {
        self.saved_top_cmt = self.topic.top_cmt;
        self.topic.top_cmt = nil;
        [self.topic setValue:@0 forKeyPath:@"cellHeight"];
    }

    // 添加cell
    WYSTopicCell *cell = [WYSTopicCell viewFromXib];
    cell.topic = self.topic;
    cell.size = CGSizeMake(WYSScreenW, self.topic.cellHeight);
    [header addSubview:cell];

    // header的高度
    header.height = self.topic.cellHeight + WYSTopicCellMargin;

    // 设置header
    self.tableView.tableHeaderView = header;
}

- (void)setupBasic
{
    self.title = @"评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" highImage:@"comment_nav_item_share_icon_click" target:nil action:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];

    // cell的高度设置
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;

    // 背景色
    self.tableView.backgroundColor = WYSGlobalBg;

    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WYSCommentCell class]) bundle:nil] forCellReuseIdentifier:WYSCommentId];

    // 去掉分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    // 内边距
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, WYSTopicCellMargin, 0);
}

- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    // 键盘显示\隐藏完毕的frame
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 修改底部约束
    self.bottomSapce.constant = WYSScreenH - frame.origin.y;
    // 动画时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 动画
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    // 恢复帖子的top_cmt
    if (self.saved_top_cmt) {
        self.topic.top_cmt = self.saved_top_cmt;
        [self.topic setValue:@0 forKeyPath:@"cellHeight"];
    }
}

/**
 * 返回第section组的所有评论数组
 */
- (NSArray *)commentsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.hotComments.count ? self.hotComments : self.latestComments;
    }
    return self.latestComments;
}

- (WYSComment *)commentInIndexPath:(NSIndexPath *)indexPath
{
    return [self commentsInSection:indexPath.section][indexPath.row];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latestComments.count;

    if (hotCount) return 2; // 有"最热评论" + "最新评论" 2组
    if (latestCount) return 1; // 有"最新评论" 1 组
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latestComments.count;

    // 隐藏尾部控件
    tableView.mj_footer.hidden = (latestCount == 0);

    if (section == 0) {
        return hotCount ? hotCount : latestCount;
    }

    // 非第0组
    return latestCount;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // 先从缓存池中找header
    WYSCommentHeaderView *header = [WYSCommentHeaderView headerViewWithTableView:tableView];

    // 设置label的数据
    NSInteger hotCount = self.hotComments.count;
    if (section == 0) {
        header.title = hotCount ? @"最热评论" : @"最新评论";
    } else {
        header.title = @"最新评论";
    }
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WYSCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:WYSCommentId];

    cell.comment = [self commentInIndexPath:indexPath];

    return cell;
}

#pragma mark - <UITableViewDelegate>
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];

    [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIMenuController *menu = [UIMenuController sharedMenuController];
    if (menu.isMenuVisible) {
        [menu setMenuVisible:NO animated:YES];
    } else {
        // 被点击的cell
        WYSCommentCell *cell = (WYSCommentCell *)[tableView cellForRowAtIndexPath:indexPath];
        // 出现一个第一响应者
        [cell becomeFirstResponder];

        // 显示MenuController
        UIMenuItem *ding = [[UIMenuItem alloc] initWithTitle:@"顶" action:@selector(ding:)];
        UIMenuItem *replay = [[UIMenuItem alloc] initWithTitle:@"回复" action:@selector(replay:)];
        UIMenuItem *report = [[UIMenuItem alloc] initWithTitle:@"举报" action:@selector(report:)];
        menu.menuItems = @[ding, replay, report];
        CGRect rect = CGRectMake(0, cell.height * 0.5, cell.width, cell.height * 0.5);
        [menu setTargetRect:rect inView:cell];
        [menu setMenuVisible:YES animated:YES];
    }
}

#pragma mark - MenuItem处理
- (void)ding:(UIMenuController *)menu
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSLog(@"%s %@", __func__, [self commentInIndexPath:indexPath].content);
}

- (void)replay:(UIMenuController *)menu
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSLog(@"%s %@", __func__, [self commentInIndexPath:indexPath].content);
}

- (void)report:(UIMenuController *)menu
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSLog(@"%s %@", __func__, [self commentInIndexPath:indexPath].content);
}
@end
