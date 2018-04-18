//
//  STDataBaseUtil.m
//  framework
//
//  Created by 黄成实 on 2018/4/18.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "STDataBaseUtil.h"
#import "STRuntimeUtil.h"

@implementation STDataBaseUtil
SINGLETON_IMPLEMENTION(STDataBaseUtil)

-(FMDatabaseQueue *)getFMDatabaseQueue{
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filename = [doc stringByAppendingPathComponent:@"st.sqlite"];
    return [FMDatabaseQueue databaseQueueWithPath:filename];
}

-(void)createTable:(NSString *)tableName{
    FMDatabaseQueue *queue = [self getFMDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        if ([db open]) {
            BOOL result = [db executeUpdate:[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (cid integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, age integer NOT NULL);",tableName]];
            if (result) {
                [STLog print:@"create table success"];
            } else {
                [STLog print:@"create table fail"];
            }
        }
    }];
}


-(void)insertRow:(NSString *)tableName model:(id)model{
    if([model isKindOfClass:[NSObject class]]){
        NSArray *array = [STRuntimeUtil getAllPropertyNames:model];
        FMDatabaseQueue *queue = [self getFMDatabaseQueue];
        
//        NSString *sqlStr = [NSString stringWithFormat:@""]
//        [queue inDatabase:^(FMDatabase *db) {
//            [db beginTransaction];
//            [db executeUpdate:@"INSERT INTO @(tableName) (name, age) VALUES (?, ?);", @"jake", @30];
//            [db commit];
//        }];
    }
  
}


@end
