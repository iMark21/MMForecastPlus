//
//  MMNewsViewController.m
//  MMForecastPlus
//
//  Created by Juan Miguel Marqués Morilla on 16/11/15.
//  Copyright © 2015 Juan Miguel Marqués Morilla. All rights reserved.
//

#import "MMNewsViewController.h"
#import "MMAPI.h"
#import "MMNewObject.h"
#import "MMNewTableViewCell.h"
#import <SDWebImage/SDImageCache.h>
#import "UIImageView+WebCache.h"
#import "MMNewsDetailViewController.h"
#import "SVProgressHUD.h"


@interface MMNewsViewController ()

@property (nonatomic, strong) NSMutableArray *parsedItems;

@end

@implementation MMNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.tableViewNews setBackgroundColor:[UIColor clearColor]];
    
    [self.view setBackgroundColor:[UIColor grayColor]];
    
    [self loadContent];

}

-(void)loadContent{
    
    [SVProgressHUD showWithStatus:@"Cargando" maskType:SVProgressHUDMaskTypeGradient];
    self.parsedItems = [NSMutableArray new
                        ];
    
    
    
    [[MMAPI sharedInstance]xmlDictionary:[NSURL URLWithString:@"http://estaticos.elmundo.es/elmundo/rss/internacional.xml"] completionBlock:^(NSDictionary *xmlDictionary, NSError *error) {
        
        
        NSArray *news = [xmlDictionary valueForKeyPath:@"channel.item"];
        
        for (id item in news) {
            
            if ([item isKindOfClass:[NSDictionary class]]) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    MMNewObject *new = [[MMNewObject alloc] initWithDictionary:item];
                    
                    [self.parsedItems addObject:new];
                    
                    NSLog(@"%@",new.title);
                    
                             [self.tableViewNews reloadData];
                    
                });
                
            }
        }
        

        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [SVProgressHUD dismiss];
            
        });
        
    }];

    
}

#pragma mark UITableView methods



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    
    return [self.parsedItems count];
    
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    
    MMNewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[MMNewTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    
    MMNewObject *newObject = [self.parsedItems objectAtIndex:indexPath.row];
    cell.titleLabel.text =  newObject.title;
    cell.descriptionLabel.text = newObject.descriptionText;
    [cell.imageViewNew sd_setImageWithURL:[NSURL URLWithString:[newObject image]] placeholderImage:[UIImage imageNamed:@"placeholder.jpg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    [cell setBackgroundColor:[UIColor clearColor]];
    
    return cell;
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"detailNews"])
    {
        // Get reference to the destination view controller
        MMNewsDetailViewController *vc = [segue destinationViewController];
        
     
        NSIndexPath *path = [self.tableViewNews indexPathForSelectedRow];
        
        
        MMNewObject *newsObject = [self.parsedItems objectAtIndex:path.row];
        
        vc.newsObject = newsObject;

        
    }
}


@end
