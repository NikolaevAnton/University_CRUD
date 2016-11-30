//
//  EditTeacherForCourseViewController.m
//  University_CRUD
//
//  Created by Admin on 30.11.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "EditTeacherForCourseViewController.h"
#import "DataManager.h"
#import "EditTeacherForCourseCell.h"

@interface EditTeacherForCourseViewController ()

@property (strong, nonatomic) DataManager *dataManager;
@property (strong, nonatomic) NSArray *teachers;

@end

@implementation EditTeacherForCourseViewController

- (NSArray *)getAllTeachers {
    University *university = self.dataManager.university;
    NSSet *setTeachers = university.teachers;
    return [setTeachers allObjects];
}

- (void)viewDidLoad {
    self.addOutlet.enabled = NO;
    self.dataManager = [DataManager sharedManager];
    self.teachers = [self getAllTeachers];
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.teachers count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"editTeacherForCourseCell";
    
    EditTeacherForCourseCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[EditTeacherForCourseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    Teacher *teacher = [self.teachers objectAtIndex:indexPath.row];
    
    cell.nameLabel.text = teacher.firstName;
    cell.lastNameLabel.text = teacher.lastName;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.addOutlet.enabled = YES;
    self.dataManager.currentTeacher = [self.teachers objectAtIndex:indexPath.row];
}


@end
