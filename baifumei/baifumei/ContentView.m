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
        self.loadingImgView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width -kloadingImgViewWidth)*0.5, (frame.size.height - kloadingImgViewHeight) * 0.5, kloadingImgViewWidth, kloadingImgViewHeight)];
        [self addSubview:self.loadingImgView];
        [self loadingGIF];
        [self setBackgroundColor:kBgColor ];
    }
    return self;
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

@end
