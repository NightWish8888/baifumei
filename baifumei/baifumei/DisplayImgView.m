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

#define kbtnWidth       260
#define kbtnHeight      40

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
//        [self addGestureRecognizer:longPressed];
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
                    
                    //手势事件
                    UILongPressGestureRecognizer *longPressed = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleImageViewLongPressed:)];
                    longPressed.delegate = self;
                    longPressed.minimumPressDuration = .5f;
                    
                    float oldH = self.frame.size.height;
                    [self setFrame:(CGRect){self.frame.origin,{self.frame.size.width,self.frame.size.height + imgView_H + kImgViewPadding_V}}];
                    float addH = self.frame.size.height - oldH;
    
                    [imgView setImage:img];
                    [imgView setUserInteractionEnabled:YES];
                    [imgView addGestureRecognizer:longPressed];
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

-(void)handleImageViewLongPressed:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        if ([gestureRecognizer.view isKindOfClass:[UIImageView class]]) {
            UIImageView *imageView = (UIImageView *)gestureRecognizer.view;
            UIImage *image = imageView.image;
            imageData = UIImageJPEGRepresentation(image, 1);
            UIButton *saveImageBtn = [self actionBtn:NSLocalizedString(@"save image", @"保存图片") Image:nil Frame:CGRectMake(0,0, kbtnWidth, kbtnHeight)  NormalImg:@"白按钮.png" HighlightImg:@"白按钮_按下.png"  TitleColor:[UIColor blackColor] TitleEdgeInset:UIEdgeInsetsMake(0, 0, 0, 0)];
            NSMutableArray *btnArray = [ NSMutableArray arrayWithObjects:saveImageBtn, nil];
            CustomActionSheet *sheet = [[CustomActionSheet alloc] initWithArray:btnArray CancelBtnTitle:NSLocalizedString(@"cancel", @"取消")];
            sheet.delegate = self;
            [sheet showInView:self];
                    }
    }
}

-(UIButton *)actionBtn:(NSString *)title Image:(NSString *)imageName Frame:(CGRect)frame  NormalImg:(NSString *)normalImg HighlightImg:(NSString *)highlightImg TitleColor:(UIColor *)color TitleEdgeInset:(UIEdgeInsets)titleEdgeInsets{
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:frame];
    [btn setBackgroundImage:[UIImage imageNamed:normalImg] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highlightImg] forState:UIControlStateHighlighted];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -40, 0, 40)];
    [btn setTitleEdgeInsets:titleEdgeInsets];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:19]];
    return btn;
}

#pragma mark ---UIActionSheet Delegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0) {
        NSManagedObjectContext *context = [DBManager shareContext];
        [context lock];
        Images *img = [NSEntityDescription insertNewObjectForEntityForName:@"Images" inManagedObjectContext:context];
        [img setAlbumID:[NSNumber numberWithInt:1]];
        [img setImage:imageData];
        [img setSavedDate:[NSDate date]];
        [context save:nil];
        [context unlock];
        NSLog(@"----------- save successed");
    }
}

@end
