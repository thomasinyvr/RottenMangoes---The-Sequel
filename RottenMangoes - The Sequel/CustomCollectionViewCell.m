//
//  CustomCollectionViewCell.m
//  RottenMangoes - The Sequel
//
//  Created by Thomas Friesman on 2016-03-28.
//  Copyright © 2016 Thomas Friesman. All rights reserved.
//

#import "CustomCollectionViewCell.h"
#import "Movies.h"

@interface CustomCollectionViewCell ()

@property (nonatomic, weak) IBOutlet UIImageView *movieImageView;
@property (nonatomic) NSURLSessionDataTask *task;

@end

@implementation CustomCollectionViewCell

-(void)configureWithMovie:(Movies *)movie
{
    NSURLSession *sharedSession = [NSURLSession sharedSession];
    
    self.movieImageView.image = nil;
    
    [self.task cancel];
    
    self.task = [sharedSession dataTaskWithURL:movie.movieImage completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        UIImage *image = [UIImage imageWithData:data];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.movieImageView.image = image;
        });
    
    }];
    
    [self.task resume];
}



@end
