//
//  CoreDataManager.h
//  LostCharactersDataBase
//
//  Created by Alejandro Tami on 12/08/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataManager : NSObject

+ (instancetype) getInstance;

- (NSManagedObjectContext*) getContext;
- (NSManagedObject*) getObjectForEntityNamed:(NSString*) name;
- (NSFetchedResultsController*) fetchResultsForEntity:(NSString*) name;

- (BOOL) save;

@end
