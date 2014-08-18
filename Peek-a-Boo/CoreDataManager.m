//
//  CoreDataManager.m
//  LostCharactersDataBase
//
//  Created by Alejandro Tami on 12/08/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import "CoreDataManager.h"
#import "PBAppDelegate.h"


@interface CoreDataManager()

@property NSManagedObjectContext *context;


@end

@implementation CoreDataManager

static CoreDataManager *coreDataManager = nil;

+ (instancetype) getInstance
{
    if (coreDataManager) {
        return coreDataManager;
    } else {
        coreDataManager = [CoreDataManager new];
        
        coreDataManager.context =  ((PBAppDelegate*)[[UIApplication sharedApplication] delegate]).managedObjectContext;
        return coreDataManager;
    }
}

- (NSManagedObjectContext*) getContext
{
    return self.context;
}

- (NSManagedObject*) getObjectForEntityNamed:(NSString*) name
{
    return [NSEntityDescription insertNewObjectForEntityForName:name inManagedObjectContext:self.context];
}

- (NSFetchedResultsController*) fetchResultsForEntity:(NSString*) name
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:name];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
       
    NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc]
                                                            initWithFetchRequest:request
                                                            managedObjectContext:self.context
                                                            sectionNameKeyPath:nil
                                                            cacheName:@"Peek-a-Boo"];
    
  
    NSError *error = nil;
    BOOL fetchedOK =[fetchedResultsController performFetch:nil];
    
    if (!fetchedOK) {
        NSLog(@"NSError fetching = %@", error);
    } else {
        NSLog(@"Objects fetched %lu", (unsigned long)[fetchedResultsController fetchedObjects].count);
    }
    
    return fetchedResultsController;
}

- (BOOL) save
{
    NSError *error = nil;
    BOOL savedOK = [self.context save:&error];
    
    if (!savedOK) {
        NSLog(@"NSError saving = %@", error);
    }
    
    return savedOK;
    
}

@end
