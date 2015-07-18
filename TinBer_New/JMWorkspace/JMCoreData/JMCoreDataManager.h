//
//  JMCoreDataManager.h
//
//  Created by iStig on 15/7/11.
//  Copyright (c) 2015年 shentingting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#define JMManagedObjectContext [JMCoreDataManager sharedCoreDataManager].managedObjectContext

@interface JMCoreDataManager : NSObject
@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong, readonly) NSPersistentStore *persistentStore;

+ (instancetype)sharedCoreDataManager;
- (void)saveContext;
@end
