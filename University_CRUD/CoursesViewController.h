//
//  CoursesViewController.h
//  University_CRUD
//
//  Created by Admin on 25.11.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoursesViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UIButton *buttonOutlet;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *editOutlet;

- (IBAction)cancelButton:(UIStoryboardSegue *)sender;
- (IBAction)editCanselButton:(UIStoryboardSegue *)sender;

@end
