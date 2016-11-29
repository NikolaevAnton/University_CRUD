//
//  ChangeStudentCellTableViewCell.h
//  University_CRUD
//
//  Created by Admin on 28.11.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChangeStudentsForCourseViewController.h"



@protocol ChangeStudentDelegate;

@interface ChangeStudentCellTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *lastNameLabel;

@property (weak, nonatomic) IBOutlet UISwitch *studentSwitch;

@property (weak, nonatomic) id <ChangeStudentDelegate> delegateController;

- (IBAction)switchStudent:(UISwitch *)sender;

@end

@protocol ChangeStudentDelegate <NSObject>

- (void)changeForCell:(ChangeStudentCellTableViewCell *) cell;

@end

