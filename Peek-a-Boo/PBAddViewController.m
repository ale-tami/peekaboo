//
//  PBAddViewController.m
//  Peek-a-Boo
//
//  Created by Alejandro Tami on 15/08/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import "PBAddViewController.h"
#import "CoreDataManager.h"
#import "PBMapViewController.h"
#import "User.h"


@interface PBAddViewController ()  <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *addressField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;

@property UIImagePickerController *imagePicker;

@end

@implementation PBAddViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.imagePicker = [UIImagePickerController new];
    self.imagePicker.delegate = self;
    
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    if (self.user) {
        self.view.alpha = 0.6;
        
        self.userNameField.text = self.user.name;
        self.addressField.text = self.user.address;
        self.phoneField.text = self.user.phone;
        self.emailField.text = self.user.email;
        self.imageView.image = [UIImage imageWithData:self.user.profilePhoto];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 16, 16);
        [button setImage:[UIImage imageNamed:@"Info.png"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(toMap:) forControlEvents:UIControlEventTouchUpInside];
        
        self.addressField.rightView = button;
        self.addressField.rightViewMode = UITextFieldViewModeUnlessEditing;

        
    }
}


- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    
    [self saveData];
}

- (IBAction)toMap:(id)sender
{
    
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PBMapViewController* overlay =  [sb instantiateViewControllerWithIdentifier:@"PBMapViewController"];
    
    [UIView transitionFromView:self.view
                        toView:overlay.view
                      duration:0.5
                       options:UIViewAnimationOptionTransitionCurlUp
                    completion:^(BOOL finished) {
                        
                    }];

}

- (IBAction)onSwipe:(UISwipeGestureRecognizer *)sender
{
    [UIView transitionFromView:self.view
                        toView:[self presentingViewController].view
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    completion:^(BOOL finished) {
                   //      [[self presentingViewController] dismissViewControllerAnimated:NO completion:nil];
                    }];
       
}

- (void) saveData
{
    User *user = (User*)[[CoreDataManager getInstance] getObjectForEntityNamed:@"User"];
    
    user.name = self.userNameField.text;
    user.address = self.addressField.text;
    user.phone = self.phoneField.text;
    user.email = self.emailField.text;
    user.profilePhoto = UIImageJPEGRepresentation(self.imageView.image, 0.0);
    
    [[CoreDataManager getInstance] save];
    
    self.userNameField.text = nil;
    self.addressField.text = nil;
    self.phoneField.text = nil;
    self.emailField.text = nil;
    self.imageView.image = nil;
}

- (IBAction)onSave:(UIBarButtonItem *)sender
{
    [self saveData];
}

- (IBAction)onAddProfilePhoto:(UIButton *)sender
{
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.imageView.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



@end
