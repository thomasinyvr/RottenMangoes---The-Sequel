//
//  CustomCollectionViewCell.h
//  RottenMangoes - The Sequel
//
//  Created by Thomas Friesman on 2016-03-28.
//  Copyright © 2016 Thomas Friesman. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Movies;

@interface CustomCollectionViewCell : UICollectionViewCell

-(void)configureWithMovie:(Movies *)movie;

@end
