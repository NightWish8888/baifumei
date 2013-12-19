//
//  CommmentsView.h
//  baifumei
//
//  Created by 肖彦宇 on 13-12-19.
//  Copyright (c) 2013年 Zhu Zhihai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentsView : UIView

-(id)initWithCommentCount:(int)count CommentDetails:(NSMutableArray *)details Position:(CGPoint)pos Width:(float)width  Parent:(UIScrollView *)scrollView;
@end
