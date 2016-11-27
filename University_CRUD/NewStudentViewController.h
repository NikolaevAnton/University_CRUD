//
//  NewStudentViewController.h
//  University_CRUD
//
//  Created by Admin on 24.11.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewStudentViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;

@property (weak, nonatomic) IBOutlet UITextField *telefonTextField;

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

- (IBAction)enterNewStudentButton:(UIButton *)sender;


@end
