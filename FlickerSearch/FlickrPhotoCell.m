//
//  FlickrPhotoCell.m
//  FlickerSearch
//
//  Created by dmi on 20/08/15.
//  Copyright (c) 2015 dmi. All rights reserved.
//

#import "FlickrPhotoCell.h"
#import "FlickrPhoto.h"
@implementation FlickrPhotoCell

-(void)setPhoto:(FlickrPhoto *)photo {
    
    if(_photo != photo) {
        _photo = photo;
    }
    self.imageview.image = _photo.thumbnail;
    self.hidden = false;
    self.imageview.hidden = false;
}

@end
