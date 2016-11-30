//
//  NewCourseViewController.m
//  University_CRUD
//
//  Created by Admin on 27.11.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "NewCourseViewController.h"
#import "DataManager.h"
#import "Teacher.h"


@interface NewCourseViewController () <UITextFieldDelegate>

@property (strong, nonatomic) DataManager *dataManager;

@end

@implementation NewCourseViewController


- (void)viewDidLoad {
    
    self.nameCourseTextField.delegate = self;
    self.subjectTextField.delegate = self;
    self.sectionTextField.delegate = self;
    
    self.dataManager = [DataManager sharedManager];
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
            [self.nameCourseTextField becomeFirstResponder];
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

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.nameCourseTextField resignFirstResponder];
    [self.subjectTextField resignFirstResponder];
    [self.sectionTextField resignFirstResponder];
    return YES;
}



#pragma mark - Navigation
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addCourseButton:(UIButton *)sender {
    
    NSString *course = self.nameCourseTextField.text;
    NSString *subject = self.subjectTextField.text;
    NSString *section = self.sectionTextField.text;
    Teacher *teacher = self.dataManager.currentTeacher;
    
    if ([course isEqualToString:@""] || [subject isEqualToString:@""] || [section isEqualToString:@""]) {
        NSLog(@"не заполнены текстфилды!");
    } else {
        [self.dataManager addCourseWithCourseName:course Subject:subject Sector:section Teacher:teacher];
    }
    
}

- (IBAction)cancelButtonNewTeacher:(UIStoryboardSegue *)sender {
    //NSLog(@"cancelButtonNewTeacher");
    self.dataManager.currentTeacher = nil;
}
- (IBAction)editCanselButtonNewTeacher:(UIStoryboardSegue *)sender {
    //NSLog(@"editCanselButtonNewTeacher");
    self.teacherLabel.text = [NSString stringWithFormat:@"%@ %@",
                              self.dataManager.currentTeacher.firstName, self.dataManager.currentTeacher.lastName];
}

@end
