//
//  MMAPI.m
//  MMForecastPlus
//
//  Created by Juan Miguel Marqués Morilla on 16/11/15.
//  Copyright © 2015 Juan Miguel Marqués Morilla. All rights reserved.
//

#import "MMAPI.h"
#import "MMGeographicPlace.h"
#import "MMXMLParser.h"



@implementation MMAPI

+(instancetype)sharedInstance{
    
    static dispatch_once_t once;
    static id sharedInstance;
    
    dispatch_once(&once, ^{
        sharedInstance = [self new];
    });
    
    return sharedInstance;
    
}

- (void)queryPlacesWithString:(NSString *) placeString completionBlock:(void (^)(NSArray *JSONArray, NSError *error)) block {
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    placeString = [placeString stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSURL *queryURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.geonames.org/searchJSON?q=%@&maxRows=20&startRow=0&lang=en&isNameRequired=true&style=FULL&username=ilgeonamessample",placeString]];
    
    NSLog(@"URL: %@",queryURL);
    
    [[session dataTaskWithURL:queryURL
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {

                NSArray *jsonArray = [NSArray array];
                
                if (data !=nil) {
                    jsonArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                }
                
                
                NSLog(@"Result: %@",jsonArray);
                if(jsonArray) {
                    block(jsonArray, nil);
                    
                } else {
                    NSError *error = [NSError errorWithDomain:@"plist_download_error" code:1
                                                     userInfo:[NSDictionary dictionaryWithObject:@"Can't fetch data" forKey:NSLocalizedDescriptionKey]];
                    block(nil, error);
                }

            }] resume];


    
}

- (void)queryWeatherWithGeographicPlace:(MMGeographicPlace *) place completionBlock:(void (^)(NSArray *JSONArray, NSError *error)) block {
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURL *queryURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.geonames.org/weatherJSON?north=%@&south=%@&east=%@&west=%@&username=ilgeonamessample",place.north,place.south,place.east,place.west]];

     NSLog(@"URL: %@",queryURL);
    
    [[session dataTaskWithURL:queryURL
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                
                if (data != nil) {
                    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                    
                    NSLog(@"Result: %@",jsonArray);
                    
                    if(jsonArray) {
                        block(jsonArray, nil);
                        
                    } else {
                        NSError *error = [NSError errorWithDomain:@"plist_download_error" code:1
                                                         userInfo:[NSDictionary dictionaryWithObject:@"Can't fetch data" forKey:NSLocalizedDescriptionKey]];
                        block(nil, error);
                    }

                }
                
                
                
            
            }] resume];
    
    
    
}

-(NSDictionary*)xmlDictionary:(NSURL*)xmlURL{
    
    NSData * dataXml = [[NSData alloc] initWithContentsOfURL:xmlURL];
    
    NSDictionary *xmlDictionary=[[MMXMLParser sharedInstance] dictionaryWithXMLData:dataXml];
    
    NSLog(@"Madrid3");
    
    return xmlDictionary;
    
}

- (void)xmlDictionary:(NSURL *) url completionBlock:(void (^)(NSDictionary *xmlDictionary, NSError *error)) block {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        
        NSData * dataXml = [[NSData alloc] initWithContentsOfURL:url];
        NSDictionary *xmlDictionary=[[MMXMLParser sharedInstance] dictionaryWithXMLData:dataXml];
        
        if(xmlDictionary) {
            block(xmlDictionary, nil);
            
        } else {
            NSError *error = [NSError errorWithDomain:@"plist_download_error" code:1
                                             userInfo:[NSDictionary dictionaryWithObject:@"Can't fetch data" forKey:NSLocalizedDescriptionKey]];
            block(nil, error);
        }
        
    });
}


-(void)saveCacheInformationWithString: (MMGeographicPlace*)place{
    
    NSMutableArray *cachedInformation = [NSMutableArray array];

    
    if ([self restoreCacheInformation]) {
        cachedInformation = [[self restoreCacheInformation]mutableCopy];
    }
    
    [cachedInformation addObject:place];
   
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:cachedInformation];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:data forKey:@"cachedInformation"];
    
    [defaults synchronize];
    

    
    
}

-(NSArray*)restoreCacheInformation{
    
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"cachedInformation"];
    
    NSArray *savedArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    return savedArray;
    
}

@end
