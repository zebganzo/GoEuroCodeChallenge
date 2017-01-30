//
//  GEAPIClient.h
//  GoEuroCodeChallenge
//
//  Created by Sebastiano Catellani on 29/01/17.
//  Copyright © 2017 Sebastiano Catellani. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GETravel;

@interface GEAPIClient : NSObject

- (void)fetchTrainsWithCompletionHandler:(void(^)(NSArray*))handler;
- (void)fetchBusesWithCompletionHandler:(void(^)(NSArray*))handler;
- (void)fetchFlightsWithCompletionHandler:(void(^)(NSArray*))handler;

@end
