//
//  PBUserPhotosViewController.m
//  Peek-a-Boo
//
//  Created by Alejandro Tami on 17/08/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import "PBUserPhotosViewController.h"
#import "CoreDataManager.h"
#import "Photo.h"

@interface PBUserPhotosViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *view;

@property UIImagePickerController *imagePicker;

@end

@implementation PBUserPhotosViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureAndShowBrowserView:self.user.photos];
    
    self.imagePicker = [UIImagePickerController new];
    self.imagePicker.delegate = self;
    
    self.scrollView.pagingEnabled = YES;

}


- (void) configureAndShowBrowserView:(NSSet*) photos
{
    float width = 0.0;
    
    for (Photo *photo in photos) {
        
        UIImage *image = [UIImage imageWithData:photo.photo];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.scrollView addSubview:imageView];
        
        width += imageView.frame.size.width;
    }
    
    self.scrollView.contentSize = CGSizeMake(width, self.scrollView.frame.size.height);
    
}

- (IBAction)onAddPhoto:(UIBarButtonItem *)sender
{
    
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:self.imagePicker animated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    NSMutableSet *set = [NSMutableSet setWithSet: self.user.photos ];
    Photo *photo = (Photo*)[[CoreDataManager getInstance] getObjectForEntityNamed:@"Photo"];
    photo.photo = UIImageJPEGRepresentation([info objectForKey:UIImagePickerControllerOriginalImage],0.0);
    
    [set addObject: photo ];
    self.user.photos = set;
    
    [[CoreDataManager getInstance] save];
    
    [self configureAndShowBrowserView:self.user.photos];
    
    [self dismissViewControllerAnimated:YES completion:nil];
   
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
