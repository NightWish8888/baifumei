//
//  ViewController.m
//  baifumei
//
//  Created by Zhu Zhihai on 13-11-29.
//  Copyright (c) 2013年 Zhu Zhihai. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import "ViewController.h"
#define kbtnWidth       260
#define kbtnHeight      40

@interface ViewController ()

@end

@implementation ViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    srand(time(NULL));
    [self.bgView setBackgroundColor:kBgColor ];
    [self configureContentView];
	[self configureNavItem];
}
-(void)configureContentView{
    CGRect frame = self.contentView.bounds;
    self.contentView1 = [[ContentView alloc] initWithFrame:frame];
    self.contentView2 = [[ContentView alloc] initWithFrame:frame];
    //设置锚点时，frame 的x，y会根据layer的position值重新调整
    [self.contentView1.layer setAnchorPoint:CGPointMake(0.5, 1)];
    [self.contentView2.layer setAnchorPoint:CGPointMake(0.5, 1)];
    
    [self.contentView1 setFrame:frame];
    [self.contentView2 setFrame:frame];
    
    [self.contentView addSubview:self.contentView1];
    [self.contentView addSubview:self.contentView2];
    
    
//    [self.contentView1 setHidden:YES];
//    [self.contentView2 setHidden:YES];
    
}
-(void)configureNavItem{
    float h = self.navigationController.navigationBar.frame.size.height;
    _menuItem = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, h)];
    [_menuItem setTitle:@"白富美那点事" forState:UIControlStateNormal];
    [_menuItem setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_menuItem setImage:[UIImage imageNamed:@"标题下拉箭头_收缩.png"] forState:UIControlStateNormal];
    float imgwidth = _menuItem.imageView.image.size.width;
    float titlewidth = [_menuItem.titleLabel.text sizeWithFont:[UIFont systemFontOfSize:18]].width;
//    float titlewidth = [_menuItem.titleLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:15] forKey:@"UITextAttributeFont"]].width;
    [_menuItem setTitleEdgeInsets:UIEdgeInsetsMake(0, 2*-imgwidth , 0, 0)];
    [_menuItem setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0,2* -titlewidth)];
    [_menuItem addTarget:self action:@selector(selectMenu:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setTitleView:_menuItem];

    
    UIButton *setbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [setbtn setImage:[UIImage imageNamed:@"无头像.png"] forState:UIControlStateNormal];
    [setbtn addTarget:self action:@selector(setConfigure:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *setItem = [[UIBarButtonItem alloc] initWithCustomView:setbtn];
    [self.navigationItem setRightBarButtonItem:setItem];
}

-(void)setConfigure:(UIButton *)sender{
    NSArray *menuItems =
    @[
      [KxMenuItem menuItem:@"账号管理"
                     image:[UIImage imageNamed:@"action_icon"]
                    target:self
                    action:@selector(login:)],
      
      [KxMenuItem menuItem:@"设置"
                     image:[UIImage imageNamed:@"check_icon"]
                    target:self
                    action:@selector(setting:)],
      ];
    
    KxMenuItem *first = menuItems[0];
    first.foreColor = [UIColor colorWithRed:47/255.0f green:112/255.0f blue:225/255.0f alpha:1.0];
    first.alignment = NSTextAlignmentCenter;
    CGRect rect = CGRectMake(sender.frame.origin.x, sender.frame.origin.y+20, sender.frame.size.width, sender.frame.size.height);
    [KxMenu showMenuInView:self.navigationController.view
                  fromRect:rect
                 menuItems:menuItems];
}
-(void)selectMenu:(UIButton *)sender{

    NSArray *menuItems =
    @[
      [KxMenuItem menuItem:@"白富美那点事儿"
                     image:[UIImage imageNamed:@"action_icon"]
                    target:self
                    action:@selector(baifuMeiNaDianShi:)],
      
      [KxMenuItem menuItem:@"时尚港湾"
                     image:[UIImage imageNamed:@"check_icon"]
                    target:self
                    action:@selector(shiShangGangwan:)],
      
      [KxMenuItem menuItem:@"我喜欢的❤️"
                     image:[UIImage imageNamed:@"reload"]
                    target:self
                    action:@selector(myLove:)],
      ];
    
    KxMenuItem *first = menuItems[0];
    first.foreColor = [UIColor colorWithRed:47/255.0f green:112/255.0f blue:225/255.0f alpha:1.0];
    first.alignment = NSTextAlignmentCenter;
    CGRect rect = CGRectMake(sender.frame.origin.x, sender.frame.origin.y+8, sender.frame.size.width, sender.frame.size.height);
    [KxMenu showMenuInView:self.navigationController.view
                  fromRect:rect
                 menuItems:menuItems];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
- (IBAction)rate:(UIButton *)sender {

     UIButton *sina_btn = [self actionBtn:NSLocalizedString(@"use weibo login", @"用微博账号登陆") Image:@"新浪微博账号登录.png" Frame:CGRectMake(0, 0, kbtnWidth, kbtnHeight)  NormalImg:@"白按钮.png" HighlightImg:@"白按钮_按下.png" TitleColor:[UIColor blackColor] TitleEdgeInset:UIEdgeInsetsMake(0, -10, 0, 10)];

     UIButton *ten_btn = [self actionBtn:NSLocalizedString(@"use tengxun login", @"用QQ账号登陆") Image:@"QQ账号登录.png" Frame:CGRectMake(0,0, kbtnWidth, kbtnHeight)  NormalImg:@"白按钮.png" HighlightImg:@"白按钮_按下.png"  TitleColor:[UIColor blackColor] TitleEdgeInset:UIEdgeInsetsMake(0, -10, 0, 10)];
    
    NSMutableArray *btnArray = [ NSMutableArray arrayWithObjects:sina_btn,ten_btn, nil];
    CustomActionSheet *sheet = [[CustomActionSheet alloc] initWithArray:btnArray CancelBtnTitle:NSLocalizedString(@"cancel", @"取消")];
    sheet.delegate = self;
    [sheet setTag:100];
    [sheet showInView:self.view];
}

- (IBAction)share:(UIButton *)sender {
    [Helper menuShare];
}

- (IBAction)love:(id)sender {
}

- (IBAction)more:(UIButton *)sender {
    
    UIButton *reloadBtn = [self actionBtn:NSLocalizedString(@"reload", @"重新载入") Image:nil Frame:CGRectMake(0,0, kbtnWidth, kbtnHeight)  NormalImg:@"白按钮.png" HighlightImg:@"白按钮_按下.png"  TitleColor:[UIColor blackColor] TitleEdgeInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    UIButton *viewWebBtn = [self actionBtn:NSLocalizedString(@"view origin web",@"查看原网页") Image:nil Frame:CGRectMake(0,0, kbtnWidth, kbtnHeight)  NormalImg:@"白按钮.png" HighlightImg:@"白按钮_按下.png"  TitleColor:[UIColor blackColor] TitleEdgeInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    UIButton *returnErrBtn = [self actionBtn:NSLocalizedString(@"return err",@"错误反馈") Image:nil Frame:CGRectMake(0,0, kbtnWidth, kbtnHeight)  NormalImg:@"白按钮.png" HighlightImg:@"白按钮_按下.png"  TitleColor:[UIColor blackColor] TitleEdgeInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    NSMutableArray *btnArray = [ NSMutableArray arrayWithObjects:reloadBtn,viewWebBtn,returnErrBtn, nil];
    CustomActionSheet *sheet = [[CustomActionSheet alloc] initWithArray:btnArray CancelBtnTitle:NSLocalizedString(@"cancel", @"取消")];
    sheet.delegate = self;
    [sheet setTag:101];
    [sheet showInView:self.view];
}

- (IBAction)nextPage:(UIButton *)sender {
    if (sender.tag == 1) {
        sender.tag = 2;
        [self.contentView bringSubviewToFront:self.contentView1];
        self.contentView2.hidden = NO;
        [self animationContentView:self.contentView1];
    }
    else{
        sender.tag = 1;
        [self.contentView bringSubviewToFront:self.contentView2];
        self.contentView1.hidden = NO;
        [self animationContentView:self.contentView2];
    }
}
-(void)animationContentView:(ContentView *)view{
    NSInteger i = rand() % 3;
    switch (i) {
        case 0:
        {
            [self animationScaleType:view];
            break;
        }
        case 1:{
            [self animationTransitionFlip:view];
            break;
        }
        case 2:{
            [self animationTransitionCurl:view];
            break;
        }
        default:
            break;
    }
    
}

-(void)animationScaleType:(ContentView *)view{ //缩放动画
    CGRect rectOld = view.bounds;
    [UIView animateWithDuration:1 animations:^{
        CGRect rect = view.bounds;
        rect.size = CGSizeMake(0, 0);
        view.bounds = rect;
    }completion:^(BOOL finished) {
        view.hidden = YES;
        view.bounds = rectOld;
        [view resetImageViewFrame];
    }];
}
-(void)animationTransitionFlip:(ContentView *)view{ //翻转动画
    [UIView animateWithDuration:1 animations:^
     {
         [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:view cache:YES];
     } completion:^(BOOL finished) {
         view.hidden=YES;
     }];
}
-(void)animationTransitionCurl:(ContentView *)view{ //翻页动画
    [UIView animateWithDuration:1 animations:^
     {
         [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:view cache:YES];
     } completion:^(BOOL finished) {
         view.hidden=YES;
     }];
}
#pragma mark ---UIActionSheet Delegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (actionSheet.tag) {
        case 100:
        {
            [self rateAction:buttonIndex];
            break;
        }
        case 101:{
            [self moreAction:buttonIndex];
            break;
        }
        default:
            break;
    }
}
/*****************下拉菜单*****************/
-(void)baifuMeiNaDianShi:(UIButton *)sender{
    
}
-(void)shiShangGangwan:(UIButton *)sender{
    
}
-(void)myLove:(UIButton *)sender{
    
}
/*****************设置**********************/
-(void)login:(UIButton *)sender{
    [self rate:nil];
}
-(void)setting:(UIButton *)sender{
    SettingViewController *svc = [[SettingViewController alloc] initWithStyle:UITableViewStyleGrouped];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:svc];
    [self presentViewController:nav animated:YES completion:nil];
}
/*****************评价****************/
-(void)rateAction:(NSInteger) buttonIndex{
    if (buttonIndex == 0) {
        [self sina];
    }
    if (buttonIndex == 1) {
        [self qq];
    }
}
-(void)qq{
    //登陆qq接口
    //.........
    NSLog(@"qq......");
}
-(void)sina{
    //登陆新浪接口
    //........
    NSLog(@"sina......");
}
/****************更多*******************/
-(void)moreAction:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
        {
            [self reloadWebView];
            break;
        }
        case 1:{
            [self viewOriginWeb];
            break;
        }
        case 2:{
            [self returnErr];
            break;
        }
        default:
            break;
    }
}
-(void)reloadWebView{
    //重新载入
    //....
    NSLog(@"reloadwebView.....");
}
-(void)viewOriginWeb{
    //查看原始网页
    //.....
    NSLog(@"vieworiginweb......");
}
-(void)returnErr{
    //错误返回
    //.....
    NSLog(@"returnerr.....");
}


#pragma mark ---popView delegate


@end
