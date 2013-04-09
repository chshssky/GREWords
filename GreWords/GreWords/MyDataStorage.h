//
//  MyDataStorage.h
//  GreWords
//
//  Created by Song on 13-4-9.
//  Copyright (c) 2013年 Song. All rights reserved.
//

@interface MyDataStorage : NSObject
{
    NSPersistentStoreCoordinator *holder;
}
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
+ (MyDataStorage*)instance;
- (void)deleteDaatabase;
@end