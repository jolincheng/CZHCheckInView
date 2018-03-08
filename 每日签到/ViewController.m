//
//  ViewController.m
//  每日签到
//
//  Created by 程召华 on 2018/3/7.
//  Copyright © 2018年 程召华. All rights reserved.
//

#import "ViewController.h"
#import "CZHDailyCheckInView.h"
#import "CZHDialyCheckInHeader.h"
#import "CZHLocalCacheTool.h"

typedef NS_ENUM(NSInteger, ViewControllerButtonType) {
    ViewControllerButtonTypeCheck,
    ViewControllerButtonTypeStopCheck
};

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self czh_setUpButton];
    
    
}

- (void)czh_setUpButton {
    
    UIButton *checkButton = [[UIButton alloc] init];
    checkButton.czh_width = CZH_ScaleWidth(150);
    checkButton.czh_height = CZH_ScaleWidth(50);
    checkButton.czh_centerX = self.view.czh_centerX;
    checkButton.czh_centerY = self.view.czh_centerY - checkButton.czh_height;
    
    [checkButton setTitle:@"签到" forState:UIControlStateNormal];
    [checkButton setTitleColor:CZHColor(0xffffff) forState:UIControlStateNormal];
    checkButton.titleLabel.font = CZHGlobelNormalFont(16);
    checkButton.backgroundColor = CZHColor(0xff0000);
    checkButton.tag = ViewControllerButtonTypeCheck;
    [checkButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:checkButton];
    
    
    UIButton *stopCheckButton = [[UIButton alloc] init];
    stopCheckButton.czh_width = CZH_ScaleWidth(150);
    stopCheckButton.czh_height = CZH_ScaleWidth(50);
    stopCheckButton.czh_centerX = self.view.czh_centerX;
    stopCheckButton.czh_centerY = self.view.czh_centerY + stopCheckButton.czh_height;
    
    [stopCheckButton setTitle:@"断开连续签到" forState:UIControlStateNormal];
    [stopCheckButton setTitleColor:CZHColor(0xffffff) forState:UIControlStateNormal];
    stopCheckButton.titleLabel.font = CZHGlobelNormalFont(16);
    stopCheckButton.backgroundColor = CZHColor(0xff0000);
    stopCheckButton.tag = ViewControllerButtonTypeStopCheck;
    [stopCheckButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stopCheckButton];
    
}

- (void)buttonClick:(UIButton *)sender {
    
    if (sender.tag == ViewControllerButtonTypeCheck) {
        [CZHDailyCheckInView czh_dialyCheckInViewWithSuccessHandler:^(CZHDailyCheckInView *checkInView) {
            NSLog(@"---签到成功");
        } failureHandler:^(CZHDailyCheckInView *checkInView) {
            NSLog(@"---签到失败");
        } closeHandler:^(CZHDailyCheckInView *checkInView) {
            NSLog(@"---关闭弹窗");
        }];
        
    } else if (sender.tag == ViewControllerButtonTypeStopCheck) {//点击断开连续签到
        
        //模拟后台请求不是签到中间有一天没有签到需要重新签到
        
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"连续签到已经断开,下次签到需要重新开始" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            dic[@"sign_count"] = @"0";
            dic[@"sign_log"] = @[];
            
            [CZHLocalCacheTool czh_updateCheckCacheWithDataDic:dic];
        }];
        
        [alert addAction:action];
        
        [self presentViewController:alert animated:YES completion:nil];

    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
