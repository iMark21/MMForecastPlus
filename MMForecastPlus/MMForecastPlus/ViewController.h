//
//  ViewController.h
//  MMForecastPlus
//
//  Created by Juan Miguel Marqués Morilla on 16/11/15.
//  Copyright © 2015 Juan Miguel Marqués Morilla. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UITableView *tableViewLocations;


- (IBAction)searchButtonAction:(id)sender;



@end

