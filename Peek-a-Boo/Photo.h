//
//  Photo.h
//  Peek-a-Boo
//
//  Created by Alejandro Tami on 15/08/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface Photo : NSManagedObject

@property (nonatomic, retain) NSData * photo;
@property (nonatomic, retain) User *user;

@end
