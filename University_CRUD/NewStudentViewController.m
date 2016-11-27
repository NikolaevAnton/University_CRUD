//
//  NewStudentViewController.m
//  University_CRUD
//
//  Created by Admin on 24.11.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "NewStudentViewController.h"
#import "DataManager.h"
#import "Student.h"

@interface NewStudentViewController () <UITextFieldDelegate>

@property (strong, nonatomic) DataManager *dataManager;

@end

@implementation NewStudentViewController

- (void)viewDidLoad {
    
    self.nameTextField.delegate = self;
    self.lastNameTextField.delegate = self;
    self.telefonTextField.delegate =self;
    self.emailTextField.delegate = self;
    
    self.dataManager = [DataManager sharedManager];
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)enterNewStudentButton:(UIButton *)sender {
    
    NSString *name = self.nameTextField.text;
    NSString *lastName = self.lastNameTextField.text;
    NSString *telefon = self.telefonTextField.text;
    NSString *email = self.emailTextField.text;
    
    if ([name isEqualToString:@""] || [lastName isEqualToString:@""] ||
        [telefon isEqualToString:@""] || [email isEqualToString:@""]) {
        NSLog(@"@@@@");
    } else {
        [self.dataManager addStudentWithName:name LastName:lastName Telefon:telefon Email:email];
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
            [self.nameTextField becomeFirstResponder];
            break;
        case 1:
            [self.lastNameTextField becomeFirstResponder];
            break;
        case 2:
            if (indexPath.row == 0) {
                [self.telefonTextField becomeFirstResponder];
            } else {
                [self.emailTextField becomeFirstResponder];
            }
            break;
        default:
            break;
    }
    
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.nameTextField resignFirstResponder];
    [self.lastNameTextField resignFirstResponder];
    [self.emailTextField resignFirstResponder];
    [self.telefonTextField resignFirstResponder];
    return YES;
}


@end
