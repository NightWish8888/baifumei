//
//  Images.h
//  baifumei
//
//  Created by 肖彦宇 on 13-12-25.
//  Copyright (c) 2013年 Zhu Zhihai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Album;

@interface Images : NSManagedObject

@property (nonatomic, retain) NSNumber * albumID;
@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) NSDate * savedDate;
@property (nonatomic, retain) Album *imageForAlbum;

@end
