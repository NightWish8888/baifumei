//
//  NSString+StringRegular.m
//  baifumei
//
//  Created by Zhu Zhihai on 13-12-15.
//  Copyright (c) 2013年 Zhu Zhihai. All rights reserved.
//

#import "NSString+StringRegular.h"

@implementation NSString (StringRegular)
-(NSMutableArray *)substringByRegular:(NSString *)regular{
    
    NSString * reg=regular;
    
    NSRange r= [self rangeOfString:reg options:NSRegularExpressionSearch];
    
    NSMutableArray *arr=[NSMutableArray array];
    
    if (r.length != NSNotFound &&r.length != 0) {
        
//        int i=0;
        
        while (r.length != NSNotFound &&r.length != 0) {
            
//            FCLOG(@"index = %i regIndex = %d loc = %d",(++i),r.length,r.location);
            
            NSString* substr = [self substringWithRange:r];
            
//            FCLOG(@"substr = %@",substr);
            
            [arr addObject:substr];
            
            NSRange startr=NSMakeRange(r.location+r.length, [self length]-r.location-r.length);
            
            r=[self rangeOfString:reg options:NSRegularExpressionSearch range:startr];
        }
    }
    return arr;
}
@end
