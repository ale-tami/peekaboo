//
//  PBCustomCell.h
//  Peek-a-Boo
//
//  Created by Alejandro Tami on 16/08/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface PBCustomCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property User *user;

@end
