//
//  ViewController.m
//  baifumei
//
//  Created by Zhu Zhihai on 13-11-29.
//  Copyright (c) 2013年 Zhu Zhihai. All rights reserved.
//

#import "ViewController.h"

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
    NSLog(@"COMPANY  TEST......");
}
-(void)setConfigure:(UIButton *)sender{
    
}
-(void)selectMenu:(UIButton *)sender{
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UIButton *)actionBtn:(NSString *)title Image:(NSString *)imageName Frame:(CGRect)frame{
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    [btn setBackgroundImage:[UIImage imageNamed:@"白按钮.png"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"白按钮_按下.png"] forState:UIControlStateHighlighted];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    return btn;
}
- (IBAction)rate:(UIButton *)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"cancel", @"取消") destructiveButtonTitle:nil otherButtonTitles:@"",@"", nil];
    [sheet setTag:100];
    
    UIButton *sina_btn = [self actionBtn:NSLocalizedString(@"use weibo login", @"用微博账号登陆") Image:@"新浪微博账号登录.png" Frame:CGRectMake(30, 7, 260, 30)];
    UIButton *ten_btn = [self actionBtn:NSLocalizedString(@"use tengxun login", @"用QQ账号登陆") Image:@"QQ账号登录.png" Frame:CGRectMake(30, 51, 260, 30)];
    [sheet addSubview:sina_btn];
    [sheet addSubview:ten_btn];
    [sheet showInView:self.view];
//    [sheet setFrame:CGRectMake(sheet.frame.origin.x, 180, sheet.frame.size.width, 300)];
}

- (IBAction)share:(UIButton *)sender {
}

- (IBAction)love:(id)sender {
}

- (IBAction)more:(UIButton *)sender {
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
            break;
        }
        case 102:{
            break;
        }
        default:
            break;
    }
}
-(void)rateAction:(NSInteger) buttonIndex{
    
}
-(void)shareAction:(NSInteger ) buttonIndex{
    
}
-(void)loveAction:(NSInteger) buttonIndex{
    
}
-(void)moreAction:(NSInteger)buttonIndex{
    
}
@end
