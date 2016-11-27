//
//  Teacher+CoreDataProperties.h
//  University_CRUD
//
//  Created by Admin on 25.11.16.
//  Copyright © 2016 Admin. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Teacher.h"

NS_ASSUME_NONNULL_BEGIN

@interface Teacher (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *firstName;
@property (nullable, nonatomic, retain) NSString *lastName;
@property (nullable, nonatomic, retain) Course *course;
@property (nullable, nonatomic, retain) University *university;

@end

NS_ASSUME_NONNULL_END
