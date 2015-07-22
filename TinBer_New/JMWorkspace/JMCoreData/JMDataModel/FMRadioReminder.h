//
//  FMRadioReminder.h
//  TinBer_New
//
//  Created by iStig on 15/7/23.
//  Copyright (c) 2015年 shentingting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface FMRadioReminder : NSManagedObject

@property (nonatomic, retain) NSString * eventID;
@property (nonatomic, retain) NSString * eventName;
@property (nonatomic, retain) NSString * radioName;
@property (nonatomic, retain) NSString * radioNumber;

@end
