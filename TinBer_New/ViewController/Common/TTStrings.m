//
//  TTStrings.m
//  Installer
//
//  Created by SunYuan on 14-12-30.
//  Copyright (c) 2014年 SunYuan. All rights reserved.
//

#import "TTStrings.h"

@implementation TTStrings

+(NSString *)timeStamp
{
    NSDateFormatter *dateForMatter = [[NSDateFormatter alloc] init];
    [dateForMatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *timeStampString = [dateForMatter stringFromDate:[NSDate date]];
    return timeStampString;
}

+(NSString *)timeStamp_Type{
    NSDateFormatter *dateForMatter = [[NSDateFormatter alloc] init];
    [dateForMatter setDateFormat:@"YYYY-MM-DD HH:ii:ss"];
    NSString *timeStampString = [dateForMatter stringFromDate:[NSDate date]];
    return timeStampString;
}


//+ (NSString *)md5BasedOnArrayOnlyFiirst8Number:(NSArray *)stringArrayNeedMD5
//{
//    NSString *fullString = [stringArrayNeedMD5 componentsJoinedByString:@""];
//    return [CocoaSecurity md5:fullString].hex.lowercaseString;
//}

+(NSString *)HTTPBodyWithParameters:(NSDictionary *)parameters
{
    NSMutableArray *parametersArray = [NSMutableArray array];
    
    for (NSString *key in [parameters allKeys]) {
        id value = [parameters objectForKey:key];
        if ([value isKindOfClass:[NSString class]]) {
            [parametersArray addObject:[NSString stringWithFormat:@"%@=%@",key,value]];
        }
    }
    
    return [parametersArray componentsJoinedByString:@"&"];
}

+ (NSString *)checkString:(NSString *)strSrc {
    NSString *strDest = nil;
    if ([strSrc length] && strSrc) {
        strDest = strSrc;
    } else {
        strDest = @"";
    }
    
    return strDest;
}

@end
