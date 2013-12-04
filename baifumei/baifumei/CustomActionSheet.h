//
//  CustomActionSheet.h
//  baifumei
//
//  Created by Zhu Zhihai on 13-12-3.
//  Copyright (c) 2013年 Zhu Zhihai. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CustomActionSheet : UIActionSheet
{
    NSMutableArray *btnArray;
}
@property (nonatomic,strong) UIView *customView;
-(id)initWithArray:(NSMutableArray *)array CancelBtnTitle:(NSString *)cancelTitle;
-(void)addItem:(UIControl *)btn;
@end
