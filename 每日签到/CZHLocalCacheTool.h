//
//  CZHLocalCacheTool.h
//  每日签到
//
//  Created by 程召华 on 2018/3/8.
//  Copyright © 2018年 程召华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CZHLocalCacheTool : NSObject

+ (void)czh_updateCheckCacheWithDataDic:(NSDictionary *)dataDic;

+ (NSDictionary *)czh_getCheckCache;
@end
