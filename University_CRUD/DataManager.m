//
//  DataManager.m
//  University_CRUD
//
//  Created by Admin on 24.11.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "DataManager.h"
#import "Student.h"
#import "University.h"
#import "Course.h"
#import "Teacher.h"

static NSString* firstNames[] = {
    
    @"Tran", @"Lenore", @"Bud", @"Fredda", @"Katrice",
    @"Clyde", @"Hildegard", @"Vernell", @"Nellie", @"Rupert",
    @"Billie", @"Tamica", @"Crystle", @"Kandi", @"Caridad",
    @"Vanetta", @"Taylor", @"Pinkie", @"Ben", @"Rosanna",
    @"Eufemia", @"Britteny", @"Ramon", @"Jacque", @"Telma",
    @"Colton", @"Monte", @"Pam", @"Tracy", @"Tresa",
    @"Willard", @"Mireille", @"Roma", @"Elise", @"Trang",
    @"Ty", @"Pierre", @"Floyd", @"Savanna", @"Arvilla",
    @"Whitney", @"Denver", @"Norbert", @"Meghan", @"Tandra",
    @"Jenise", @"Brent", @"Elenor", @"Sha", @"Jessie"
    
};

static NSString* lastNames[] = {
    
    @"Farrah", @"Laviolette", @"Heal", @"Sechrest", @"Roots",
    @"Homan", @"Starns", @"Oldham", @"Yocum", @"Mancia",
    @"Prill", @"Lush", @"Piedra", @"Castenada", @"Warnock",
    @"Vanderlinden", @"Simms", @"Gilroy", @"Brann", @"Bodden",
    @"Lenz", @"Gildersleeve", @"Wimbish", @"Bello", @"Beachy",
    @"Jurado", @"William", @"Beaupre", @"Dyal", @"Doiron",
    @"Plourde", @"Bator", @"Krause", @"Odriscoll", @"Corby",
    @"Waltman", @"Michaud", @"Kobayashi", @"Sherrick", @"Woolfolk",
    @"Holladay", @"Hornback", @"Moler", @"Bowles", @"Libbey",
    @"Spano", @"Folson", @"Arguelles", @"Burke", @"Rook"
    
};

static NSString* telefons[] = {
    
    @"8(911)" , @"8(921)", @"8(952)"
    
};

static NSString* emails[] = {
    
    @"@gmail.com", @"@mail.com", @"@yandex.ru"
    
};

@interface DataManager()


@end

@implementation DataManager

+ (DataManager *)sharedManager {
    static DataManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DataManager alloc] init];
        
    });
    
    return manager;
}

- (void)addStudentWithName:(NSString *)name LastName:(NSString *)lasrName Telefon:(NSString *)telefon Email:(NSString *)email {
    Student *student =
    [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:self.managedObjectContext];
    student.firstName = name;
    student.lastName = lasrName;
    student.telefon = telefon;
    student.email = email;
    
    [self.university addStudentsObject:student];
    
    [self.managedObjectContext save:nil];
    
}


- (void)addCourseWithCourseName:(NSString *)courseName Subject:(NSString *)subject Sector:(NSString *)sector Teacher:(Teacher *)teacher {
    Course *course =
    [NSEntityDescription insertNewObjectForEntityForName:@"Course" inManagedObjectContext:self.managedObjectContext];
    course.courseName = courseName;
    course.subject = subject;
    course.sector = sector;
    course.teacher = teacher;
    
    [self.university addCoursesObject:course];
    
    [self.managedObjectContext save:nil];
    
}



//Универ иницицализиру в AppDelegate
- (University *)addIniversity {
    University *university =
    [NSEntityDescription insertNewObjectForEntityForName:@"University" inManagedObjectContext:self.managedObjectContext];
    self.university = university;
    return university;
}


//Получаем все объекты сущностей
- (NSArray *)allObjectUniversity {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *descriotion = [NSEntityDescription entityForName:@"University" inManagedObjectContext:self.managedObjectContext];
    [request setEntity:descriotion];
    NSError *error = nil;
    NSArray *array = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
    return array;
}


//Не допускаем размножения объектов базы данных при перезагрузке приложения

- (void)oneUniversity {
    NSArray *universities = [self allObjectUniversity];
    University *firstUniversity = [universities firstObject];
    for (int i = 1; i < [universities count]; i++) {
        University *currentUniversity = universities[i];
        NSSet *setStudents = currentUniversity.students;
        NSSet *setCourses = currentUniversity.courses;
        [firstUniversity addStudents:setStudents];
        [firstUniversity addCourses:setCourses];
        [self.managedObjectContext deleteObject:currentUniversity];
    }
    self.university = firstUniversity;
    [self.managedObjectContext save:nil];
    
}





#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "adm.University_CRUD" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"University_CRUD" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"University_CRUD.sqlite"];
    NSError *error = nil;
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];
        
        [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Test methods
- (Student *)addRandomStudent {
    
    Student *student =
    [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:self.managedObjectContext];
    
    NSString *name = firstNames[arc4random_uniform(50)];
    NSString *lastName = lastNames[arc4random_uniform(50)];
    NSInteger numer = arc4random_uniform(9999999) + 1000000;
    NSString *telefon = [NSString stringWithFormat:@"%@%ld",telefons[arc4random_uniform(3)],numer];
    NSString *email = [NSString stringWithFormat:@"%@_%@%@",
                       [name lowercaseString],[lastName lowercaseString],emails[arc4random_uniform(3)]];
    
    student.firstName = name;
    student.lastName = lastName;
    student.telefon = telefon;
    student.email = email;
    
    //[self.university addStudentsObject:student];
    [self addStudentWithName:name LastName:lastName Telefon:telefon Email:email];
    
    return student;
    
}

- (void)add10ItemContent {
    
    for (int i = 0; i < 10; i++) {
        [self addRandomStudent];
    }
    
    [self.managedObjectContext save:nil];
    
}

@end
