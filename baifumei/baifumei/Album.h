//
//  Album.h
//  baifumei
//
//  Created by 肖彦宇 on 13-12-25.
//  Copyright (c) 2013年 Zhu Zhihai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Images;

@interface Album : NSManagedObject

@property (nonatomic, retain) NSNumber * albumID;
@property (nonatomic, retain) NSString * albumName;
@property (nonatomic, retain) NSSet *ownedImage;
@end

@interface Album (CoreDataGeneratedAccessors)

- (void)addOwnedImageObject:(Images *)value;
- (void)removeOwnedImageObject:(Images *)value;
- (void)addOwnedImage:(NSSet *)values;
- (void)removeOwnedImage:(NSSet *)values;

@end
