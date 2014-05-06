//
//  DemoViewController.m
//  CoreDataDemo
//
//  Created by Jack on 5/4/14.
//  Copyright (c) 2014 qida. All rights reserved.
//

#import "DemoViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "AppDelegate.h"
#import "Users.h"

#define iOS7  [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0

@interface DemoViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (strong,nonatomic)UIImage *currentImage;
@property (strong,nonatomic)NSMutableArray *dataSource;

@end

@implementation DemoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)selectAvatar:(id)sender{
    BOOL truefalse = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
    if (truefalse) {
        UIImagePickerController *imageController = [[UIImagePickerController alloc] init];
        imageController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imageController.allowsEditing = YES;
        imageController.delegate = self;
        [self presentViewController:imageController animated:YES completion:^{}];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
//    NSData *data = UIImagePNGRepresentation(editedImage);
    self.currentImage = editedImage;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    Users *user = [_dataSource objectAtIndex:indexPath.row];
    cell.textLabel.text = user.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@->%@->%@",user.sex,user.phoneNumber,user.age];
    cell.detailTextLabel.adjustsFontSizeToFitWidth = true;
    cell.imageView.image = [UIImage imageWithData:user.avatar];
    return cell;
}


- (IBAction)save:(id)sender{
    for (UITextField *textField in self.view.subviews) {
        if ([textField isKindOfClass:[UITextField class]]) {
            [textField resignFirstResponder];
        }
    }
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    Users *users = [NSEntityDescription insertNewObjectForEntityForName:@"Users" inManagedObjectContext:context];
    users.name = _nameTextField.text;
    users.sex = [NSNumber numberWithInt:[_sexTextField.text boolValue]];
    users.phoneNumber = _phoneNumberTextField.text;
    users.age = [NSNumber numberWithInt:[_ageTextField.text intValue]];
    users.avatar = UIImagePNGRepresentation(_currentImage);
    NSError *error = NULL;
    BOOL success = [context save:&error];
    if (!success) {
        NSLog(@"%@",[error localizedDescription]);
    }

    [self updateDataSource];
    
}

-(void)updateDataSource{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Users"];
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    if (error==nil) {
        self.dataSource = [NSMutableArray arrayWithArray:fetchedObjects];
    }
    [_userTableView reloadData];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return true;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self updateDataSource];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
