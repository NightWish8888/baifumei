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
        [array enumerateObjectsUsingBlock:^(NSString *imgUrl, NSUInteger idx, BOOL *stop) {
            dispatch_queue_t queue = dispatch_queue_create("queue", NULL);
            dispatch_async(queue, ^{
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIImage *img = [UIImage imageWithData:data];
                    
                    float imgView_H = kImgView_W*img.size.height/img.size.width;
                    CGSize imgView_Size = CGSizeMake(kImgView_W, imgView_H);
                    float x = (width - kImgView_W)*.5;
                    float y = self.frame.size.height;
                    
                    CGPoint imgView_Point = CGPointMake(x, y);
                    UIImageView *imgView = [[UIImageView alloc] initWithFrame:(CGRect){imgView_Point,imgView_Size}];
                    [self setFrame:(CGRect){self.frame.origin,{self.frame.size.width,self.frame.size.height + imgView_H + kImgViewPadding_V}}];
                    [imgView setImage:img];
                    [self addSubview:imgView];
                    NSLog(@"__the scrollview size:%@",NSStringFromCGSize(scrollView.contentSize));
                    [scrollView setContentSize:CGSizeMake(scrollView.contentSize.width,scrollView.contentSize.height + imgView_H + kImgViewPadding_V)];
                    NSLog(@"+++the scrollview size:%@",NSStringFromCGSize(scrollView.contentSize));
//                    [self layoutSubviews];
                });
            });
        }];
    }
    return self;
}

@end
