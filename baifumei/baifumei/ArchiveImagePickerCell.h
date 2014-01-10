//
//  ArchiveImagePickerCell.h
//  baifumei
//
//  Created by 肖彦宇 on 13-12-30.
//  Copyright (c) 2013年 Zhu Zhihai. All rights reserved.
//

@protocol ArchiveImagePickerCellDelegate <NSObject>

-(void)selectImg:(UIButton *)sender;

@end

#import <UIKit/UIKit.h>

@interface ArchiveImagePickerCell : UITableViewCell
@property (nonatomic,strong) UIButton *btn1;
@property (nonatomic,strong) UIButton *btn2;
@property (nonatomic,strong) UIButton *btn3;
@property (nonatomic,strong) UIButton *btn4;
@property (nonatomic,assign) id<ArchiveImagePickerCellDelegate> selectImgDelegate;
-(id)init;
@end
