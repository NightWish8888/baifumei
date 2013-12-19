//
//  CommmentsView.m
//  baifumei
//
//  Created by 肖彦宇 on 13-12-19.
//  Copyright (c) 2013年 Zhu Zhihai. All rights reserved.
//

#import "CommmentsView.h"
#define kImgView_W     280.0f
#define kimgView_H     150.0f
#define kCommentText_W      280.0f
#define kImgViewPadding_V 10.0f
@implementation CommmentsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithCommentCount:(int)count CommentDetails:(NSMutableArray *)details Position:(CGPoint)pos Width:(float)width  Parent:(UIScrollView *)scrollView
{
    self = [super init];
    if (self) {
        if (count == 0) {
            CGRect fRect = (CGRect){{(width - kCommentText_W)*.5,0},{kCommentText_W,20}};
            UILabel *commentLabel = [[UILabel alloc] initWithFrame:fRect];
            [commentLabel setFont:[UIFont systemFontOfSize:15]];
            [commentLabel setText:@"评论：0"];
            fRect = commentLabel.frame;
            [self setFrame:(CGRect){pos,{width,fRect.size.height + kImgViewPadding_V}}];
            [self addSubview:commentLabel];
            
            UIImageView *imgViewLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 1, self.frame.size.width, 1)];
            [imgViewLine setImage:[UIImage imageNamed:@"评论页面分割线.png"]];
            [self addSubview:imgViewLine];
            
            float x = (width - kImgView_W)*.5;
            float y = self.frame.size.height;
            CGPoint imgView_Point = CGPointMake(x, y);
            
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:(CGRect){imgView_Point,CGSizeMake(kImgView_W, kimgView_H)}];
            [imgView setImage:[UIImage imageNamed:@"无评论.png"]];
            [self addSubview:imgView];

             }
             }
             return self;
             }

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
