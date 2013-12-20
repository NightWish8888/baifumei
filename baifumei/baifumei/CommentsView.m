//
//  CommmentsView.m
//  baifumei
//
//  Created by 肖彦宇 on 13-12-19.
//  Copyright (c) 2013年 Zhu Zhihai. All rights reserved.
//

#import "CommentsView.h"
#define kImgView_W     130.0f
#define kimgView_H     80.0f
#define kCommentText_W      280.0f
#define kImgViewPadding_V   10.0f





#define kRateNum_Lable_Padding_H    5.0f
#define kRateNum_Label_W            100.0f
#define kRateNum_Label_H            30.0f
#define kLineImgView_H              7.0f
#define kNoRateImgView_Padding_V    20.0f
#define kNoRateImgView_W            150.0f
#define kNoRateImgView_H            100.0f

@implementation CommentsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithCommentDetails:(NSMutableArray *)details Position:(CGPoint)pos Width:(float)width
{
    self = [super init];
    if (self) {
        NSInteger count = [details count];
        UILabel *rateNum_Label = [[UILabel alloc] initWithFrame:CGRectMake(kRateNum_Lable_Padding_H, 0, kRateNum_Label_W, kRateNum_Label_H)];
        NSString *rateNumText = [NSString stringWithFormat:@"%@:%d",NSLocalizedString(@"content rate", @"评论"),count];
        [rateNum_Label setText:rateNumText];
        [rateNum_Label setFont:[UIFont boldSystemFontOfSize:13.0f]];
        [rateNum_Label setTextColor:[UIColor blackColor]];
        [self setFrame:(CGRect){pos,{width,rateNum_Label.frame.size.height}}];
        [self addSubview:rateNum_Label];
        
        UIImageView *lineImgView = [[UIImageView alloc] initWithFrame:CGRectMake(rateNum_Label.frame.origin.x, self.frame.size.height, self.frame.size.width - 2*rateNum_Label.frame.origin.x, kLineImgView_H)];
        [lineImgView setImage:[UIImage imageNamed:@"评论页面分割线.png"]];
        [self setFrame:(CGRect){self.frame.origin,{self.frame.size.width,self.frame.size.height + kLineImgView_H}}];
        [self addSubview:lineImgView];
        
        
        
        if (count == 0) {
//            CGRect fRect = (CGRect){{(width - kCommentText_W)*.5,0},{kCommentText_W,20}};
//            UILabel *commentLabel = [[UILabel alloc] initWithFrame:fRect];
//            [commentLabel setFont:[UIFont systemFontOfSize:15]];
//            [commentLabel setText:@"评论：0"];
//            fRect = commentLabel.frame;
//            [self setFrame:(CGRect){pos,{width,fRect.size.height + kImgViewPadding_V}}];
//            [self addSubview:commentLabel];
//            
//            UIImageView *imgViewLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 1, self.frame.size.width, 1)];
//            [imgViewLine setImage:[UIImage imageNamed:@"评论页面分割线.png"]];
//            [self addSubview:imgViewLine];
            
//            float x = (width - kImgView_W)*.5;
//            float y = self.frame.size.height;
//            CGPoint imgView_Point = CGPointMake(x, y);
//            
//            UIImageView *imgView = [[UIImageView alloc] initWithFrame:(CGRect){imgView_Point,CGSizeMake(kImgView_W, kimgView_H)}];
//            [imgView setImage:[UIImage imageNamed:@"无评论.png"]];
//            [self addSubview:imgView];
            UIImageView *noRateImgView = [[UIImageView alloc] initWithFrame:CGRectMake((width-kNoRateImgView_W)*.5, self.frame.size.height + kNoRateImgView_Padding_V, kNoRateImgView_W, kNoRateImgView_H)];
            [noRateImgView setImage:[UIImage imageNamed:@"无评论.png"]];
            [self setFrame:(CGRect){self.frame.origin,{self.frame.size.width,self.frame.size.height + 2*kNoRateImgView_Padding_V + kNoRateImgView_H}}];
            [self addSubview:noRateImgView];
        }
        else{
            //请编写存在评论部分的代码。。。。。、
            //........
            //.........
        }
    }
    return self;
}


@end
