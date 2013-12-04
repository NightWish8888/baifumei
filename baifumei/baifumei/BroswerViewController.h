//
//  BroswerViewController.h
//  baifumei
//
//  Created by Zhu Zhihai on 13-12-4.
//  Copyright (c) 2013年 Zhu Zhihai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BroswerViewController : UIViewController
@property (nonatomic,strong) NSString *urlStr;
-(id)initWithUrl:(NSString *)url;
@end
