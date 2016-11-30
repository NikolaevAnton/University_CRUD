//
//  NewTeacherViewController.m
//  University_CRUD
//
//  Created by Admin on 27.11.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "NewTeacherViewController.h"
#import "DataManager.h"

@interface NewTeacherViewController () <UITextFieldDelegate>

@property (strong, nonatomic) DataManager *dataManager;

@end

@implementation NewTeacherViewController

- (void)viewDidLoad {
    
    self.nameTeacherTextField.delegate = self;
    self.lastNameTeacherTextField.delegate = self;
    
    self.dataManager = [DataManager sharedManager];
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                [self.nameTeacherTextField becomeFirstResponder];
                break;
            case 1:
                [self.lastNameTeacherTextField becomeFirstResponder];
            default:
                break;
        }
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.nameTeacherTextField resignFirstResponder];
    [self.lastNameTeacherTextField resignFirstResponder];
    return YES;
}



- (IBAction)addTeacherButton:(UIButton *)sender {
    
    NSString *name = self.nameTeacherTextField.text;
    NSString *lastName = self.lastNameTeacherTextField.text;
    
    if ([name isEqualToString:@""] || [lastName isEqualToString:@""]) {
        NSLog(@"");
    } else {
        
    }
    
}
@end
