//
//  JMCoreDataManager.m
//
//  Created by iStig on 15/7/11.
//  Copyright (c) 2015年 shentingting. All rights reserved.
//

#import "JMCoreDataManager.h"
#define debug 1

@interface JMCoreDataManager ()
@property (nonatomic, strong, readwrite) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong, readwrite) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong, readwrite) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong, readwrite) NSPersistentStore *persistentStore;
@end
@implementation JMCoreDataManager

#pragma mark - FILES
static NSString *const storeFilename = @"JMDataModel.sqlite";

#pragma mark - SETUP
+ (instancetype)sharedCoreDataManager {
    if (debug == 1) NSLog(@"Class ==> %@ Selector ==>'%@'",self.class,NSStringFromSelector(_cmd));
    static dispatch_once_t once;
    static JMCoreDataManager *instance = nil;
    
    dispatch_once(&once, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

- (id)init {
    if (debug == 1) NSLog(@"Class ==> %@ Selector ==>'%@'",self.class,NSStringFromSelector(_cmd));
    self = [super init];
    if (!self) return nil;
    [self managedObjectContext];
    return self;
}

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
//托管对象上下文
- (NSManagedObjectContext *)managedObjectContext {
    if (debug == 1) NSLog(@"Class ==> %@ Selector ==>'%@'",self.class,NSStringFromSelector(_cmd));
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        //主线程并发
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
//持久化存储协调器
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (debug == 1) NSLog(@"Class ==> %@ Selector ==>'%@'",self.class,NSStringFromSelector(_cmd));
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    //增加版本迁移功能
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                             [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption,
                             nil];
    
    _persistentStore = [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[self storesURL] options:options error:&error];
    if (!_persistentStore) {
        
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        
        if (debug == 1) NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }else {
        if (debug == 1) NSLog(@"Successfully addad store :%@",_persistentStore);
    }
    
    return _persistentStoreCoordinator;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
//托管对象模型
-(NSManagedObjectModel *)managedObjectModel {
    if (debug == 1) NSLog(@"Class ==> %@ Selector ==>'%@'",self.class,NSStringFromSelector(_cmd));
    if (_managedObjectModel != nil) return _managedObjectModel;
    
//    _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil ];
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"JMDataModel" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}


#pragma mark - PATHS
//代表应用程序文档目录的路径
- (NSString *)applicationDocumentsDirectory {
    if (debug == 1) {
        NSLog(@"Class ==> %@ Selector ==>'%@'",self.class,NSStringFromSelector(_cmd));
        NSLog(@"Document Path ::: %@ ",[NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) lastObject]);
    }
    
    
    //存放于NSDocumentationDirectory 1.沙盒Document目录下能够防止被删除 2.并且可以被iCloud同步(未验证)
    return [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) lastObject];
}

- (NSURL *)applicationStoresDirectory {
    if (debug == 1) NSLog(@"Class ==> %@ Selector ==>'%@'",self.class,NSStringFromSelector(_cmd));
    //在沙盒Document目录下生成子文件夹JMCoreData
    NSURL *storesDirectory = [[NSURL fileURLWithPath:[self applicationDocumentsDirectory]] URLByAppendingPathComponent:@"JMCoreData"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:[storesDirectory path]]) {
        NSError *error = nil;
        if ([fileManager createDirectoryAtURL:storesDirectory withIntermediateDirectories:YES attributes:nil error:&error]) {
            if (debug == 1) {
                if (debug == 1)  NSLog(@"Successfully Created Stores Directory");
            }else {
                if (debug == 1)  NSLog(@"Failed To Created Stores Directory");
            }
        }
    }
    return storesDirectory;
}

- (NSURL *)storesURL {
    if (debug == 1) {
        NSLog(@"Class ==> %@ Selector ==>'%@'",self.class,NSStringFromSelector(_cmd));
        NSLog(@"Store Path ::: %@ ",[[self applicationStoresDirectory] URLByAppendingPathComponent:storeFilename]);
    }
    return [[self applicationStoresDirectory] URLByAppendingPathComponent:storeFilename];
}

#pragma mark SAVE
- (void)saveContext {
    if (debug == 1) NSLog(@"Class ==> %@ Selector ==>d%@'",self.class,NSStringFromSelector(_cmd));
    NSError *error = nil;
    if (_managedObjectContext != nil) {
        if ([_managedObjectContext hasChanges]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            if ([_managedObjectContext save:&error]) {
                if (debug == 1) NSLog(@"Saved changes to persistent store");
            }else {
                if (debug == 1) NSLog(@"Failed to save, Unresolved error %@, %@", error, [error userInfo]);
                abort();
            }
        }else {
            if (debug == 1) NSLog(@"Skipped save, there are no changes!");
        }
    }
}

@end
