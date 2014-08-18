//
//  PBCustomCell.m
//  Peek-a-Boo
//
//  Created by Alejandro Tami on 16/08/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import "PBCustomCell.h"

@implementation PBCustomCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}

- (id) init
{
    self = [super init];
    
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
