//
//  TeachersViewController.m
//  University_CRUD
//
//  Created by Admin on 27.11.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "TeachersViewController.h"
#import "DataManager.h"
#import "TeacherCell.h"
#import "Teacher.h"
#import "TeacherCoursesCell.h"

@interface TeachersViewController ()

@property (strong, nonatomic) DataManager *dataManager;
@property (strong, nonatomic) NSArray *teachers;


@end

@implementation TeachersViewController

- (NSArray *)getAllTeachers {
    University *university = self.dataManager.university;
    NSSet *setTeachers = university.teachers;
    return [setTeachers allObjects];
}

- (void)viewDidLoad {
    
    self.dataManager = [DataManager sharedManager];
    self.teachers = [self getAllTeachers];
    
    self.dataManager.currentTeacher = nil;
    
    self.editOutlet.enabled = NO;
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelButton:(UIStoryboardSegue *)sender {
    //NSLog(@"cancelButton TeachersViewController");
    self.editOutlet.enabled = NO;
}
- (IBAction)editCanselButton:(UIStoryboardSegue *)sender {
    //NSLog(@"editCanselButton TeachersViewController");
    self.editOutlet.enabled = NO;
    self.teachers = [self getAllTeachers];
    [self.tableView reloadData];
    
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return [self.teachers count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    Teacher *teacher = [self.teachers objectAtIndex:section];
    NSArray *arrayCourses = [teacher.courses allObjects];
    if (arrayCourses.count == 0) {
        return 1;
    } else {
        return 2;
    }
}

- (NSString *)stringCourses:(NSArray<Course *> *)arrayCourses {
    NSMutableString *resultString = [[NSMutableString alloc] init];
    
    for(Course *course in arrayCourses) {
        NSString *stringCourse = [NSString stringWithFormat:@"%@, ",course.courseName];
        [resultString appendString:stringCourse];
    }
    [resultString deleteCharactersInRange:NSMakeRange([resultString length] - 1, 1)];
    [resultString deleteCharactersInRange:NSMakeRange([resultString length] - 1, 1)];
    [resultString appendString:@"."];
    return resultString;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"teacherCell";
    static NSString *identifierCourse = @"teacherCoursesCell";
    
    Teacher *teacher = [self.teachers objectAtIndex:indexPath.section];
    NSArray *arrayCourses = [teacher.courses allObjects];
    
    if (indexPath.row == 0) {
        TeacherCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        
        if (!cell) {
            cell = [[TeacherCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        cell.firstNameLabel.text = teacher.firstName;
        cell.lastNameLabel.text = teacher.lastName;
        
        return cell;
    } else {
        TeacherCoursesCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCourse forIndexPath:indexPath];
        
        if (!cell) {
            cell = [[TeacherCoursesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCourse];
        }
        
        cell.cousesLabel.text = [self stringCourses:arrayCourses];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.editOutlet.enabled = YES;
    self.dataManager.currentTeacher = [self.teachers objectAtIndex:indexPath.row];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
