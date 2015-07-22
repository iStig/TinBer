//
//  FMRadioPusher.h
//  TinBer_New
//
//  Created by iStig on 15/7/23.
//  Copyright (c) 2015年 shentingting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface FMRadioPusher : NSManagedObject

@property (nonatomic, retain) NSDate * pushStartTime;
@property (nonatomic, retain) NSString * pushID;

@end
