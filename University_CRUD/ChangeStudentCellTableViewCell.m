//
//  ChangeStudentCellTableViewCell.m
//  University_CRUD
//
//  Created by Admin on 28.11.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "ChangeStudentCellTableViewCell.h"

@interface ChangeStudentCellTableViewCell()


@end

@implementation ChangeStudentCellTableViewCell

- (void)awakeFromNib {

    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)switchStudent:(UISwitch *)sender {
    [self.delegateController changeForCell:self];
}
@end
