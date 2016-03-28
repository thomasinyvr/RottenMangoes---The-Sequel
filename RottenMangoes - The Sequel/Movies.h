//
//  Movies.h
//  RottenMangoes - The Sequel
//
//  Created by Thomas Friesman on 2016-03-28.
//  Copyright © 2016 Thomas Friesman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Movies : NSObject

@property (nonatomic) NSString *movieName;
@property (nonatomic) NSURL *movieImage;
@property (nonatomic) NSURL *reviewsUrl;

- (instancetype)initWithName:(NSString*)movieName image:(NSURL*)movieImage andURL:(NSURL*)reviewsURL;



@end
