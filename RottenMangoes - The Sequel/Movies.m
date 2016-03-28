//
//  Movies.m
//  RottenMangoes - The Sequel
//
//  Created by Thomas Friesman on 2016-03-28.
//  Copyright © 2016 Thomas Friesman. All rights reserved.
//

#import "Movies.h"

@implementation Movies

-(instancetype)initWithName:(NSString *)movieName image:(NSURL *)movieImage andURL:(NSURL *)reviewsURL
{
    self = [super init];
    if (self) {
        self.movieName = movieName;
        self.movieImage = movieImage;
        self.reviewsUrl = reviewsURL;
    }
    
    return self;
}

@end
