//
//  WYSRecommendCategoryCell.m
//  百思不得姐
//
//  Created by 王亚帅 on 15/7/23.
//  Copyright (c) 2015年 Wong Stethen. All rights reserved.
//

#import "WYSRecommendCategoryCell.h"
#import "WYSRecommendCategory.h"

@interface WYSRecommendCategoryCell()
/** 选中时显示的指示器控件 */
@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;
@end

@implementation WYSRecommendCategoryCell

- (void)awakeFromNib {
    self.backgroundColor = WYSRGBColor(244, 244, 244);
    self.selectedIndicator.backgroundColor = WYSRGBColor(219, 21, 26);

}

- (void)setCategory:(WYSRecommendCategory *)category
{
    _category = category;
    
    self.textLabel.text = category.name;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 重新调整内部textLabel的frame
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 2 * self.textLabel.y;
}

/**
 * 可以在这个方法中监听cell的选中和取消选中
 */
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    self.selectedIndicator.hidden = !selected;
    self.textLabel.textColor = selected ? self.selectedIndicator.backgroundColor : WYSRGBColor(78, 78, 78);
}
@end
