//
//  MMNewsDetailViewController.h
//  MMForecastPlus
//
//  Created by Juan Miguel Marqués Morilla on 17/11/15.
//  Copyright © 2015 Juan Miguel Marqués Morilla. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMNewObject.h"

@interface MMNewsDetailViewController : UIViewController

@property (weak, nonatomic) MMNewObject *newsObject;
@property (weak, nonatomic) IBOutlet UIImageView *newsImage;
@property (weak, nonatomic) IBOutlet UILabel *newsTitleLabel;
@property (weak, nonatomic) IBOutlet UIWebView *newsWebView;

@end
