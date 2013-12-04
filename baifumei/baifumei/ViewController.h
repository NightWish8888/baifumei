//
//  ViewController.h
//  baifumei
//
//  Created by Zhu Zhihai on 13-11-29.
//  Copyright (c) 2013年 Zhu Zhihai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ShareSDK/ShareSDK.h>
#import "CustomActionSheet.h"
#import "AppDelegate.h"

@interface ViewController : UIViewController<UIActionSheetDelegate>
{
    
}
@property (nonatomic,strong) UIButton *menuItem;
- (IBAction)rate:(UIButton *)sender;
- (IBAction)share:(UIButton *)sender;
- (IBAction)love:(id)sender;
- (IBAction)more:(UIButton *)sender;

@end
