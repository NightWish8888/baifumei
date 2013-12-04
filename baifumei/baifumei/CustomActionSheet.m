//
//  CustomActionSheet.m
//  baifumei
//
//  Created by Zhu Zhihai on 13-12-3.
//  Copyright (c) 2013年 Zhu Zhihai. All rights reserved.
//

#import "CustomActionSheet.h"
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

-(id)initWithArray:(NSMutableArray *)array CancelBtnTitle:(NSString *)cancelTitle{
    self = [super init];
    if (self) {
        btnArray = [NSMutableArray arrayWithArray:array];
        [self addCancelBtn:cancelTitle];
    }
    
    return self;
}
-(void)addCancelBtn:(NSString *)cancelTitle{
    if (cancelTitle && btnArray) {
        UIButton *cancel_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancel_btn setTitle:cancelTitle forState:UIControlStateNormal];
        [cancel_btn setFrame:CGRectMake(0, 0, kbtnWidth, kbtnHeight)];
        [cancel_btn setBackgroundImage:[UIImage imageNamed:@"黑按钮.png"] forState:UIControlStateNormal];
        [cancel_btn setBackgroundImage:[UIImage imageNamed:@"黑按钮按下.png"] forState:UIControlStateHighlighted];
        [cancel_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnArray addObject:cancel_btn];
    }
}
-(void)addItem:(UIControl *)btn{
    if (!btnArray) {
        btnArray = [NSMutableArray arrayWithCapacity:1];
    }
    [btnArray addObject:btn];
}
-(void)layoutSubviews{
    __block float cvH = 0.0f;
    [btnArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIControl *view = (UIControl *)obj;
        cvH += kbtnPadding_V;
        CGRect rect = view.frame;
        view.frame = CGRectMake((ksuperViewWidth - rect.size.width) * .5, cvH, rect.size.width, rect.size.height);
        cvH += view.frame.size.height;
        
        [view setTag:idx];
        
        [view addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    }];
    if (cvH > 0.1) {
        cvH += kbtnPadding_V;
    }
    _customView = [[UIView alloc] initWithFrame:CGRectMake(0, ksuperViewHeight - cvH, ksuperViewWidth, cvH)];
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ActionSheetBG.png"]];
    [bgImageView setFrame:_customView.bounds];
    [_customView addSubview:bgImageView];
    
    [btnArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIView *view = (UIView *)obj;
        [_customView addSubview:view];
    }];

    [self.superview addSubview:_customView];
    [self appearAnimation];
}
-(void)appearAnimation{
    CGPoint currCenter = _customView.center;
    _customView.center = CGPointMake(currCenter.x, currCenter.y + _customView.frame.size.height);
    _customView.alpha = 0.5f;
    [UIView animateWithDuration:0.3 animations:^{
        _customView.center = currCenter;
        _customView.alpha = 1.0f;
    }completion:^(BOOL finished) {
    }];
}
-(void)dismissAnimation{
    CGPoint currCenter = _customView.center;
    [UIView animateWithDuration:0.4 animations:^{
        _customView.center = CGPointMake(currCenter.x, currCenter.y + _customView.frame.size.height);
        _customView.alpha = 0.0f;
    }completion:^(BOOL finished) {
        
    }];
}
-(void)clickAction:(UIControl *)sender{
    NSInteger index = sender.tag;
    [self dismissWithClickedButtonIndex:index animated:YES];
    [self.delegate actionSheet:self clickedButtonAtIndex:index];
    [self dismissAnimation];
}

@end
