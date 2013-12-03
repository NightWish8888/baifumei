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

- (IBAction)rate:(UIButton *)sender {
//    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"cancel", @"取消") destructiveButtonTitle:nil otherButtonTitles:@"",@"", nil];
//    [sheet setTag:100];
//    
//    
//
//    [sheet showInView:self.view];
//    [sheet setFrame:CGRectMake(sheet.frame.origin.x, 180, sheet.frame.size.width, 300)];
    CustomActionSheet *sheet = [[CustomActionSheet alloc] init];
    [sheet showInView:self.view];
}

- (IBAction)share:(UIButton *)sender {
    NSLog(@"Hello!");
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
