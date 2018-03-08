//
//  CZHDailyCheckInView.h
//  每日签到
//
//  Created by 程召华 on 2018/3/7.
//  Copyright © 2018年 程召华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CZHDailyCheckInView : UIView


+ (instancetype)czh_dialyCheckInViewWithSuccessHandler:(void (^)(CZHDailyCheckInView *checkInView))successHandler failureHandler:(void (^)(CZHDailyCheckInView *checkInView))failureHandler closeHandler:(void (^)(CZHDailyCheckInView *checkInView))closeHandler;


@end
