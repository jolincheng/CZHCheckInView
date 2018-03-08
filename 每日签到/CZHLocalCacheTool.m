//
//  CZHLocalCacheTool.m
//  每日签到
//
//  Created by 程召华 on 2018/3/8.
//  Copyright © 2018年 程召华. All rights reserved.
//

#import "CZHLocalCacheTool.h"
#import "FMDB.h"

static FMDatabaseQueue *_queue;

@implementation CZHLocalCacheTool


+ (void)load {
    //创建用户未读信息表单和总未读信息表单
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    // 拼接文件名
    NSString *filePath = [cachePath stringByAppendingPathComponent:@"chechCache.sqlite"];
    
    // 创建了一个数据库实例
    _queue = [FMDatabaseQueue databaseQueueWithPath:filePath];
    
    [_queue inDatabase:^(FMDatabase *_db) {
        
        ///存储首页信息
        NSString *t_checkCacheTabel = @"create table if not exists t_checkCache (id integer primary key autoincrement, checkCacheData text);";
        
        
        // 创建请求接口列表
        BOOL t_checkCacheSuccess = [_db executeUpdate:t_checkCacheTabel];
        
        
        if (t_checkCacheSuccess == YES) {
            NSLog(@"---t_checkCacheTabel创建成功");
            
           
        }
        
        
        
    }];
}

+ (void)czh_updateCheckCacheWithDataDic:(NSDictionary *)dataDic {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        dispatch_sync(dispatch_queue_create("t_checkCache", DISPATCH_QUEUE_SERIAL), ^{
            NSString *jsonStr = [self convertObjectIntoStringWithobject:dataDic];
            
           
            NSString *sql = @"select checkCacheData from t_checkCache;";
            
            [_queue inDatabase:^(FMDatabase *db) {
                [db beginTransaction];
                @try {
                    FMResultSet *set = [db executeQuery:sql];
                    
                    while ([set next]) {
                        
                        NSString *string = [NSString stringWithFormat:@"update t_checkCache set checkCacheData = '%@'", jsonStr];
                        BOOL flag = [db executeUpdate:string];
                        
                        if (flag) {//更新表成功
                            NSLog(@"t_checkCache");
                        }else{//更新表失败
                            NSLog(@"更新列表失败");
                        }
                        [set close];
                        return ;
                    }
                    
                    [set close];
                    
                    //查询不到表
                    NSString *string = [NSString stringWithFormat:@"insert into t_checkCache (checkCacheData) values ('%@');", jsonStr];
                    BOOL flag = [db executeUpdate:string];
                    if (flag) {
                        NSLog(@"t_checkCache插入表成功success");
                    }else{
                        NSLog(@"failure%@", [db lastError]);
                        
                    }
                }
                @catch (NSException *exception) {
                    [db rollback];
                    NSLog(@"t_checkCache--NSException%@", exception);
                }
                @finally {
                    [db commit];
                }
            }];
        });
    });
    
    
}


+ (NSDictionary *)czh_getCheckCache {
    NSString *sql = @"select checkCacheData from t_checkCache ;";
    
    __block id object = nil;
    
    [_queue inDatabase:^(FMDatabase *db) {
        FMResultSet *set = [db executeQuery:sql];
        
        while ([set next]) {
            
            NSString * jsonStr = [set stringForColumn:@"checkCacheData"];
            
            object = [self convertJsonStringIntoObjectWithJsonString:jsonStr];
        }
        
        [set close];
    }];
    
    return object;
}


//字典或者数组转json字符串
+ (NSString *)convertObjectIntoStringWithobject:(id)object {
    NSError *error;
    
    if (object == nil) {
        return @"";
    }
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}

//json字符串转字典或者数组
+ (id)convertJsonStringIntoObjectWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
@end
