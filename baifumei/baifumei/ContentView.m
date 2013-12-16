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
        [self.scrollView setContentSize:CGSizeMake(self.bounds.size.width, 480)];
        [self addSubview:self.scrollView];
        [self.scrollView setHidden:YES];
    }
    return self;
}
-(CGRect)imageRect{
    return CGRectMake((self.frame.size.width -kloadingImgViewWidth)*0.5, (self.frame.size.height - kloadingImgViewHeight) * 0.5, kloadingImgViewWidth, kloadingImgViewHeight);
}
-(void)resetImageViewFrame{
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
//    [dicInfo enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
//        if ([obj isKindOfClass: [NSMutableArray class]]) {
//            NSMutableArray *a = obj;
//            [a enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//                NSLog(@"-----%@",obj);
//            }];
//                    }
//        else
//            NSLog(@"-----%@",obj);
//    }];
    [[self.scrollView subviews] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIView *v = obj;
        [v removeFromSuperview];
    }];
    NSString *name = [dicInfo valueForKey:kSource_name];
    NSString *icon = [dicInfo valueForKey:kUser_ico];
    NSString *date = [dicInfo valueForKey:kPub_time];
    HeaderView *headView = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, self.scrollView.bounds.size.width, 60) Name:name ImageUrl:icon Date:date];
    
    [self.scrollView addSubview:headView];
    [self.scrollView setHidden:NO];
//    [self animationFadeIn];
}
-(void)animationFadeIn{
    [self.scrollView setHidden:NO];
    self.alpha = 0.0f;
    self.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 1.0f;
    }completion:^(BOOL finished) {
        
    }];
}
@end
