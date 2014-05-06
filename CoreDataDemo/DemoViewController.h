//
//  DemoViewController.h
//  CoreDataDemo
//
//  Created by Jack on 5/4/14.
//  Copyright (c) 2014 qida. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DemoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *sexTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;
@property (weak, nonatomic) IBOutlet UITableView *userTableView;

- (IBAction)selectAvatar:(id)sender;

- (IBAction)save:(id)sender;

@end
