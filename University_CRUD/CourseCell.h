//
//  CourseCell.h
//  University_CRUD
//
//  Created by Admin on 28.11.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CourseCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *subjectLabel;
@property (weak, nonatomic) IBOutlet UILabel *sectionLabel;
@property (weak, nonatomic) IBOutlet UILabel *teacherLabel;


@end
