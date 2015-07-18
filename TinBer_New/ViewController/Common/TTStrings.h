//
//  TTStrings.h
//  Installer
//
//  Created by SunYuan on 14-12-30.
//  Copyright (c) 2014年 SunYuan. All rights reserved.
//

#import <Foundation/Foundation.h>

#define REFRESHDiary @"REFRESHDiary"
#define UPDATEALLHEAD @"UPDATEALLHEAD"

#define HIDDENSEARCHBAr @"HIDDENSEARCHBAR"

#define KTapClick @"tapClick" //点击隐藏ccscrollview 上的文字

#define Kconfirm @"确定"
#define kCancel  @"取消"

//phone
#define KServiesPhone  @"4008554577"

#define KFontHi    @"Heiti Sc-Ligth"

//正则
#define EMAIL_Regex @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
#define PHONE_Regex @"(1(3|4|5|7|8)\\d{9})" //手机号

@interface TTStrings : NSObject
//时间戳
+ (NSString *)timeStamp;
+ (NSString *)timeStamp_Type;
//md5 加密
//+ (NSString *)md5BasedOnArrayOnlyFiirst8Number:(NSArray *)stringArrayNeedMD5;
+ (NSString *)HTTPBodyWithParameters:(NSDictionary *)parameters;
+ (NSString *)checkString:(NSString *)strSrc ;
void TTAlert(NSString* message);

@end
