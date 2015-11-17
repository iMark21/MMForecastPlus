//
//  MMNewsDetailViewController.m
//  MMForecastPlus
//
//  Created by Juan Miguel Marqués Morilla on 17/11/15.
//  Copyright © 2015 Juan Miguel Marqués Morilla. All rights reserved.
//

#import "MMNewsDetailViewController.h"
#import <SDWebImage/SDImageCache.h>
#import "UIImageView+WebCache.h"

@interface MMNewsDetailViewController ()

@end

@implementation MMNewsDetailViewController

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
    
    [self configureUI];
    
}

-(void)configureUI{
    
    self.newsTitleLabel.text = self.newsObject.title;
    NSString * htmlText = [NSString stringWithFormat:@"<font face='Open Sans' size='2.5'>%@", self.newsObject.descriptionText];
    
    [self.newsImage sd_setImageWithURL:[NSURL URLWithString:[self.newsObject image]] placeholderImage:[UIImage imageNamed:@"placeholder.jpg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    

    
    [self.newsWebView  loadHTMLString:[NSString stringWithFormat:@"%@", htmlText] baseURL: nil];
    

    
    
    self.newsWebView.scrollView.scrollEnabled = NO;
    
}
@end
