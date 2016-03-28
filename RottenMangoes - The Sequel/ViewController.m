//
//  ViewController.m
//  RottenMangoes - The Sequel
//
//  Created by Thomas Friesman on 2016-03-28.
//  Copyright © 2016 Thomas Friesman. All rights reserved.
//

#import "ViewController.h"
#import "Movies.h"
#import "CustomCollectionViewCell.h"
#import "DetailViewController.h"



@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic) NSMutableArray *moviesArray;

@end

@implementation ViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.collectionView setDelegate:self];
    
    self.moviesArray = [[NSMutableArray alloc] init];
    
    NSString *urlString = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?apikey=sr9tdu3checdyayjz85mff8j";
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        if (!error)
        {
            NSError *jsonError = nil;
            
            NSDictionary *responseJson = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            
            if (![responseJson isKindOfClass:[NSDictionary class]]) {
                NSLog(@"Unexpected data returned");
                return;
            }
            NSArray *movieDictionaries = responseJson[@"movies"];
            
            for (NSDictionary *eachMovie in movieDictionaries) {
                if (![eachMovie isKindOfClass:[NSDictionary class]]) {
                    NSLog(@"not a dictionary");
                    continue;
                }
                
                NSString *movieTitle = eachMovie[@"title"];
                
                NSDictionary *posters = eachMovie[@"posters"];
                NSString *posterURLString = posters[@"detailed"];
                NSURL *posterURL = [NSURL URLWithString:posterURLString];
                
                NSDictionary *links = eachMovie[@"links"];
                NSString *reviewURLString = links[@"reviews"];
                NSString *apiKey = @"?apikey=sr9tdu3checdyayjz85mff8j";
                NSString *urlWithApiKey = [NSString stringWithFormat:@"%@%@", reviewURLString, apiKey];
                NSURL *reviewsURL = [NSURL URLWithString:urlWithApiKey];
                
                Movies *movie = [[Movies alloc] initWithName:movieTitle image:posterURL andURL:reviewsURL];
                
                [self.moviesArray addObject:movie];
                
                
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
            });
            
       }
        NSLog(@"data downloaded");
    }];
    
    [dataTask resume];
    
    NSLog(@"data download started");
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.moviesArray.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    Movies *individual = self.moviesArray[indexPath.row];
    
    [cell configureWithMovie:individual];
    
    return  cell;
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"showDetailViewController"]) {
        
        NSIndexPath *indexPath = self.collectionView.indexPathsForSelectedItems.firstObject;
        
        DetailViewController *destinationViewController = [segue destinationViewController];
        
        destinationViewController.movie = self.moviesArray[indexPath.row];
    }

}

    

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
