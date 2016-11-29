//
//  ChangeStudentsForCourseViewController.h
//  University_CRUD
//
//  Created by Admin on 28.11.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Course.h"

@interface ChangeStudentsForCourseViewController : UITableViewController

- (IBAction)agreeButton:(UIButton *)sender;

@property (strong, nonatomic) Course *course;

@end
