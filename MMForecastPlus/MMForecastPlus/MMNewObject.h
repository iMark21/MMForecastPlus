//
//  MMNewObject.h
//  MMForecastPlus
//
//  Created by Juan Miguel Marqués Morilla on 16/11/15.
//  Copyright © 2015 Juan Miguel Marqués Morilla. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMNewObject : NSObject

@property (nonatomic,strong)  NSString *title;
@property (nonatomic,strong)  NSString *descriptionText;
@property (nonatomic,strong)  NSString *image;

-(instancetype)initWithDictionary:(NSDictionary*)dictionary;

-(void)setValuesWithDictionary:(NSDictionary*)dictionary;

@end
