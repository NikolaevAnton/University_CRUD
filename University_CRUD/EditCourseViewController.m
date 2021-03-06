//
//  EditCourseViewController.m
//  University_CRUD
//
//  Created by Admin on 27.11.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "EditCourseViewController.h"
#import "Teacher.h"
#import "DataManager.h"

@interface EditCourseViewController () <UITextFieldDelegate>

@property (strong, nonatomic) DataManager *dataManager;

@end

@implementation EditCourseViewController

- (void)viewDidLoad {
    
    self.nameCourseLabel.text = self.course.courseName;
    self.subjectCourseLabel.text = self.course.subject;
    self.sectionCourseLabel.text = self.course.sector;
    
    self.teacherCourseLabel.text = [NSString stringWithFormat:@"%@ %@",
                                    self.course.teacher.firstName, self.course.teacher.lastName];
    self.nameTeacherLabel.text = [NSString stringWithFormat:@"%@ %@",
                                  self.course.teacher.firstName, self.course.teacher.lastName];
    
    self.nameTextField.delegate = self;
    self.subjectTextField.delegate = self;
    self.sectionTextField.delegate = self;
    
    self.dataManager = [DataManager sharedManager];
    
    self.dataManager.currentTeacher = nil;
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                [self.nameTextField becomeFirstResponder];
                break;
            case 1:
                [self.subjectTextField becomeFirstResponder];
                break;
            case 2:
                [self.sectionTextField becomeFirstResponder];
                break;
            default:
                break;
        }
    }
}

- (IBAction)updateDBButton:(UIButton *)sender {
    
    if (![self.nameTextField.text isEqualToString:@""]) {
        self.course.courseName = self.nameTextField.text;
    }
    if (![self.subjectTextField.text isEqualToString:@""]) {
        self.course.subject = self.subjectTextField.text;
    }
    if (![self.sectionTextField.text isEqualToString:@""]) {
        self.course.sector = self.sectionTextField.text;
    }
    
    if (![self.dataManager.currentTeacher isEqual:nil]) {
        self.course.teacher = self.dataManager.currentTeacher;
    }
    
    [self.dataManager.managedObjectContext save:nil];
    
}

- (IBAction)deleteCourseButton:(UIButton *)sender {
    [self.dataManager.managedObjectContext deleteObject:self.course];
    [self.dataManager.managedObjectContext save:nil];
}


- (IBAction)cancelButtonChangeTeacher:(UIStoryboardSegue *)sender {
    NSLog(@"cancelButtonChangeTeacher");
}
- (IBAction)editCanselButtonChangeTeacher:(UIStoryboardSegue *)sender {
    
    self.nameTeacherLabel.text = [NSString stringWithFormat:@"%@ %@",
                                  self.dataManager.currentTeacher.firstName, self.dataManager.currentTeacher.lastName];
    
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.nameTextField resignFirstResponder];
    [self.subjectTextField resignFirstResponder];
    [self.sectionTextField resignFirstResponder];
    return YES;
}


@end
