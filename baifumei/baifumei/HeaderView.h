//
//  HeaderView.h
//  baifumei
//
//  Created by Zhu Zhihai on 13-12-15.
//  Copyright (c) 2013年 Zhu Zhihai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderView : UIView
@property (nonatomic,strong) UIImageView *iconImageView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *dateLabel;
-(id)initWithFrame:(CGRect)frame Name:(NSString *)name ImageUrl:(NSString *)imgUrl Date:(NSString *)dateStr;
@end
