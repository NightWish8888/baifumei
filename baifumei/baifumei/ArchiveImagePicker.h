//
//  ArchiveImagePicker.h
//  baifumei
//
//  Created by 肖彦宇 on 13-12-30.
//  Copyright (c) 2013年 Zhu Zhihai. All rights reserved.
//

@protocol ArchiveImagePickerDelegate <NSObject>

-(void)selectImgInfo:(UIImage *)img;

@end

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ArchiveImagePickerCell.h"

@interface ArchiveImagePicker : UITableViewController<ArchiveImagePickerCellDelegate>
@property (nonatomic,strong) NSArray *dataSourceArray;
-(id)initWithData:(NSArray *)array Targate:(id<ArchiveImagePickerDelegate>) delegate;
@property (nonatomic,assign) id<ArchiveImagePickerDelegate> imagePickerDelegate;
@end
