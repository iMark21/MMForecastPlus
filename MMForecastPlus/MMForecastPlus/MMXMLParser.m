//
//  MMXMLParser.m
//  MMForecastPlus
//
//  Created by Juan Miguel Marqués Morilla on 16/11/15.
//  Copyright © 2015 Juan Miguel Marqués Morilla. All rights reserved.
//

#import "MMXMLParser.h"

#import "XMLDictionary.h"


@implementation MMXMLParser


+(instancetype)sharedInstance{
    
    
    static dispatch_once_t once;
    static id sharedInstance;
    
    dispatch_once(&once, ^{
        sharedInstance = [self new];
    });
    
    return sharedInstance;
    
}

-(NSDictionary*)dictionaryWithXMLString:(NSString*)xml{
    
    
    
    return @{@"result":xml};
    
    
    
}

-(NSDictionary*)dictionaryWithXMLData:(NSData*)xml{
    
    
    XMLDictionaryParser *parser = [XMLDictionaryParser sharedInstance];
    
    NSDictionary *result = [parser dictionaryWithData:xml];
    
    
    return result;
    
}

@end