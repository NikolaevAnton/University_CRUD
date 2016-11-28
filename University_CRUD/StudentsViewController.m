//
//  StudentsViewController.m
//  University_CRUD
//
//  Created by Admin on 24.11.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "StudentsViewController.h"
#import "StudentsCell.h"
#import "Student.h"
#import "DataManager.h"
#import "University.h"
#import "EditStudentViewController.h"



@interface StudentsViewController ()

@property (strong, nonatomic) DataManager *dataManager;
@property (strong, nonatomic) NSArray<Student *> *students;
@property (assign, nonatomic) NSInteger numberStudent;

@end

@implementation StudentsViewController

- (NSArray *)allStudents {
    
    University *university = self.dataManager.university;
    NSSet *setStudents = university.students;
    return [setStudents allObjects];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.editButtonOutlet.enabled = NO;
    
    self.dataManager = [DataManager sharedManager];
    
    self.students = [self allStudents];
    
    
    
    /*
     Задание для базы 10 рандомных студентов
     */
//    [self.dataManager add10ItemContent];
//    self.students = [self allStudents];
    
    /*
     Получение массива всех студентов из сета университета.
     */
    
    //[self.dataManager printUniverInfo];
    
    /*
     Удаление всех объектов из базы
     */
    //[self.dataManager deleteAllObjectsInDataBase];

    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)cancelButton:(UIStoryboardSegue *)sender {
    self.editButtonOutlet.enabled = NO;
    self.students = [self allStudents];
    self.numberStudent = -1;
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.students count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *indentifier = @"StudentsCell";
    StudentsCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[StudentsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    
    
    Student *student = [self.students objectAtIndex:indexPath.row];
    cell.nameLabel.text = student.firstName;
    cell.lastNameLabel.text = student.lastName;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.editButtonOutlet.enabled = YES;
    self.numberStudent = indexPath.row;
}


#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"editStudent"]) {
        Student *student = [self.students objectAtIndex:self.numberStudent];
        UINavigationController *navigationController = (UINavigationController *)segue.destinationViewController;
        EditStudentViewController *editStudentViewController = (EditStudentViewController *)[[navigationController viewControllers] lastObject];
        editStudentViewController.student = student;
    }
}


@end
