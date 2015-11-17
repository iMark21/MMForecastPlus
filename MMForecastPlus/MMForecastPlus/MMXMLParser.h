//
//  MMXMLParser.h
//  MMForecastPlus
//
//  Created by Juan Miguel Marqués Morilla on 16/11/15.
//  Copyright © 2015 Juan Miguel Marqués Morilla. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMXMLParser : NSObject

+(instancetype)sharedInstance;

-(NSDictionary*)dictionaryWithXMLString:(NSString*)xml;

-(NSDictionary*)dictionaryWithXMLData:(NSData*)xml;

@end

