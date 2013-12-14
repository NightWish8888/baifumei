//
//  ComUnit.h
//  baifumei
//
//  Created by Zhu Zhihai on 13-12-14.
//  Copyright (c) 2013年 Zhu Zhihai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ComUnit : NSObject<NSURLConnectionDataDelegate,NSURLConnectionDelegate>


@property (nonatomic,strong) NSMutableData *summaryData;
//-(void)conn;
-(void)getInfo;

@end
