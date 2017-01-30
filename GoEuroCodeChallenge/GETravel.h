//
//  GETravel.h
//  GoEuroCodeChallenge
//
//  Created by Sebastiano Catellani on 28/01/17.
//  Copyright © 2017 Sebastiano Catellani. All rights reserved.
//

#import <Mantle/Mantle.h>

typedef enum : NSUInteger {
  Train,
  Bus,
  Flight,
  Unknown
} GETravelOption;

@interface GETravel : MTLModel <MTLJSONSerializing>

@property (nonatomic, assign, readonly) NSInteger identifier;
@property (nonatomic, copy, readonly) NSString *providerLogo;
@property (nonatomic, copy, readonly) NSNumber *priceInEuros;
@property (nonatomic, copy, readonly) NSDate *departureTime;
@property (nonatomic, copy, readonly) NSDate *arrivalTime;
@property (nonatomic, assign, readonly) NSInteger numberOfStops;
@property (nonatomic, assign) GETravelOption travelOption;

- (instancetype)initWithIdentifier:(NSInteger)identifier
                      providerLogo:(NSString *)providerLogo
                      priceInEuros:(NSNumber *)priceInEuros
                     departureTime:(NSDate *)departureTime
                       arrivalTime:(NSDate *)arrivalTime
                     numberOfStops:(NSInteger)numberOfStops;

@end
