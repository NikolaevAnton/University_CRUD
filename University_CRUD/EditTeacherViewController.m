//
//  EditTeacherViewController.m
//  University_CRUD
//
//  Created by Admin on 27.11.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "EditTeacherViewController.h"
#import "DataManager.h"
#import "Teacher.h"

@interface EditTeacherViewController () <UITextFieldDelegate>

@property (strong, nonatomic) DataManager *dataManager;

@end

@implementation EditTeacherViewController

- (void)viewDidLoad {
    self.dataManager = [DataManager sharedManager];
    
    self.nameLabel.text = self.dataManager.currentTeacher.firstName;
    self.lastNameLabel.text = self.dataManager.currentTeacher.lastName;
    
    self.nameTextField.delegate = self;
    self.lastNameTextField.delegate = self;
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)enterTeacherButton:(UIButton *)sender {
    
    NSString *name = self.nameTextField.text;
    NSString *lastName = self.lastNameTextField.text;
    
    if (![name isEqualToString:@""]) {
        self.dataManager.currentTeacher.firstName = name;
    }
    
    if (![lastName isEqualToString:@""]) {
        self.dataManager.currentTeacher.lastName = lastName;
    }
    [self.dataManager.managedObjectContext save:nil];
}

- (IBAction)deleteTeacherButton:(UIButton *)sender {
    [self.dataManager.managedObjectContext deleteObject:self.dataManager.currentTeacher];
    [self.dataManager.managedObjectContext save:nil];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                [self.nameTextField becomeFirstResponder];
                break;
            case 1:
                [self.lastNameTextField becomeFirstResponder];
            default:
                break;
        }
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.nameTextField resignFirstResponder];
    [self.lastNameTextField resignFirstResponder];
    return YES;
}

@end
