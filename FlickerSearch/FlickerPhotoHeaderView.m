//
//  FlickerPhotoHeaderView.m
//  FlickerSearch
//
//  Created by dmi on 21/08/15.
//  Copyright (c) 2015 dmi. All rights reserved.
//

#import "FlickerPhotoHeaderView.h"

@implementation FlickerPhotoHeaderView


-(void)setSearchText:(NSString *)text
{

    self.searchLabel.text = text;
    UIImage *shareButtonImage  = [[UIImage imageNamed:@"header_bg.png"] resizableImageWithCapInsets: UIEdgeInsetsMake(68, 68, 68, 68) ];
    self.backgroundImageView.image = shareButtonImage;
    self.backgroundImageView.center = self.center;

}

@end
