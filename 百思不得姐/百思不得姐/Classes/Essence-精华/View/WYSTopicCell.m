//
//  WYSTopicCell.m
//  百思不得姐
//
//  Created by 王亚帅 on 15/7/27.
//  Copyright (c) 2015年 Wong Stethen. All rights reserved.
//

#import "WYSTopicCell.h"
#import "WYSTopic.h"
#import <UIImageView+WebCache.h>
#import "WYSTopicPictureView.h"
#import "WYSTopicVoiceView.h"
#import "WYSTopicVideoView.h"
#import "WYSComment.h"
#import "WYSUser.h"
#import "WYSLoginTool.h"

@interface WYSTopicCell() <UIActionSheetDelegate>
/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
/** 昵称 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 时间 */
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
/** 顶 */
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
/** 踩 */
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
/** 分享 */
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
/** 评论 */
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
/** 新浪加V */
@property (weak, nonatomic) IBOutlet UIImageView *sinaVView;
/** 帖子的文字内容 */
@property (weak, nonatomic) IBOutlet UILabel *text_label;
/** 图片帖子中间的内容 */
@property (nonatomic, weak) WYSTopicPictureView *pictureView;
/** 声音帖子中间的内容 */
@property (nonatomic, weak) WYSTopicVoiceView *voiceView;
/** 视频帖子中间的内容 */
@property (nonatomic, weak) WYSTopicVideoView *videoView;
/** 最热评论的内容 */
@property (weak, nonatomic) IBOutlet UILabel *topCmtContentLabel;
/** 最热评论的整体 */
@property (weak, nonatomic) IBOutlet UIView *topCmtView;
@end

@implementation WYSTopicCell

- (WYSTopicPictureView *)pictureView
{
    if (!_pictureView) {
        WYSTopicPictureView *pictureView = [WYSTopicPictureView viewFromXib];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (WYSTopicVoiceView *)voiceView
{
    if (!_voiceView) {
        WYSTopicVoiceView *voiceView = [WYSTopicVoiceView viewFromXib];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

- (WYSTopicVideoView *)videoView
{
    if (!_videoView) {
        WYSTopicVideoView *videoView = [WYSTopicVideoView viewFromXib];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}

- (void)awakeFromNib
{
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;

    //    self.profileImageView.layer.cornerRadius = self.profileImageView.width * 0.5;
    //    self.profileImageView.layer.masksToBounds = YES;
}

- (void)setTopic:(WYSTopic *)topic
{
    _topic = topic;

    // 新浪加V
    self.sinaVView.hidden = !topic.isSina_v;

    // 设置头像
    [self.profileImageView setHeader:topic.profile_image];

    // 设置名字
    self.nameLabel.text = topic.name;

    // 设置帖子的创建时间
    self.createTimeLabel.text = topic.create_time;

    // 设置按钮文字
    [self setupButtonTitle:self.dingButton count:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton count:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.shareButton count:topic.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentButton count:topic.comment placeholder:@"评论"];

    // 设置帖子的文字内容
    self.text_label.text = topic.text;

    // 根据模型类型(帖子类型)添加对应的内容到cell的中间
    if (topic.type == WYSTopicTypePicture) { // 图片帖子
        self.pictureView.hidden = NO;
        self.pictureView.topic = topic;
        self.pictureView.frame = topic.pictureF;

        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    } else if (topic.type == WYSTopicTypeVoice) { // 声音帖子
        self.voiceView.hidden = NO;
        self.voiceView.topic = topic;
        self.voiceView.frame = topic.voiceF;

        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
    } else if (topic.type == WYSTopicTypeVideo) { // 视频帖子
        self.videoView.hidden = NO;
        self.videoView.topic = topic;
        self.videoView.frame = topic.videoF;

        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    } else { // 段子帖子
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    }

    // 处理最热评论
    if (topic.top_cmt) {
        self.topCmtView.hidden = NO;
        self.topCmtContentLabel.text = [NSString stringWithFormat:@"%@ : %@", topic.top_cmt.user.username, topic.top_cmt.content];
    } else {
        self.topCmtView.hidden = YES;
    }
}

/**
 * 设置底部按钮文字
 */
- (void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder
{
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
    } else if (count > 0) {
        placeholder = [NSString stringWithFormat:@"%zd", count];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height = self.topic.cellHeight - WYSTopicCellMargin;
    frame.origin.y += WYSTopicCellMargin;

    [super setFrame:frame];
}

- (IBAction)more {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"收藏", @"举报", nil];
    [sheet showInView:self.window];

}

#pragma mark - <UIActionSheetDelegate>
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 2) return;

    if ([WYSLoginTool getUid] == nil) return;

    // 开始执行举报\收藏操作
}
@end
