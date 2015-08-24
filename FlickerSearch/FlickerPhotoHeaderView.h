//
//  FlickerPhotoHeaderView.h
//  FlickerSearch
//
//  Created by dmi on 21/08/15.
//  Copyright (c) 2015 dmi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlickerPhotoHeaderView : UICollectionReusableView

@property(weak) IBOutlet UIImageView *backgroundImageView;
@property(weak) IBOutlet UILabel *searchLabel;

-(void)setSearchText : (NSString *)text;

@end
