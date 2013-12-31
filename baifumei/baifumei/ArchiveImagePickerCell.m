//
//  ArchiveImagePickerCell.m
//  baifumei
//
//  Created by 肖彦宇 on 13-12-30.
//  Copyright (c) 2013年 Zhu Zhihai. All rights reserved.
//

#import "ArchiveImagePickerCell.h"
#define kCellSize   CGSizeMake(75, 75)
#define kPadding    4
#define kCellHight  79
#define kImgY       2

@implementation ArchiveImagePickerCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)init{
    self = [super init];
    if (self) {
        _btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn1 setFrame:CGRectMake(kPadding, kImgY, kCellSize.width, kCellSize.height)];
        [_btn2 setFrame:CGRectMake(_btn1.frame.origin.x + _btn1.frame.size.width + kPadding, kImgY, kCellSize.width, kCellSize.height)];
        [_btn3 setFrame:CGRectMake(_btn2.frame.origin.x + _btn2.frame.size.width + kPadding, kImgY, kCellSize.width, kCellSize.height)];
        [_btn4 setFrame:CGRectMake(_btn3.frame.origin.x + _btn3.frame.size.width + kPadding, kImgY, kCellSize.width, kCellSize.height)];
        [self addSubview:_btn1];
        [self addSubview:_btn2];
        [self addSubview:_btn3];
        [self addSubview:_btn4];
        
        SEL selector = @selector(selectImg:);
        
        [_btn1 addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
        [_btn2 addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
        [_btn3 addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
        [_btn4 addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(void)selectImg:(UIButton *)sender{
    if (_selectImgDelegate && [_selectImgDelegate respondsToSelector:@selector(selectImg:)]) {
        [_selectImgDelegate selectImg:sender];
    }
}
@end
