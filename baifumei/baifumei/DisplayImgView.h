//
//  DisplayImgView.h
//  baifumei
//
//  Created by Zhu Zhihai on 13-12-17.
//  Copyright (c) 2013年 Zhu Zhihai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DisplayImgView : UIView
-(id)initWithContentText:(NSString *)text  ImgArray:(NSMutableArray *)array Position:(CGPoint)pos Width:(float)width  Parent:(UIScrollView *)scrollView;
@end
