//
//  PBViewController.m
//  Peek-a-Boo
//
//  Created by Alejandro Tami on 15/08/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import "PBViewController.h"
#import "CoreDataManager.h"
#import "PBCustomCell.h"
#import "PBUserPhotosViewController.h"
#import "PBAddViewController.h"

@interface PBViewController () <UICollectionViewDataSource, UICollectionViewDelegate, NSFetchedResultsControllerDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property NSFetchedResultsController *frc;
@property UIScrollView *browserScrollView;

@end

@implementation PBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onDoubleTap:)];
    [tap setNumberOfTapsRequired:2];
    [tap setNumberOfTouchesRequired:1];
    tap.delaysTouchesBegan = YES;
    
    [self.view addGestureRecognizer:tap];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    self.frc = [[CoreDataManager getInstance] fetchResultsForEntity:@"User"];
    [self.collectionView reloadData];
    
}

- (IBAction)onDoubleTap:(UITapGestureRecognizer *)sender
{
    
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PBAddViewController* overlay =  [sb instantiateViewControllerWithIdentifier:@"PBViewController"];
    
    PBCustomCell *cell = (PBCustomCell*)[self.collectionView cellForItemAtIndexPath:[self.collectionView indexPathForItemAtPoint:[sender locationInView:self.collectionView]]];
    
    if ([cell isKindOfClass:[PBCustomCell class]])
    {
        overlay.user = cell.user;
    }
    
    
    [UIView transitionFromView:self.view
                        toView:overlay.view
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    completion:^(BOOL finished) {
                         [self presentViewController:overlay animated:NO completion:nil];
                    }];
    

   
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(PBCustomCell*)sender
{
    ((PBUserPhotosViewController*)segue.destinationViewController).user = sender.user;
}


#pragma mark collection delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //[self configureAndShowBrowserView: ((User*)[self.frc objectAtIndexPath:indexPath]).photos ];
}

#pragma mark collection datasource methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[self.frc.sections objectAtIndex:section] numberOfObjects] ;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PBCustomCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.imageView.image = [UIImage imageWithData: ((User*)[self.frc objectAtIndexPath:indexPath]).profilePhoto];
    cell.user = [self.frc objectAtIndexPath:indexPath];
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    return cell;
}

#pragma mark fetchedresultscontroller delegate
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.collectionView reloadData];
}

- (IBAction)onUnwindSegue:(UIStoryboardSegue*)sender
{
    
}

@end
