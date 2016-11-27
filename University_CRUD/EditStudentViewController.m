//
//  EditStudentViewController.m
//  University_CRUD
//
//  Created by Admin on 24.11.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "EditStudentViewController.h"
#import "DataManager.h"

@interface EditStudentViewController () <UITextFieldDelegate>

@property (strong, nonatomic) DataManager *dataManager;

@end

@implementation EditStudentViewController

- (void)viewDidLoad {
    
    self.nameNewTextField.delegate = self;
    self.lastNameNewTextField.delegate = self;
    self.telefonNewTextField.delegate = self;
    self.emailNewTextField.delegate = self;
    
    self.nameLabel.text = self.student.firstName;
    self.lastNameLabel.text = self.student.lastName;
    self.emailLabel.text = self.student.email;
    self.mobLabel.text = self.student.telefon;
    
    self.dataManager = [DataManager sharedManager];
    
    [super viewDidLoad];
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)removeButton:(UIButton *)sender {
    
    [self.dataManager.managedObjectContext deleteObject:self.student];
    [self.dataManager.university removeStudentsObject:self.student];
    [self.dataManager.managedObjectContext save:nil];
    
}

- (IBAction)insertButton:(UIButton *)sender {
    
    if (![self.nameNewTextField.text isEqualToString:@""]) {
        self.student.firstName = self.nameNewTextField.text;
    }
    if (![self.lastNameNewTextField.text isEqualToString:@""]) {
        self.student.lastName = self.lastNameNewTextField.text;
    }
    if (![self.emailNewTextField.text isEqualToString:@""]) {
        self.student.email = self.emailNewTextField.text;
    }
    if (![self.telefonNewTextField.text isEqualToString:@""]) {
        self.student.telefon = self.telefonNewTextField.text;
    }
    
    [self.dataManager.managedObjectContext save:nil];
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                [self.nameNewTextField becomeFirstResponder];
                break;
            case 1:
                [self.lastNameNewTextField becomeFirstResponder];
                break;
            case 2:
                [self.telefonNewTextField becomeFirstResponder];
                break;
            case 3:
                [self.emailNewTextField becomeFirstResponder];
                break;
            default:
                break;
        }
    }
    
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.nameNewTextField resignFirstResponder];
    [self.lastNameNewTextField resignFirstResponder];
    [self.telefonNewTextField resignFirstResponder];
    [self.emailNewTextField resignFirstResponder];
    return YES;
}


@end
