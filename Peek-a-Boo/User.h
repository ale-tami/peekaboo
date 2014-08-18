//
//  User.h
//  Peek-a-Boo
//
//  Created by Alejandro Tami on 15/08/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSData * profilePhoto;
@property (nonatomic, retain) NSSet *photos;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addPhotosObject:(NSManagedObject *)value;
- (void)removePhotosObject:(NSManagedObject *)value;
- (void)addPhotos:(NSSet *)values;
- (void)removePhotos:(NSSet *)values;

@end
