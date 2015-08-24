//
//  FlickrPhotoCell.h
//  FlickerSearch
//
//  Created by dmi on 20/08/15.
//  Copyright (c) 2015 dmi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FlickrPhoto;

@interface FlickrPhotoCell : UICollectionViewCell

@property(nonatomic,strong) IBOutlet UIImageView *imageview;
@property(nonatomic,strong) FlickrPhoto *photo;
-(void)setPhoto:(FlickrPhoto *)photo;
@end
