//
//  ComUnit.h
//  baifumei
//
//  Created by Zhu Zhihai on 13-12-14.
//  Copyright (c) 2013年 Zhu Zhihai. All rights reserved.
//

#define kTitle          @"title"
#define kPub_time       @"pub_time"
#define kSource_name    @"source_name"
#define kWeiBo_url      @"url"
#define kUser_ico       @"User_ico"
#define kContent_Img    @"Content_Img"
#define kContent        @"content"

@protocol ComUnitDelegate <NSObject>

-(void)comUnitCompleteWith:(NSMutableDictionary *)dicInfo;

@end


#import <Foundation/Foundation.h>

@interface ComUnit : NSObject<NSURLConnectionDataDelegate,NSURLConnectionDelegate>
{
    NSInteger currIndex;
}
@property (nonatomic,strong) NSMutableArray *contentViewArray;
@property (nonatomic,strong) NSMutableData *summaryData;
@property (nonatomic,strong) NSMutableArray *ownArray;

+(void)getInfo;
+(void)addUpdateContentView:(id<ComUnitDelegate>) delegate;
-(void)setCurrIndex:(NSInteger)v;
-(NSInteger)getCurrIndex;
@end
