//
//  NewCourseViewController.h
//  University_CRUD
//
//  Created by Admin on 27.11.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewCourseViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *nameCourseTextField;
@property (weak, nonatomic) IBOutlet UITextField *subjectTextField;
@property (weak, nonatomic) IBOutlet UITextField *sectionTextField;

@property (weak, nonatomic) IBOutlet UILabel *teacherLabel;

- (IBAction)addCourseButton:(UIButton *)sender;

- (IBAction)cancelButtonNewTeacher:(UIStoryboardSegue *)sender;
- (IBAction)editCanselButtonNewTeacher:(UIStoryboardSegue *)sender;

@end
