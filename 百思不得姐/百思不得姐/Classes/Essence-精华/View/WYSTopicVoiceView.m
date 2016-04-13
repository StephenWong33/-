//
//  WYSTopicVoiceView.m
//  百思不得姐
//
//  Created by 王亚帅 on 15/7/30.
//  Copyright (c) 2015年 Wong Stethen. All rights reserved.
//

#import "WYSTopicVoiceView.h"
#import "WYSTopic.h"
#import <UIImageView+WebCache.h>
#import "WYSShowPictureViewController.h"
#import "WYSVideoPlayView.h"

@interface WYSTopicVoiceView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *voicetimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
/** 音频放器**/
@property(nonatomic,strong) WYSVideoPlayView *player;
/** 音频播放器按钮**/
@property (weak, nonatomic) IBOutlet UIButton *playButton;


@end

@implementation WYSTopicVoiceView

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;

    // 给图片添加监听器
    self.imageView.userInteractionEnabled = YES;

}

-(WYSVideoPlayView *)player
{
    if (_player == nil) {
        WYSVideoPlayView *viewPlayView = [WYSVideoPlayView videoPlayView];
        viewPlayView.frame = self.imageView.bounds;
        [self.imageView addSubview:viewPlayView];
        [viewPlayView setValue:self.imageView.image forKeyPath:@"_imageView.image"];
        [viewPlayView setValue:@"YES" forKeyPath:@"fullScreenButton.hidden"];
        _player = viewPlayView;
    }
    return _player;
}


- (void)setTopic:(WYSTopic *)topic
{
    _topic = topic;

    // 图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];

    // 播放次数
    self.playcountLabel.text = [NSString stringWithFormat:@"%zd播放", topic.playcount];

    // 时长
    NSInteger minute = topic.voicetime / 60;
    NSInteger second = topic.voicetime % 60;
    self.voicetimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", minute, second];
}

- (IBAction)playVoice:(UIButton *)sender {

    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:self.topic.voiceuri]];
    [self.player setPlayerItem:item];
    self.playButton.hidden = YES;
    self.playcountLabel.hidden = YES;
    self.voicetimeLabel.hidden = YES;
    
}


@end
