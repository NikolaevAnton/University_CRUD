//
//  CoursesViewController.m
//  University_CRUD
//
//  Created by Admin on 25.11.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "CoursesViewController.h"
#import "University.h"
#import "DataManager.h"
#import "CourseCell.h"
#import "StudentsForCourseCell.h"
#import "Student.h"
#import "NewLecturesStudentsCell.h"
#import "ChangeStudentsForCourseViewController.h"
#import "Course.h"
#import "EditCourseViewController.h"

@interface CoursesViewController () <UITabBarControllerDelegate>

@property (strong, nonatomic) NSArray<Course *> *courses;

@property (strong, nonatomic) DataManager *dataManager;
@property (strong, nonatomic) NSArray *sections;
@property (strong, nonatomic) Course *course;
@property (strong, nonatomic) NewLecturesStudentsCell *cellLecture;

@end

@implementation CoursesViewController

- (NSArray *)sections {
    NSString* sectionsName[] = {
        @"Course", @"Button", @"List"
    };
    NSMutableArray *arrSections = [[NSMutableArray alloc] init];
    for (int i = 0; i < [self.courses count]; i++) {
        [arrSections addObject:sectionsName[0]];
        [arrSections addObject:sectionsName[1]];
        [arrSections addObject:sectionsName[2]];
    }
    return arrSections;
}


- (NSArray *)allCourses {
    University *university = self.dataManager.university;
    NSSet *setCourses = university.courses;
    return [setCourses allObjects];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    self.dataManager = [DataManager sharedManager];
    self.courses = [self allCourses];
    
    self.course = nil;
    
    self.buttonOutlet.enabled = NO;
    
    self.editOutlet.enabled = NO;
    
    UITabBarController *tabBarController = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [tabBarController setDelegate:self];
    
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)cancelButton:(UIStoryboardSegue *)sender {
    //NSLog(@"cancelButton CoursesViewController");
    self.course = nil;
    self.cellLecture.buttonOutlet.enabled = NO;
    self.editOutlet.enabled = NO;
}

- (IBAction)editCanselButton:(UIStoryboardSegue *)sender {
    //NSLog(@"editCanselButton CoursesViewController");
    self.course = nil;
    self.courses = [self allCourses];
    self.cellLecture.buttonOutlet.enabled = NO;
    self.editOutlet.enabled = NO;
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.courses count] * 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *namesSections = [self sections];

    if ([namesSections[section] isEqualToString:@"Course"]) {
        return 1;
    }
    if ([namesSections[section] isEqualToString:@"Button"]) {
        return 1;
    }
    if ([namesSections[section] isEqualToString:@"List"]) {
        Course *currentCourse = [self.courses objectAtIndex:section/3];
        NSSet *setStudents = currentCourse.students;
        return [[setStudents allObjects] count];
    }
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifierCourse = @"identifierCourse";
    static NSString *identifierStudents = @"identifierStudents";
    static NSString *identifierButton = @"identifierButton";
    
    Course *currentCourse = [self.courses objectAtIndex:indexPath.section/3];
    NSArray *students = [currentCourse.students allObjects];
    
    
    NSArray *namesSections = [self sections];
    
    if ([namesSections[indexPath.section] isEqualToString:@"Course"]) {
        CourseCell *cellCourse = [tableView dequeueReusableCellWithIdentifier:identifierCourse
                                                                 forIndexPath:indexPath];
        
        if (!cellCourse) {
            cellCourse = [[CourseCell alloc] initWithStyle:UITableViewCellStyleDefault
                                           reuseIdentifier:identifierCourse];
        }
        
        cellCourse.nameLabel.text = currentCourse.courseName;
        cellCourse.subjectLabel.text = currentCourse.subject;
        cellCourse.sectionLabel.text = currentCourse.sector;
        cellCourse.teacherLabel.text = [NSString stringWithFormat:@"%@ %@",
                                        currentCourse.teacher.firstName, currentCourse.teacher.lastName];
        
        return cellCourse;
    }
    if ([namesSections[indexPath.section] isEqualToString:@"Button"]) {
        NewLecturesStudentsCell *cellLectures = [tableView dequeueReusableCellWithIdentifier:identifierButton
                                                                                forIndexPath:indexPath];
        if (!cellLectures) {
            cellLectures = [[NewLecturesStudentsCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                          reuseIdentifier:identifierButton];
        }
        
        cellLectures.buttonOutlet.enabled = NO;
        
        return cellLectures;
    }
    if ([namesSections[indexPath.section] isEqualToString:@"List"]) {
        StudentsForCourseCell *cellStudents = [tableView dequeueReusableCellWithIdentifier:identifierStudents
                                                                              forIndexPath:indexPath];
        if (!cellStudents) {
            cellStudents = [[StudentsForCourseCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                        reuseIdentifier:identifierStudents];
        }
        
        Student *student = [students objectAtIndex:indexPath.row];
        
        cellStudents.firstNameLabel.text = student.firstName;
        cellStudents.lastNameLabel.text = student.lastName;
        
        
        return cellStudents;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSArray *namesSections = [self sections];
    if ([namesSections[section] isEqualToString:@"Course"]) {
        return @"Курс";
    } else if ([namesSections[section] isEqualToString:@"Button"]) {
        return @"Студенты посещающие данный курс";
    }
    return @"";
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *namesSections = [self sections];
    NSLog(@"indexPath %ld %ld", indexPath.section, indexPath.row);
    if ([namesSections[indexPath.section] isEqualToString:@"Button"]) {
        NSLog(@"Button");
        self.course = [self.courses objectAtIndex:indexPath.section/3];
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if ([cell isKindOfClass:[NewLecturesStudentsCell class]]) {
            NewLecturesStudentsCell *cell2 = (NewLecturesStudentsCell *)cell;
            cell2.buttonOutlet.enabled = YES;
            self.cellLecture = cell2;
        }
    }
    
    if ([namesSections[indexPath.section] isEqualToString:@"Course"]) {
        self.editOutlet.enabled = YES;
        self.course = [self.courses objectAtIndex:indexPath.section/3];
    }
    
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"changeStudent"]) {
        UINavigationController *navigationController = (UINavigationController *)segue.destinationViewController;
        ChangeStudentsForCourseViewController *changeViewController = (ChangeStudentsForCourseViewController *)[[navigationController viewControllers] lastObject];
        //NSLog(@"Course %@", self.course.courseName);
        changeViewController.course = self.course;
    }
    
    if ([segue.identifier isEqualToString:@"editIndentifier"]) {
        UINavigationController *navigationController = (UINavigationController *)segue.destinationViewController;
        EditCourseViewController *editCourseController = (EditCourseViewController *)[[navigationController viewControllers] lastObject];
        editCourseController.course = self.course;
    }
    
}


@end
