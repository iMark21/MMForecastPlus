//
//  MMNewObject.m
//  MMForecastPlus
//
//  Created by Juan Miguel Marqués Morilla on 16/11/15.
//  Copyright © 2015 Juan Miguel Marqués Morilla. All rights reserved.
//

#import "MMNewObject.h"

@implementation MMNewObject

-(instancetype)initWithDictionary:(NSDictionary*)dictionary{
    
    
    if (self = [super init]) {
        
        [self setValuesWithDictionary:dictionary];
        
    }
    
    return self;
}

-(void)setValuesWithDictionary:(NSDictionary*)dictionary{
    
    self.title = [dictionary objectForKey:@"title"];
    self.descriptionText = [dictionary objectForKey:@"description"];
    self.image = [dictionary valueForKeyPath:@"media:thumbnail._url"];
    
    
}


@end
