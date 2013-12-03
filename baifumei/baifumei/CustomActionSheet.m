//
//  CustomActionSheet.m
//  baifumei
//
//  Created by Zhu Zhihai on 13-12-3.
//  Copyright (c) 2013年 Zhu Zhihai. All rights reserved.
//

#import "CustomActionSheet.h"
#define kcustomViewHeight    200.0f
#define kbtnWidth       260
#define kbtnHeight      40
#define kbtnPadding_V        20
#define ksuperViewHeight    self.superview.frame.size.height
#define ksuperViewWidth     self.superview.frame.size.width

@implementation CustomActionSheet

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


-(UIButton *)actionBtn:(NSString *)title Image:(NSString *)imageName Frame:(CGRect)frame action:(SEL)selecter NormalImg:(NSString *)normalImg HighlightImg:(NSString *)highlightImg TitleColor:(UIColor *)color TitleEdgeInset:(UIEdgeInsets)titleEdgeInsets{
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:frame];
    [btn setBackgroundImage:[UIImage imageNamed:normalImg] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highlightImg] forState:UIControlStateHighlighted];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -40, 0, 40)];
    [btn setTitleEdgeInsets:titleEdgeInsets];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn addTarget:self action:selecter forControlEvents:UIControlEventTouchUpInside];
    [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:19]];
    return btn;
}

- (void)drawRect:(CGRect)rect
{
  
}
-(void)layoutSubviews{
    _customView = [[UIView alloc] initWithFrame:CGRectMake(0, ksuperViewHeight - kcustomViewHeight, ksuperViewWidth, kcustomViewHeight)];
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ActionSheetBG.png"]];
    [bgImageView setFrame:_customView.bounds];
    [_customView addSubview:bgImageView];
    
    UIButton *sina_btn = [self actionBtn:NSLocalizedString(@"use weibo login", @"用微博账号登陆") Image:@"新浪微博账号登录.png" Frame:CGRectMake((ksuperViewWidth-kbtnWidth)*.5, kbtnPadding_V, kbtnWidth, kbtnHeight) action:@selector(Sina:) NormalImg:@"白按钮.png" HighlightImg:@"白按钮_按下.png" TitleColor:[UIColor blackColor] TitleEdgeInset:UIEdgeInsetsMake(0, -10, 0, 10)];
    
    float ten_y = sina_btn.frame.origin.y + sina_btn.frame.size.height + kbtnPadding_V;
    UIButton *ten_btn = [self actionBtn:NSLocalizedString(@"use tengxun login", @"用QQ账号登陆") Image:@"QQ账号登录.png" Frame:CGRectMake((ksuperViewWidth-kbtnWidth)*.5,ten_y, kbtnWidth, kbtnHeight) action:@selector(QQ:) NormalImg:@"白按钮.png" HighlightImg:@"白按钮_按下.png"  TitleColor:[UIColor blackColor] TitleEdgeInset:UIEdgeInsetsMake(0, -10, 0, 10)];
    
    float cancel_y = ten_btn.frame.origin.y + ten_btn.frame.size.height + kbtnPadding_V;
    UIButton *cancel_btn = [self actionBtn:NSLocalizedString(@"cancel", @"取消") Image:nil Frame:CGRectMake((ksuperViewWidth-kbtnWidth)*.5,cancel_y, kbtnWidth, kbtnHeight) action:@selector(cancel:) NormalImg:@"黑按钮.png" HighlightImg:@"黑按钮.png"  TitleColor:[UIColor whiteColor] TitleEdgeInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    [_customView addSubview:sina_btn];
    [_customView addSubview:ten_btn];
    [_customView addSubview:cancel_btn];
    [self.superview addSubview:_customView];
    
    [self appearAnimation];
}
-(void)appearAnimation{
    CGPoint currCenter = _customView.center;
    _customView.center = CGPointMake(currCenter.x, currCenter.y + _customView.frame.size.height);
    [UIView animateWithDuration:0.3 animations:^{
        _customView.center = currCenter;
    }completion:^(BOOL finished) {
        
    }];
}
-(void)dismissAnimation{
    CGPoint currCenter = _customView.center;
    [UIView animateWithDuration:0.3 animations:^{
        _customView.center = CGPointMake(currCenter.x, currCenter.y + _customView.frame.size.height);
    }completion:^(BOOL finished) {
        
    }];
}
-(void)QQ:(UIButton *)sender{
    [self dismissWithClickedButtonIndex:1 animated:YES];
    [self.delegate actionSheet:self clickedButtonAtIndex:1];
    [self dismissAnimation];
}
-(void)Sina:(UIButton *)sender{
    [self dismissWithClickedButtonIndex:0 animated:YES];
    [self.delegate actionSheet:self clickedButtonAtIndex:0];
    [self dismissAnimation];
}
-(void)cancel:(UIButton *)sender{
    [self dismissWithClickedButtonIndex:2 animated:YES];
    [self.delegate actionSheet:self clickedButtonAtIndex:2];
    [self dismissAnimation];
}
@end
