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

@end
