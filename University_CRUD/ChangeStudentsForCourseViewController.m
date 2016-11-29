//
//  ChangeStudentsForCourseViewController.m
//  University_CRUD
//
//  Created by Admin on 28.11.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "ChangeStudentsForCourseViewController.h"
#import "ChangeStudenAgreeCell.h"
#import "ChangeStudentCellTableViewCell.h"
#import "DataManager.h"
#import "Student.h"

@interface ChangeStudentsForCourseViewController () <ChangeStudentDelegate>

@property (strong, nonatomic) DataManager *dataManager;
@property (strong, nonatomic) NSArray<Student *> *students;
@property (strong, nonatomic) NSArray<Student *> *studentsGoToCourse;
@property (strong, nonatomic) NSArray<Student *> *studentsNotGoToCourse;

@end

@implementation ChangeStudentsForCourseViewController

- (void)changeForCell:(ChangeStudentCellTableViewCell *) cell {
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    //NSLog(@"cell %@ row: %ld", cell.firstNameLabel.text, indexPath.row);
    
    Student *studentChange = [self.students objectAtIndex:indexPath.row];
    
    NSMutableArray *mutableGoToCourse = [self mutableArrayValueForKey:@"studentsGoToCourse"];
    NSMutableArray *mutableNotGoToCourse = [self mutableArrayValueForKey:@"studentsNotGoToCourse"];
    
    
    if (cell.studentSwitch.on) {
        
        //блок добавление студента к массиву mutableGoToCourse, он сработает дишь один раз
        if ([mutableGoToCourse containsObject:studentChange]) {
            //NSLog(@"не надо добавлять студента к массиву mutableGoToCourse, он там уже есть");
        } else {
            //NSLog(@"надо добавить студента к массиву mutableGoToCourse");
            [mutableNotGoToCourse addObject:studentChange];
        }
        //блок удаления студента из массива mutableNotGoToCourse, он сработает дишь один раз
        if (![mutableNotGoToCourse containsObject:studentChange]) {
            //NSLog(@"не надо удалять студента из массива mutableNotGoToCourse, его там уже нет");
        } else {
            //NSLog(@"надо удалить студента из массива mutableNotGoToCourse");
            [mutableNotGoToCourse removeObject:studentChange];
        }

        
        
    } else {
        
        if ([mutableNotGoToCourse containsObject:studentChange]) {
            //NSLog(@"не надо добавлять студента к массиву mutableNotGoToCourse, он там уже есть");
        } else {
            //NSLog(@"надо добавить студента к массиву mutableNotGoToCourse");
            [mutableNotGoToCourse addObject:studentChange];
        }
        
        if (![mutableGoToCourse containsObject:studentChange]) {
            //NSLog(@"не надо удалять студента из массива mutableGoToCourse, его там уже нет");
        } else {
            //NSLog(@"надо удалить студента из массива mutableGoToCourse");
            [mutableGoToCourse removeObject:studentChange];
        }
        
    }
    
}



- (NSArray *)getNotGoStudents {
    NSMutableSet<Student *> *setNotGo = [NSMutableSet setWithArray:self.students];
    
    for (Student *student in self.studentsGoToCourse) {
        [setNotGo removeObject:student];
    }
    
    return [setNotGo allObjects];
}

- (void)viewDidLoad {
    self.dataManager = [DataManager sharedManager];
    self.students = [self.dataManager.university.students allObjects];
    self.studentsGoToCourse = [self.course.students allObjects];
    self.studentsNotGoToCourse = [self getNotGoStudents];
    
    /*
    NSLog(@"studentsGoToCourse %ld\nstudentsNotGoToCourse %ld", [self.studentsGoToCourse count],
          [self.studentsNotGoToCourse count]);
    */
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return [self.dataManager.university.students count];
    } else {
        return 1;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *changeStudent = @"changeStudent";
    static NSString *button = @"button";
    
    if (indexPath.section == 0) {
        ChangeStudentCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:changeStudent
                                                                               forIndexPath:indexPath];
        if (!cell) {
            cell = [[ChangeStudentCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                         reuseIdentifier:changeStudent];
        }
        Student *student = [self.students objectAtIndex:indexPath.row];
        cell.firstNameLabel.text = student.firstName;
        cell.lastNameLabel.text = student.lastName;
        
        //Если студент подписан на курс - YES, в протвном случае NO
        //Выводятся все студенты, дабы можно было изменять кто подписан на курс из всей массы студентов
        
        if ([self.studentsNotGoToCourse containsObject:student]) {
            [cell.studentSwitch setOn:NO];
        } else {
            [cell.studentSwitch setOn:YES];
        }
        
        cell.delegateController = self;
        
        return cell;

    } else {
        ChangeStudenAgreeCell *cellAgree = [tableView dequeueReusableCellWithIdentifier:button
                                                                           forIndexPath:indexPath];
        if (!cellAgree) {
            cellAgree = [[ChangeStudenAgreeCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                         reuseIdentifier:button];
        }
        return cellAgree;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ChangeStudentCellTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        NSLog(@"row %ld change %d", indexPath.row, cell.studentSwitch.on);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}




- (IBAction)agreeButton:(UIButton *)sender {
    //NSLog(@"cource name: %@ SAVE", self.course.courseName);
    
    NSSet* studentsForCourseFromBD = self.course.students;
    
    for (Student *student in self.studentsNotGoToCourse) {
        //NSLog(@"student %@ not to go course", student.firstName);
        
        if ([studentsForCourseFromBD containsObject:student]) {
            [self.course removeStudentsObject:student];
        }
        
    }
    
    NSMutableArray *mutableGoToCourse = [NSMutableArray arrayWithArray:self.students];
    
    
    for (Student *student in self.studentsNotGoToCourse) {
        [mutableGoToCourse removeObject:student];
    }
    
    
    for (Student *student in mutableGoToCourse) {
        //NSLog(@"student %@ go course", student.firstName);
        
        if (![studentsForCourseFromBD containsObject:student]) {
            [self.course addStudentsObject:student];
        }
        
    }
    
    
    
    [self.dataManager.managedObjectContext save:nil];
    
}


@end
