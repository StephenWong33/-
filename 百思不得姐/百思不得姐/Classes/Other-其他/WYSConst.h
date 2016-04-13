
#import <UIKit/UIKit.h>

typedef enum {
    WYSTopicTypeAll = 1,
    WYSTopicTypePicture = 10,
    WYSTopicTypeWord = 29,
    WYSTopicTypeVoice = 31,
    WYSTopicTypeVideo = 41
} WYSTopicType;

/** 精华-顶部标题的高度 */
UIKIT_EXTERN CGFloat const WYSTitilesViewH;
/** 精华-顶部标题的Y */
UIKIT_EXTERN CGFloat const WYSTitilesViewY;

/** 精华-cell-间距 */
UIKIT_EXTERN CGFloat const WYSTopicCellMargin;
/** 精华-cell-文字内容的Y值 */
UIKIT_EXTERN CGFloat const WYSTopicCellTextY;
/** 精华-cell-底部工具条的高度 */
UIKIT_EXTERN CGFloat const WYSTopicCellBottomBarH;

/** 精华-cell-图片帖子的最大高度 */
UIKIT_EXTERN CGFloat const WYSTopicCellPictureMaxH;
/** 精华-cell-图片帖子一旦超过最大高度,就是用Break */
UIKIT_EXTERN CGFloat const WYSTopicCellPictureBreakH;

/** WYSUser模型-性别属性值 */
UIKIT_EXTERN NSString * const WYSUserSexMale;
UIKIT_EXTERN NSString * const WYSUserSexFemale;

/** 精华-cell-最热评论标题的高度 */
UIKIT_EXTERN CGFloat const WYSTopicCellTopCmtTitleH;

/** tabBar被选中的通知名字 */
UIKIT_EXTERN NSString * const WYSTabBarDidSelectNotification;
/** tabBar被选中的通知 - 被选中的控制器的index key */
UIKIT_EXTERN NSString * const WYSSelectedControllerIndexKey;
/** tabBar被选中的通知 - 被选中的控制器 key */
UIKIT_EXTERN NSString * const WYSSelectedControllerKey;

/** 标签-间距 */
UIKIT_EXTERN CGFloat const WYSTagMargin;
/** 标签-高度 */
UIKIT_EXTERN CGFloat const WYSTagH;

