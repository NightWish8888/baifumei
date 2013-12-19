//
//  ComUnit.m
//  baifumei
//
//  Created by Zhu Zhihai on 13-12-14.
//  Copyright (c) 2013年 Zhu Zhihai. All rights reserved.
//

#import "ComUnit.h"
#import "JSONKit.h"
#import "NSString+StringRegular.h"

@implementation ComUnit
+(ComUnit *)shareInstance{
    static ComUnit *instace;
    if (!instace) {
        instace = [[ComUnit alloc] init];
        [instace setSummaryData:[NSMutableData dataWithCapacity:1]];
        [instace setOwnArray:[NSMutableArray arrayWithCapacity:1]];
        [instace setContentViewArray:[NSMutableArray arrayWithCapacity:1]];
    }
    return instace;
}
-(NSInteger)getCurrIndex{
    return currIndex;
}
-(void)setCurrIndex:(NSInteger)v{
    currIndex = v;
}
+(void)getInfo{
//    [[ComUnit shareInstance] setCurrIndex:0];
    [[[ComUnit shareInstance] summaryData] setData:nil];
    NSURL *url = [NSURL URLWithString:ServerUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection connectionWithRequest:request delegate:[ComUnit shareInstance]];
}
+(void)addUpdateContentView:(id<ComUnitDelegate>) delegate{
    if (![[[ComUnit shareInstance] contentViewArray] containsObject:delegate]) {
        [[[ComUnit shareInstance] contentViewArray] addObject:delegate];
    }
    [[ComUnit shareInstance] updateContentView];
}

-(void)updateContentView{
    NSMutableArray *updatedContetArr = [NSMutableArray arrayWithCapacity:1];
    NSLog(@"the updatecontentview count:%d",self.contentViewArray.count);
    [self.contentViewArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (currIndex < self.ownArray.count) {
            id<ComUnitDelegate> _delegate = obj;
            if (_delegate && [_delegate respondsToSelector:@selector(comUnitCompleteWith:)]) {
                [_delegate comUnitCompleteWith:[self.ownArray objectAtIndex:currIndex]];
                
                NSLog(@"请求第%d条数据!!!",currIndex);
            }
            [updatedContetArr addObject:_delegate];
        }
        if (currIndex == self.ownArray.count - 1) {
            [ComUnit getInfo];
            *stop = YES;
        }
        NSLog(@"the currindex:%d",currIndex);
        currIndex++;
    }];
    [self.contentViewArray removeObjectsInArray:updatedContetArr]; 
}






































//-(void)conn{
//    NSURL *url = [NSURL URLWithString:@"http://pingma.qq.com/mstat/report"];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    NSString *hex = @"e66154e96b0097554ba671e4d0ef47e974f841e86df479f51c3f50b75c85d8e67a28162a99e1cf84c348173ff34c73062e585d9dae4032281d5f7f39fb29cf64030197a137b7e4b227b7d15068e6eebe64f9b54771d8325c4f62a37c4943122932107a83b58cd5fb1a25543ac647846b6bab3a41a08049834d9f8aa1d187187d6f2d1d4d7676264764d62a04b3bad6c45986248ba7a9a4d564591f0054ebcc9fa078b00684330ae15ada25ead5b59c81fce0953741c3aff5dbd573d5630ed0b14c053024af86b5d3f8f37f887011";
//    
//    
//    NSData *data = [self stringToData:hex];
//    NSLog(@"THE BYTE:%d\n%@",data.length,data);
//    [request setHTTPBody:data];
//    [request setHTTPMethod:@"POST"];
//    NSString *user_angent = @"baifumei/20131010 CFNetwork/672.0.8 Darwin/14.0.0";
//    [request addValue:user_angent forHTTPHeaderField:@"User-Agent"];
//    NSString *accept_encoding = @"gzip, deflate";
//    [request addValue:accept_encoding forHTTPHeaderField:@"Accept-Encoding"];
//    NSString *conten_type = @"json";
//    [request addValue:conten_type forHTTPHeaderField:@"Content-Type"];
//    NSString *conten_Encoding = @"rc4";
//    [request addValue:conten_Encoding forHTTPHeaderField:@"Content-Encoding"];
//    
//    NSURLRequest *r1 = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
//    
//    [NSURLConnection connectionWithRequest:request delegate:self];
//}
//-(NSData*) stringToData:(NSString*)command
//{
//    command = [command stringByReplacingOccurrencesOfString:@" " withString:@""];
//    NSMutableData *commandToSend= [[NSMutableData alloc] init];
//    unsigned char whole_byte;
//    char byte_chars[3] = {'\0','\0','\0'};
//    int i;
//    for (i=0; i < [command length]/2; i++) {
//        byte_chars[0] = [command characterAtIndex:i*2];
//        byte_chars[1] = [command characterAtIndex:i*2+1];
//        whole_byte = strtol(byte_chars, NULL, 16);
//        [commandToSend appendBytes:&whole_byte length:1];
//    }
//    return commandToSend;
//}


-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [self.summaryData appendData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    [self setCurrIndex:0];
    [self.ownArray removeAllObjects];
    //parase
    
    NSDictionary *dic = [self.summaryData objectFromJSONData];
//    NSLog(@"the dic:%@",dic);
    NSArray *pageArr = [dic objectForKey:kPage];
    [pageArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSMutableDictionary *_ownDict = [NSMutableDictionary dictionaryWithCapacity:1];
        NSDictionary *contentDic = obj;
        BOOL valid = NO;
        NSString *title = [contentDic objectForKey:kTitle];
        if (title) {
            valid = YES;
            [_ownDict setObject:title forKey:kTitle];
        }
        
        NSString *name = [contentDic objectForKey:kSource_name];
        if (name) {
            valid = YES;
            [_ownDict setObject:name forKey:kSource_name];
        }
        
        NSString *weiboUrl = [contentDic objectForKey:kWeiBo_url];
        if (weiboUrl) {
            valid = YES;
            [_ownDict setObject:weiboUrl forKey:kWeiBo_url];
        }
        
        NSString *pubTime = [contentDic objectForKey:kPub_time];
        if (pubTime) {
            valid = YES;
            [_ownDict setObject:pubTime forKey:kPub_time];
        }
        
        NSString *content = [contentDic objectForKey:kContent];
        NSMutableArray *array = [content substringByRegular:@"(<img style=.*? />)"];
        NSMutableArray *srcArray = [[NSMutableArray alloc] init];
        
        [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSString *stringObj = obj;
            NSMutableArray *tmpArray = [stringObj substringByRegular:@"http://.*?\""];
            if (tmpArray.count > 0) {
                NSString *tmpString = [[tmpArray objectAtIndex:0] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                [srcArray addObject: tmpString];
            }
        }];
        
        if (srcArray.count > 0) {
            valid = YES;
            NSString *userIcon = [srcArray objectAtIndex:0];
            [_ownDict setObject:userIcon  forKey:kUser_ico];
            [srcArray removeObjectAtIndex:0];
        }
        
        [_ownDict setObject:srcArray forKey:kContent_Img];
        [self.ownArray addObject:_ownDict];
    }];

    [self updateContentView];
   
    
    
//    [contentDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
//        NSLog(@"the key:%@\nthe obj:%@",key,obj);
//        if ([obj isKindOfClass:[NSString class]]) {
//            NSMutableArray *array = [obj substringByRegular:@"(<img style=.*? />)"];
//            [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//                NSLog(@"_____:%@",obj);
//            }];
//        }
    
        
        
//    }];
    
    
    
    
//      NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"" options:NSRegularExpressionCaseInsensitive error:nil];
//    [regex enumerateMatchesInString:(NSString *) options:<#(NSMatchingOptions)#> range:<#(NSRange)#> usingBlock:<#^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop)block#>]

}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"parase the data err...");

}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
    
//    if ( [response isKindOfClass:[NSHTTPURLResponse class]] ) {
//        NSHTTPURLResponse * httpResponse;
//        
//        httpResponse = (NSHTTPURLResponse *) response;
//        
//     
//            NSLog(@"the code:%d",[httpResponse statusCode]);
//        
//    }
//    
//    
//    NSLog(@"the response:%lld \n%@",response.expectedContentLength,response.MIMEType);
    
}
@end
