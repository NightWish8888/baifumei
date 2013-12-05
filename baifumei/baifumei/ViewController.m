//
//  ViewController.m
//  baifumei
//
//  Created by Zhu Zhihai on 13-11-29.
//  Copyright (c) 2013年 Zhu Zhihai. All rights reserved.
//

#import "ViewController.h"
#define kbtnWidth       260
#define kbtnHeight      40

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self configureNavItem];
}
-(void)configureNavItem{
    float h = self.navigationController.navigationBar.frame.size.height;
    _menuItem = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, h)];
    [_menuItem setTitle:@"白富美那点事" forState:UIControlStateNormal];
    [_menuItem setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_menuItem setImage:[UIImage imageNamed:@"标题下拉箭头_收缩.png"] forState:UIControlStateNormal];
    float imgwidth = _menuItem.imageView.image.size.width;
    float titlewidth = [_menuItem.titleLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:15] forKey:@"UITextAttributeFont"]].width;
    [_menuItem setTitleEdgeInsets:UIEdgeInsetsMake(0, 2*-imgwidth , 0, 0)];
    [_menuItem setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0,3* -titlewidth)];
    [_menuItem addTarget:self action:@selector(selectMenu:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setTitleView:_menuItem];

    
    UIButton *setbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [setbtn setImage:[UIImage imageNamed:@"无头像.png"] forState:UIControlStateNormal];
    [setbtn addTarget:self action:@selector(setConfigure:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *setItem = [[UIBarButtonItem alloc] initWithCustomView:setbtn];
    [self.navigationItem setRightBarButtonItem:setItem];
}
-(void)setConfigure:(UIButton *)sender{
    
}
-(void)selectMenu:(UIButton *)sender{
    WEPopoverController *pop = [[WEPopoverController alloc] initWithContentViewController:self];
    pop.delegate = self;
    if ([pop respondsToSelector:@selector(setContainerViewProperties:)]) {
        [pop setContainerViewProperties:[self improvedContainerViewProperties]];
    }
    pop.passthroughViews = [NSArray arrayWithObject:self.navigationController.navigationBar];
    [pop presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionUp  animated:YES];
}
- (WEPopoverContainerViewProperties *)improvedContainerViewProperties {
	
	WEPopoverContainerViewProperties *props = [WEPopoverContainerViewProperties alloc];
	NSString *bgImageName = nil;
	CGFloat bgMargin = 0.0;
	CGFloat bgCapSize = 0.0;
	CGFloat contentMargin = 4.0;
	
	bgImageName = @"popoverBg.png";
	
	// These constants are determined by the popoverBg.png image file and are image dependent
	bgMargin = 13; // margin width of 13 pixels on all sides popoverBg.png (62 pixels wide - 36 pixel background) / 2 == 26 / 2 == 13
	bgCapSize = 31; // ImageSize/2  == 62 / 2 == 31 pixels
	
	props.leftBgMargin = bgMargin;
	props.rightBgMargin = bgMargin;
	props.topBgMargin = bgMargin;
	props.bottomBgMargin = bgMargin;
	props.leftBgCapSize = bgCapSize;
	props.topBgCapSize = bgCapSize;
	props.bgImageName = bgImageName;
	props.leftContentMargin = contentMargin;
	props.rightContentMargin = contentMargin - 1; // Need to shift one pixel for border to look correct
	props.topContentMargin = contentMargin;
	props.bottomContentMargin = contentMargin;
	
	props.arrowMargin = 4.0;
	
	props.upArrowImageName = @"popoverArrowUp.png";
	props.downArrowImageName = @"popoverArrowDown.png";
	props.leftArrowImageName = @"popoverArrowLeft.png";
	props.rightArrowImageName = @"popoverArrowRight.png";
	return props;
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



@end
