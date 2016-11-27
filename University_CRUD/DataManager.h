//
//  DataManager.h
//  University_CRUD
//
//  Created by Admin on 24.11.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "University.h"

@interface DataManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

+ (DataManager *) sharedManager;

- (void)add10ItemContent;
- (void)addStudentWithName:(NSString *)name LastName:(NSString *)lasrName Telefon:(NSString *)telefon Email:(NSString *)email;
- (University *)addIniversity;
- (void)oneUniversity;
@property (strong, nonatomic) University *university;

@end
