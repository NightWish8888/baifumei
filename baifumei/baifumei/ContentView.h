//
//  ContentView.h
//  baifumei
//
//  Created by Zhu Zhihai on 13-12-9.
//  Copyright (c) 2013年 Zhu Zhihai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ComUnit.h"
#import "HeaderView.h"
#import "DisplayImgView.h"
#import "CommentsView.h"
@interface ContentView : UIView<ComUnitDelegate>{
    
}
@property (strong, nonatomic)UIImageView *loadingImgView;
@property (strong, nonatomic) UIScrollView *scrollView;

-(void)resetImageViewFrame;
@end
