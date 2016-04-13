
#import <UIKit/UIKit.h>

/** 精华-顶部标题的高度 */
CGFloat const WYSTitilesViewH = 35;
/** 精华-顶部标题的Y */
CGFloat const WYSTitilesViewY = 64;

/** 精华-cell-间距 */
CGFloat const WYSTopicCellMargin = 10;
/** 精华-cell-文字内容的Y值 */
CGFloat const WYSTopicCellTextY = 55;
/** 精华-cell-底部工具条的高度 */
CGFloat const WYSTopicCellBottomBarH = 35;

/** 精华-cell-图片帖子的最大高度 */
CGFloat const WYSTopicCellPictureMaxH = 1000;
/** 精华-cell-图片帖子一旦超过最大高度,就是用Break */
CGFloat const WYSTopicCellPictureBreakH = 250;

/** WYSUser模型-性别属性值 */
NSString * const WYSUserSexMale = @"m";
NSString * const WYSUserSexFemale = @"f";

/** 精华-cell-最热评论标题的高度 */
CGFloat const WYSTopicCellTopCmtTitleH = 20;

/** tabBar被选中的通知名字 */
NSString * const WYSTabBarDidSelectNotification = @"WYSTabBarDidSelectNotification";
/** tabBar被选中的通知 - 被选中的控制器的index key */
NSString * const WYSSelectedControllerIndexKey = @"WYSSelectedControllerIndexKey";
/** tabBar被选中的通知 - 被选中的控制器 key */
NSString * const WYSSelectedControllerKey = @"WYSSelectedControllerKey";

/** 标签-间距 */
CGFloat const WYSTagMargin = 5;
/** 标签-高度 */
CGFloat const WYSTagH = 25;