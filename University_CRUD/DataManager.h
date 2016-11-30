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
#import "Course.h"
#import "Teacher.h"

@interface DataManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;




- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

+ (DataManager *) sharedManager;
- (void)oneUniversity;

- (void)add10ItemContent;
- (void)addStudentWithName:(NSString *)name LastName:(NSString *)lasrName Telefon:(NSString *)telefon Email:(NSString *)email;
- (void)addCourseWithCourseName:(NSString *)courseName Subject:(NSString *)subject Sector:(NSString *)sector Teacher:(Teacher *)teacher;
- (void)addTeacherWithName:(NSString *)firstName LastName:(NSString *)lastName;

- (University *)addIniversity;
- (void) printUniverInfo;
- (void) deleteAllObjectsInDataBase;

@property (strong, nonatomic) University *university;
@property (strong, nonatomic) Teacher *currentTeacher;

@end
