//
//  CZHTreasureBoxView.m
//  每日签到
//
//  Created by 程召华 on 2018/3/7.
//  Copyright © 2018年 程召华. All rights reserved.
//

#import "CZHTreasureBoxView.h"
#import "CZHDialyCheckInHeader.h"

@interface CZHTreasureBoxView ()
/**<#注释#>*/
@property (nonatomic, weak) UILabel *dayCount;
/**<#注释#>*/
@property (nonatomic, weak) UILabel *diamondCount;
/**<#注释#>*/
@property (nonatomic, weak) UIImageView *treasureBoxImage;
/**<#注释#>*/
@property (nonatomic, weak) UIView *maskView;
/**<#注释#>*/
@property (nonatomic, weak) UIImageView *bottomImage;
@end

@implementation CZHTreasureBoxView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self setView];
        
    }
    return self;
}


- (void)setTitle:(NSString *)title {
    _title = title;
    self.dayCount.text = title;
}

- (void)setDiamond:(NSString *)diamond {
    _diamond = diamond;
    self.diamondCount.text = diamond;
}

- (void)setIsCheckIng:(NSInteger)isCheckIng {
    _isCheckIng = isCheckIng;
    
    if (isCheckIng == 0) {
        self.maskView.hidden = NO;
        self.bottomImage.image = [UIImage imageNamed:@"sign_cannot_sign"];
        self.treasureBoxImage.image = [UIImage imageNamed:self.notOpenImage];
    } else if(isCheckIng == 1) {
        self.maskView.hidden = NO;
        self.bottomImage.image = [UIImage imageNamed:@"sign_can_sign"];
        self.treasureBoxImage.image = [UIImage imageNamed:self.notOpenImage];
    } else if(isCheckIng == 2) {
        self.maskView.hidden = YES;
        self.bottomImage.image = [UIImage imageNamed:@"sign_cannot_sign"];
        self.treasureBoxImage.image = [UIImage imageNamed:self.isOpenImage];
    }
}



- (void)setView {
    UIImageView *bottomImage = [[UIImageView alloc] init];
    bottomImage.frame = CGRectMake(0, 0, self.czh_width, self.czh_height);
    //bottomImage.image = [UIImage imageNamed:@"sign_cannot_sign"];
    [self addSubview:bottomImage];
    self.bottomImage = bottomImage;
    
    
    UILabel *dayCount = [[UILabel alloc] init];
    dayCount.frame = CGRectMake(0, CZH_ScaleHeight(6), self.czh_width, CZH_ScaleHeight(11));
    dayCount.textColor = CZHColor(0x333333);
//    dayCount.text = @"第一天";
    dayCount.font = CZHGlobelNormalFont(12);
    dayCount.textAlignment = NSTextAlignmentCenter;
    [bottomImage addSubview:dayCount];
    self.dayCount = dayCount;
    
    UIImageView *treasureBoxImage = [[UIImageView alloc] init];
    treasureBoxImage.frame = CGRectMake(CZH_ScaleWidth(7.5), dayCount.czh_bottom + CZH_ScaleHeight(4), CZH_ScaleWidth(55), CZH_ScaleHeight(50));
    // treasureBoxImage.image = [UIImage imageNamed:@"sign_firstday_open"];
    [bottomImage addSubview:treasureBoxImage];
    self.treasureBoxImage = treasureBoxImage;
    
    UILabel *diamondCount = [[UILabel alloc] init];
    diamondCount.frame = CGRectMake(0, treasureBoxImage.czh_bottom + CZH_ScaleHeight(4), self.czh_width, CZH_ScaleHeight(11));
//    diamondCount.text = @"1钻石";
    diamondCount.textColor = CZHColor(0x333333);
    diamondCount.font = CZHGlobelNormalFont(12);
    diamondCount.textAlignment = NSTextAlignmentCenter;
    [bottomImage addSubview:diamondCount];
    self.diamondCount = diamondCount;
    
    UIView *maskView = [[UIView alloc] init];
    maskView.layer.cornerRadius = CZH_ScaleHeight(10);
    maskView.frame = bottomImage.frame;
    maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    [self addSubview:maskView];
    self.maskView = maskView;
}


@end
