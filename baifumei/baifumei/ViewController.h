//
//  ViewController.h
//  baifumei
//
//  Created by Zhu Zhihai on 13-11-29.
//  Copyright (c) 2013年 Zhu Zhihai. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CustomActionSheet.h"
#import "Helper.h"
#import "KxMenu.h"
#import "SettingViewController.h"
#import "ContentView.h"
@interface ViewController : UIViewController<UIActionSheetDelegate>
{

}
@property (nonatomic,strong) UIButton *menuItem;
@property (nonatomic,strong) ContentView *contentView1;
@property (nonatomic,strong) ContentView *contentView2;

@property (weak, nonatomic) IBOutlet UIView *contentView;


- (IBAction)rate:(UIButton *)sender;
- (IBAction)share:(UIButton *)sender;
- (IBAction)love:(id)sender;
- (IBAction)more:(UIButton *)sender;
- (IBAction)nextPage:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UIView *bgView;

@end
