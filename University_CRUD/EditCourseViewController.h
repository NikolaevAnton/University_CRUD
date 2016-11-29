//
//  EditCourseViewController.h
//  University_CRUD
//
//  Created by Admin on 27.11.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Course.h"

@interface EditCourseViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UILabel *nameCourseLabel;
@property (weak, nonatomic) IBOutlet UILabel *subjectCourseLabel;
@property (weak, nonatomic) IBOutlet UILabel *sectionCourseLabel;
@property (weak, nonatomic) IBOutlet UILabel *teacherCourseLabel;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *subjectTextField;
@property (weak, nonatomic) IBOutlet UITextField *sectionTextField;


@property(strong, nonatomic) Course *course;
- (IBAction)updateDBButton:(UIButton *)sender;

@end
