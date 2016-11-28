//
//  ChangeStudentsForCourseViewController.m
//  University_CRUD
//
//  Created by Admin on 28.11.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "ChangeStudentsForCourseViewController.h"
#import "ChangeStudentCellTableViewCell.h"
#import "DataManager.h"
#import "Student.h"

@interface ChangeStudentsForCourseViewController ()

@property (strong, nonatomic) DataManager *dataManager;
@property (strong, nonatomic) NSArray *students;

@end

@implementation ChangeStudentsForCourseViewController

- (void)viewDidLoad {
    self.dataManager = [DataManager sharedManager];
    self.students = [self.dataManager.university.students allObjects];
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataManager.university.students count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *changeStudent = @"changeStudent";
    
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
    [cell.studentSwitch setOn:NO];
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ChangeStudentCellTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        NSLog(@"row %d change %d", indexPath.row, cell.studentSwitch.on);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}


@end
