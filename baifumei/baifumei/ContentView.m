//
//  ContentView.m
//  baifumei
//
//  Created by Zhu Zhihai on 13-12-9.
//  Copyright (c) 2013年 Zhu Zhihai. All rights reserved.
//

#import "ContentView.h"
#define kloadingImgViewWidth  220
#define kloadingImgViewHeight 100

#define kImgViewPadding_V 10.0f
#define kHeaderViewHeight    44.0f
@implementation ContentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.loadingImgView = [[UIImageView alloc] initWithFrame:[self imageRect]];
        [self.loadingImgView setAutoresizingMask:
         UIViewAutoresizingFlexibleBottomMargin|
         UIViewAutoresizingFlexibleHeight|
         UIViewAutoresizingFlexibleLeftMargin|
         UIViewAutoresizingFlexibleRightMargin|
         UIViewAutoresizingFlexibleTopMargin|
         UIViewAutoresizingFlexibleWidth
         ];
        [self addSubview:self.loadingImgView];
        [self loadingGIF];
        [self setBackgroundColor:kBgColor ];
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        [self.scrollView setAutoresizingMask:
         UIViewAutoresizingFlexibleBottomMargin|
 
         UIViewAutoresizingFlexibleLeftMargin|
         UIViewAutoresizingFlexibleRightMargin|
         UIViewAutoresizingFlexibleTopMargin
         ];
        [self setClipsToBounds:YES];
        [self setContentMode:UIViewContentModeScaleAspectFit];
        [self.scrollView setClipsToBounds:YES];
        [self addSubview:self.scrollView];
        [self.scrollView setHidden:YES];
        
    }
    return self;
}
-(CGRect)imageRect{
    return CGRectMake((self.frame.size.width -kloadingImgViewWidth)*0.5, (self.frame.size.height - kloadingImgViewHeight) * 0.5, kloadingImgViewWidth, kloadingImgViewHeight);
}
-(void)resetImageViewFrame{
    [self.scrollView setHidden:YES];
    [self.loadingImgView setHidden:NO];
    [self.loadingImgView setFrame:[self imageRect]];
}
-(void)loadingGIF{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];
    for (int i = 1; i <= 4; i++) {
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"鱼_第%d祯.png",i]];
        [array addObject:img];
    }
    [self.loadingImgView setImage:[UIImage imageNamed:@"鱼_第1祯.png"]];
    [self.loadingImgView setAnimationImages:array];
    [self.loadingImgView setAnimationDuration:1.5];
    [self.loadingImgView startAnimating];
}
//在接受完毕网络数据时，此处设置view为一个淡入的效果
#pragma mark --- ComUnitDelegate
-(void)comUnitCompleteWith:(NSMutableDictionary *)dicInfo{
     NSLog(@"当前正在加载视图tag____:%d",self.tag);
    [dicInfo enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([obj isKindOfClass: [NSMutableArray class]]) {
            NSMutableArray *a = obj;
            [a enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//                NSLog(@"++++-----%@",obj);
                
            }];
        }
//        else
//            NSLog(@"the key:%@-----%@",key,obj);
    }];
    
    [self contentVeiwRmoveSubViewsOfScrollView];
    //标题行
    NSString *name = [dicInfo valueForKey:kSource_name];
    NSString *icon = [dicInfo valueForKey:kUser_ico];
    NSString *date = [dicInfo valueForKey:kPub_time];
    NSMutableArray *content_Img = [dicInfo objectForKey:kContent_Img];
    HeaderView *headView = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, self.scrollView.bounds.size.width, kHeaderViewHeight) Name:name ImageUrl:icon Date:date];
    [self.scrollView setContentSize:CGSizeMake(self.bounds.size.width,headView.frame.size.height)];
    [self.scrollView addSubview:headView];
    
    //内容
    NSString *contentStr = [dicInfo objectForKey:kTitle];
    CGPoint point = CGPointMake(0, headView.frame.origin.y + headView.frame.size.height);
    DisplayImgView *disImgView = [[DisplayImgView alloc] initWithContentText:contentStr ImgArray:content_Img Position:point Width:self.scrollView.frame.size.width Parent:self.scrollView];
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.contentSize.width,self.scrollView.contentSize.height + disImgView.frame.size.height)];
    [self.scrollView addSubview:disImgView];
    
    //评价
    point = CGPointMake(0,disImgView.frame.origin.y + disImgView.frame.size.height);
    CommentsView *commentView = [[CommentsView alloc] initWithCommentDetails:nil Position:point Width:self.scrollView.frame.size.width];
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.contentSize.width, self.scrollView.contentSize.height + commentView.frame.size.height)];
    [self.scrollView addSubview:commentView];
    [self animationFadeIn];
}
-(void)contentVeiwRmoveSubViewsOfScrollView{
    [[self.scrollView subviews] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIView *v = obj;
        [v removeFromSuperview];
    }];
}
-(void)animationFadeIn{
    [self.scrollView setHidden:NO];
    self.alpha = 0.0f;
//    self.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 1.0f;
    }completion:^(BOOL finished) {
        [self.loadingImgView setHidden:YES];
    }];
}
@end
