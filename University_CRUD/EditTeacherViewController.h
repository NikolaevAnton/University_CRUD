//
//  EditTeacherViewController.h
//  University_CRUD
//
//  Created by Admin on 27.11.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditTeacherViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *lastNameLabel;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;

- (IBAction)enterTeacherButton:(UIButton *)sender;

- (IBAction)deleteTeacherButton:(UIButton *)sender;


@end
