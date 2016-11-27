//
//  StudentsViewController.h
//  University_CRUD
//
//  Created by Admin on 24.11.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudentsViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButtonOutlet;


- (IBAction)cancelButton:(UIStoryboardSegue *)sender;

@end
