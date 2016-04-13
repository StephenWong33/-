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

@interface WYSTopicVoiceView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *voicetimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@end

@implementation WYSTopicVoiceView

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;

    // 给图片添加监听器
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
}

- (void)showPicture
{
    WYSShowPictureViewController *showPicture = [[WYSShowPictureViewController alloc] init];
    showPicture.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPicture animated:YES completion:nil];
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
@end
