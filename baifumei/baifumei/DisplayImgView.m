//
//  DisplayImgView.m
//  baifumei
//
//  Created by Zhu Zhihai on 13-12-17.
//  Copyright (c) 2013年 Zhu Zhihai. All rights reserved.
//

#import "DisplayImgView.h"
#define kImgView_W     280.0f
#define kText_W      280.0f
#define kImgViewPadding_V  10.0f

#define kActivityBgView_W   280.0f
#define kActivityBgView_H   45.0f
@implementation DisplayImgView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(id)initWithContentText:(NSString *)contentStr  ImgArray:(NSMutableArray *)array Position:(CGPoint)pos  Width:(float)width    Parent:(UIScrollView *)scrollView;{
    self = [super init];
    if (self) {

//        CGRect textRect = [contentStr boundingRectWithSize:CGSizeMake(kText_W, 0.0f) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading   attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:15] forKey:@"UITextAttributeFont"] context:nil];
        
        CGRect fRect = (CGRect){{(width - kText_W)*.5,0},{kText_W,0}};
        UILabel *contentStrLabel = [[UILabel alloc] initWithFrame:fRect];
        [contentStrLabel setBackgroundColor:[UIColor clearColor]];
        [contentStrLabel setNumberOfLines:0];
        [contentStrLabel setTextColor:[UIColor blackColor]];
        [contentStrLabel setFont:[UIFont systemFontOfSize:16]];
        [contentStrLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [contentStrLabel setText:contentStr];
        [contentStrLabel sizeToFit];
        fRect = contentStrLabel.frame;
        [self setFrame:(CGRect){pos,{width,fRect.size.height + kImgViewPadding_V}}];
        [self addSubview:contentStrLabel];
        
        
        /************/
        UIView *activityBg = [[UIView alloc] initWithFrame:CGRectMake(contentStrLabel.frame.origin.x, self.frame.size.height, kActivityBgView_W, kActivityBgView_H)];
        [activityBg setBackgroundColor:[UIColor clearColor]];
        UIActivityIndicatorView *ac = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [ac setCenter:CGPointMake(activityBg.frame.size.width*.5, activityBg.frame.size.height*.5)];
        [activityBg addSubview:ac];
        [ac startAnimating];
        [self setFrame:(CGRect){self.frame.origin,{self.frame.size.width,self.frame.size.height + kActivityBgView_H}}];
        [self addSubview:activityBg];
        
        /*************/
        NSInteger count = array.count;
        [array enumerateObjectsUsingBlock:^(NSString *imgUrl, NSUInteger idx, BOOL *stop) {
            dispatch_queue_t queue = dispatch_queue_create("queue", NULL);
            dispatch_async(queue, ^{
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIImage *img = [UIImage imageWithData:data];
                    
                    float imgView_H = kImgView_W*img.size.height/img.size.width;
                    CGSize imgView_Size = CGSizeMake(kImgView_W, imgView_H);
                    
                    float x = (width - kImgView_W)*.5;
                    float y = self.frame.size.height - kActivityBgView_H;
                    CGPoint imgView_Point = CGPointMake(x, y);
                    
                    UIImageView *imgView = [[UIImageView alloc] initWithFrame:(CGRect){imgView_Point,imgView_Size}];
                    
                    float oldH = self.frame.size.height;
                    [self setFrame:(CGRect){self.frame.origin,{self.frame.size.width,self.frame.size.height + imgView_H + kImgViewPadding_V}}];
                    float addH = self.frame.size.height - oldH;
    
                    [imgView setImage:img];
                    [self addSubview:imgView];
                    if (count == idx + 1) {
                        [activityBg removeFromSuperview];
                    }
                    else{
                        [activityBg setCenter:CGPointMake(activityBg.center.x, self.frame.size.height - activityBg.frame.size.height*.5)];
                    }
                    
                    [scrollView setContentSize:CGSizeMake(scrollView.contentSize.width,scrollView.contentSize.height + addH)];
                    
                    [scrollView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                        if ([NSStringFromClass([obj class]) isEqualToString:@"CommentsView"]) {
                            UIView *v = obj;
                            [v setCenter:CGPointMake(v.center.x, scrollView.contentSize.height - v.frame.size.height *.5)];
                            *stop = YES;
                        }
                    }];
                });
            });
        }];
    }
    return self;
}

@end
