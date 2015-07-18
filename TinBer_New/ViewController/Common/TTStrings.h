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

@interface TTStrings : NSObject
//时间戳
+ (NSString *)timeStamp;
+ (NSString *)timeStamp_Type;
//md5 加密
//+ (NSString *)md5BasedOnArrayOnlyFiirst8Number:(NSArray *)stringArrayNeedMD5;
+ (NSString *)HTTPBodyWithParameters:(NSDictionary *)parameters;
+ (NSString *)checkString:(NSString *)strSrc ;

@end
