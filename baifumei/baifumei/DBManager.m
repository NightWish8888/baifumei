//
//  DBManager.m
//  baifumei
//
//  Created by 肖彦宇 on 13-12-21.
//  Copyright (c) 2013年 Zhu Zhihai. All rights reserved.
//

#import "DBManager.h"

@implementation DBManager
static NSManagedObjectContext *context;

+(void)initDB
{
    [DBManager configureDataBase];
    [context lock];
    
    Album *album = [NSEntityDescription insertNewObjectForEntityForName:@"Album" inManagedObjectContext:context];
    [album setAlbumName:@"我的相册"];
    
    album = [NSEntityDescription insertNewObjectForEntityForName:@"Album" inManagedObjectContext:context];
    [album setAlbumName:@"111"];
    [context save:nil];
    [context unlock];
}

+(void)configureDataBase{
    if (context==nil) {
        NSManagedObjectModel *model=[NSManagedObjectModel mergedModelFromBundles:nil];
        NSPersistentStoreCoordinator *psc=[[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
        NSURL *sotreURL=[NSURL fileURLWithPath:DBFilePath];
        NSError *error=nil;
        //没有store.data文件会自动创建，并打开.....
        if (![psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:sotreURL options:nil error:&error]) {
            [NSException raise:@"open failed" format:@"reason:%@",[error localizedDescription]];
        }
        context=[[NSManagedObjectContext alloc] init];
        [context setPersistentStoreCoordinator:psc];
//        [psc release];
        [context setUndoManager:nil];
    }
}
+(NSManagedObjectContext *)shareContext{
    [DBManager configureDataBase];
    return  context;
}

@end
