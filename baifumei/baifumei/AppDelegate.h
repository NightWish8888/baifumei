//
//  AppDelegate.h
//  baifumei
//
//  Created by Zhu Zhihai on 13-11-29.
//  Copyright (c) 2013年 Zhu Zhihai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TencentOpenAPI/QQApi.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <ShareSDK/ShareSDK.h>
#import "WXApi.h"
#import "WBApi.h"
#import "AGViewDelegate.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>{
    enum WXScene _scene;
//    AGViewDelegate *_viewDelegate;
    SSInterfaceOrientationMask _interfaceOrientationMask;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,readonly) AGViewDelegate *viewDelegate;
@property (nonatomic) SSInterfaceOrientationMask interfaceOrientationMask;

@end
