//
//  DetailViewController.m
//  RottenMangoes - The Sequel
//
//  Created by Thomas Friesman on 2016-03-28.
//  Copyright © 2016 Thomas Friesman. All rights reserved.
//

#import "DetailViewController.h"
#import "Movies.h"

@interface DetailViewController ()

@property (nonatomic, weak) IBOutlet UIImageView *detailVCImage;
@property (nonatomic, weak) IBOutlet UILabel *detailVCTitle;
@property (nonatomic, weak) IBOutlet UILabel *detailVCReviewOneLabel;
@property (nonatomic, weak) IBOutlet UILabel *detailVCReviewTwoLabel;


@property (nonatomic) NSURLSessionDataTask *task;
@property (nonatomic) NSMutableArray *reviews;


@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.reviews = [NSMutableArray new];
    
    NSURLSession *sharedSession = [NSURLSession sharedSession];
    
    self.detailVCImage.image = nil;
    
    [self.task cancel];
    
    self.task = [sharedSession dataTaskWithURL:self.movie.movieImage completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                 {
                     UIImage *image = [UIImage imageWithData:data];
                     
                     dispatch_async(dispatch_get_main_queue(), ^{
                         self.detailVCImage.image = image;
                         
                     });
                     
                 }];
    

    self.detailVCTitle.text = self.movie.movieName;

    [self.task resume];

    

    NSURLSessionTask *dataTask = [sharedSession dataTaskWithURL:self.movie.reviewsUrl completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        if (!error)
        {
            NSError *jsonError = nil;
                                  
            NSDictionary *responseJson = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                                  
            if (![responseJson isKindOfClass:[NSDictionary class]])
            {
                NSLog(@"unexpected data returned");
                return;
            }
            
            NSArray *movieDictionaries = responseJson[@"reviews"];
            
            
            for (NSDictionary *eachReview in movieDictionaries)
            {
                if (![eachReview isKindOfClass:[NSDictionary class]])
                {
                    NSLog(@"not a dictionary");
                    continue;
                }
                                      
                NSString *movieReview = eachReview[@"quote"];
                [self.reviews addObject:movieReview];
                
            }
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.detailVCReviewOneLabel.text = [self.reviews firstObject];
            });
            
            
            
            
        }
        
    }];
    
    [dataTask resume];
}


@end
