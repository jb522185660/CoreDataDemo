//
//  Users.h
//  CoreDataDemo
//
//  Created by Jack on 5/4/14.
//  Copyright (c) 2014 qida. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Users : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * sex;
@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSString * phoneNumber;
@property (nonatomic, retain) NSData * avatar;

@end
