//
//  NewTeacherViewController.h
//  University_CRUD
//
//  Created by Admin on 27.11.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewTeacherViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *nameTeacherTextField;

@property (weak, nonatomic) IBOutlet UITextField *lastNameTeacherTextField;

- (IBAction)addTeacherButton:(UIButton *)sender;

@end
