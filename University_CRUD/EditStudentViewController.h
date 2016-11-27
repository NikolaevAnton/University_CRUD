//
//  EditStudentViewController.h
//  University_CRUD
//
//  Created by Admin on 24.11.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Student.h"

@interface EditStudentViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *mobLabel;

@property (weak, nonatomic) IBOutlet UILabel *emailLabel;

@property (weak, nonatomic) IBOutlet UITextField *nameNewTextField;


@property (weak, nonatomic) IBOutlet UITextField *lastNameNewTextField;

@property (weak, nonatomic) IBOutlet UITextField *telefonNewTextField;

@property (weak, nonatomic) IBOutlet UITextField *emailNewTextField;

@property (strong, nonatomic) Student *student;

- (IBAction)removeButton:(UIButton *)sender;

- (IBAction)insertButton:(UIButton *)sender;


@end
