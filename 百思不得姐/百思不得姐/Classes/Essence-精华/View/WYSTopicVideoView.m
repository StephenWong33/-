//
//  WYSTopicVideoView.m
//  百思不得姐
//
//  Created by 王亚帅 on 15/7/30.
//  Copyright (c) 2015年 Wong Stethen. All rights reserved.
//

#import "WYSTopicVideoView.h"
#import "WYSTopic.h"
#import <UIImageView+WebCache.h>
#import "WYSShowPictureViewController.h"
#import "WYSVideoPlayView.h"

@interface WYSTopicVideoView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videotimeLabel;
/** 视频播放器**/
@property(nonatomic,strong) WYSVideoPlayView *player;
/** 视频播放器按钮**/
@property (weak, nonatomic) IBOutlet UIButton *playButtton;

@end

@implementation WYSTopicVideoView


-(WYSVideoPlayView *)player
{
    if (_player == nil) {
        WYSVideoPlayView *viewPlayView = [WYSVideoPlayView videoPlayView];
        viewPlayView.frame = self.imageView.bounds;
        [self.imageView addSubview:viewPlayView];
        _player = viewPlayView;
    }
    return _player;
}

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    self.imageView.userInteractionEnabled = YES;
}

- (IBAction)playVideo:(UIButton *)sender {

    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:self.topic.videouri]];
    [self.player setPlayerItem:item];
    self.playButtton.hidden = YES;
    self.playcountLabel.hidden = YES;
    self.videotimeLabel.hidden = YES;


}

- (void)setTopic:(WYSTopic *)topic
{
    _topic = topic;

    // 图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];

    // 播放次数
    self.playcountLabel.text = [NSString stringWithFormat:@"%zd播放", topic.playcount];

    // 时长
    NSInteger minute = topic.videotime / 60;
    NSInteger second = topic.videotime % 60;
    self.videotimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", minute, second];
}
@end
