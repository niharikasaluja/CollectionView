//
//  ViewController.m
//  FlickerSearch
//
//  Created by dmi on 20/08/15.
//  Copyright (c) 2015 dmi. All rights reserved.
//

#import "ViewController.h"
#import "Flickr.h"
#import "FlickrPhoto.h"
#import "FlickrPhotoCell.h"
#import "FlickerPhotoHeaderView.h"


@interface ViewController () <UITextFieldDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) NSMutableDictionary *searchResults;
@property (nonatomic,strong) NSMutableArray *searches;
@property(nonatomic,strong) Flickr *flickr;

@property (nonatomic,weak) IBOutlet UIToolbar *toolBar;
@property (nonatomic,weak) IBOutlet UIBarButtonItem *shareButton;
@property(nonatomic,weak) IBOutlet UITextField *textField;

@property(nonatomic,weak) IBOutlet UICollectionView *collectionView;


@property (nonatomic) BOOL sharing;


-(IBAction)shareButtonTapped:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_cork.png"]];
    UIImage *navBarImage = [[UIImage imageNamed:@"navbar.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(27, 27, 27, 27)];
    [self.toolBar setBackgroundImage:navBarImage forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];

    
    UIImage *shareButtonImage = [[UIImage imageNamed:@"button.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
    [self.shareButton setBackgroundImage:shareButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    UIImage *textFieldImage =[[UIImage imageNamed:@"search_field.png"]resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [self.textField setBackground:textFieldImage];
    
    
    self.searches = [@[] mutableCopy];
    self.searchResults = [@{} mutableCopy];
    self.flickr = [[Flickr alloc]init];
    
    
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"FlickerCell"];
//    [self.collectionView registerClass:[FlickrPhotoCell class] forCellWithReuseIdentifier:@"FlickerCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)shareButtonTapped:(id)sender
{


}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{

    [self.flickr searchFlickrForTerm:textField.text completionBlock:^(NSString *searchTerm ,NSArray *results , NSError *error)
     
     {
     
         if (results && [results count] >0) {
             if (![self.searches containsObject:searchTerm]) {
                 NSLog(@"Found %lu photos matching %@" ,[results count],searchTerm);
                 [self.searches insertObject:searchTerm atIndex:0];
                 self.searchResults[searchTerm] = results;
             }
             dispatch_async(dispatch_get_main_queue(),^ { });
             
             [self.collectionView reloadData];
         }
         else
         {
             NSLog(@"Error Searching Flicker : %@",error.localizedDescription);
         }
     
     }
     
     ];
    
    [textField resignFirstResponder];
    return YES;

}


//collectionView:numberOfItemsInSection: returns the number of cells to be displayed for a given section

#pragma mark - UICollection View Delegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSString *searchTerm = self.searches[section];
    NSInteger numberOfItems = [self.searchResults[searchTerm] count];
    NSLog(@"numberOfItems -> %ld", numberOfItems);
    
    return numberOfItems;
}


//numberOfSectionsInCollectionView: returns the total number of sections. It’s a simple matter of returning the total number of searches.

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    NSInteger numberOfSections = [self.searches count];
    NSLog(@"numberOfSections -> %ld", numberOfSections);
    
    return numberOfSections;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FlickrPhotoCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"FlickerCell" forIndexPath:indexPath];
    NSLog(@"cell instance is: %@", cell);
    NSString *searchTerm = self.searches[indexPath.section];
    NSLog(@"search term: %@", searchTerm);
    NSArray *records = self.searchResults[searchTerm];
    FlickrPhoto *photo = records[indexPath.row];
    NSLog(@"photo: %@", photo);
    NSLog(@"photo image: %@", photo.thumbnail);
    cell.imageview.image = photo.thumbnail;
    cell.imageview.backgroundColor = [UIColor whiteColor];
    
    
    cell.backgroundColor = [UIColor greenColor];
    return cell;
}


#pragma mark - UICollection view delegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    if(!self.sharing)
    {
    
        NSString *searchTerm = self.searches[indexPath.section];
    
    }

}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{


}


#pragma  mark - UI collection View delegate flow layout

//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSString *searchTerm = self.searches[indexPath.section];
//    FlickrPhoto *photo = self.searchResults[searchTerm][indexPath.row];
//    CGSize retval =photo.thumbnail.size.width > 0 ? photo.thumbnail.size : CGSizeMake(100, 100);
//    retval.width += 35;
//    retval.height += 35;
//    return retval;
//
//}

//collectionView:layout:insetForSectionAtIndex: returns the spacing between the cells, headers, and footers.

//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return  UIEdgeInsetsMake(50, 20, 50, 20);
//}


-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{

    FlickerPhotoHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier: @"FlickrPhotoHeaderView" forIndexPath:indexPath];
    NSString * searchTerm = self.searches[indexPath.section];
    [headerView setSearchText:searchTerm];
    return headerView;
}


@end
