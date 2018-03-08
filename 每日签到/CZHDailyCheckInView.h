//
//  CZHDailyCheckInView.h
//  每日签到
//
//  Created by 程召华 on 2018/3/7.
//  Copyright © 2018年 程召华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CZHTreasureBoxView : UIView
/**没开*/
@property (nonatomic, strong) NSString *notOpenImage;
/**打开*/
@property (nonatomic, strong) NSString *isOpenImage;
/***/
@property (nonatomic, strong) NSString *title;
/***/
@property (nonatomic, strong) NSString *diamond;
/**0:没有签到，1:正在签到 ,2:已经签到*/
@property (nonatomic, assign) NSInteger isCheckIng;

@end


@interface CZHDailyCheckInView : UIView


+ (instancetype)czh_dialyCheckInViewWithSuccessHandler:(void (^)(CZHDailyCheckInView *checkInView))successHandler failureHandler:(void (^)(CZHDailyCheckInView *checkInView))failureHandler closeHandler:(void (^)(CZHDailyCheckInView *checkInView))closeHandler;


@end
