//
//  ChangeStudentCellTableViewCell.m
//  University_CRUD
//
//  Created by Admin on 28.11.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "ChangeStudentCellTableViewCell.h"
#import "DataManager.h"

@interface ChangeStudentCellTableViewCell()

@property (strong, nonatomic) DataManager *dataManager;

@end

@implementation ChangeStudentCellTableViewCell

- (void)awakeFromNib {
    self.dataManager = [DataManager sharedManager];
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)switchStudent:(UISwitch *)sender {
    if (sender.on) {
        self.dataManager.change = YES;
    } else {
        self.dataManager.change = NO;
    }
    
}
@end
