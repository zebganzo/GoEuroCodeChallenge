//
//  GETravel.m
//  GoEuroCodeChallenge
//
//  Created by Sebastiano Catellani on 28/01/17.
//  Copyright © 2017 Sebastiano Catellani. All rights reserved.
//

#import "GETravel.h"

@implementation GETravel

#pragma mark - Mantle

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return @{
           @"identifier": @"id",
           @"providerLogo": @"provider_logo",
           @"priceInEuros": @"price_in_euros",
           @"departureTime": @"departure_time",
           @"arrivalTime": @"arrival_time",
           @"numberOfStops": @"number_of_stops",
           };
}

#pragma mark - Lifecycle

- (instancetype)initWithIdentifier:(NSInteger)identifier
                      providerLogo:(NSString *)providerLogo
                      priceInEuros:(NSNumber *)priceInEuros
                     departureTime:(NSDate *)departureTime
                       arrivalTime:(NSDate *)arrivalTime
                     numberOfStops:(NSInteger)numberOfStops {
  
  self = [super init];
  if (!self) return nil;
  
  _identifier = identifier;
  _providerLogo = [providerLogo copy];
  _priceInEuros = priceInEuros;
  _departureTime = departureTime;
  _arrivalTime = arrivalTime;
  _numberOfStops = numberOfStops;
  _travelOption = Unknown;
  
  return self;
}

#pragma mark - NSObject

- (NSString *)description {
  
  NSDateFormatter * dateFormatter = [NSDateFormatter new];
  dateFormatter.dateFormat = @"HH:mm";
  
  return [NSString stringWithFormat:@"%ld (%@ €) departure time : %@, arrival time : %@ (stops : %ld)",
          (long)_identifier,
          _priceInEuros,
          [dateFormatter stringFromDate:_departureTime],
          [dateFormatter stringFromDate:_arrivalTime],
          (long)_numberOfStops];
}

- (NSUInteger)hash {
  return [[NSNumber numberWithInteger:_identifier] hash];
}

- (BOOL)isEqual:(id)object {
  if (![object isKindOfClass:self.class]) return NO;
  
  GETravel *other = (GETravel *)object;
  return _identifier == other.identifier;
}

#pragma mark - Helpers

+ (NSDateFormatter *)dateFormatter {
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  dateFormatter.dateFormat = @"HH:mm";
  return dateFormatter;
}

+ (NSValueTransformer *)departureTimeJSONTransformer {
  return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *dateString, BOOL *success, NSError *__autoreleasing *error) {
    return [self.dateFormatter dateFromString:dateString];
  } reverseBlock:^id(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
    return [self.dateFormatter stringFromDate:date];
  }];
}

+ (NSValueTransformer *)priceInEurosJSONTransformer {
  return [MTLValueTransformer transformerUsingForwardBlock:^id(id priceInEurosValue, BOOL *success, NSError *__autoreleasing *error) {
    
    if([priceInEurosValue isKindOfClass:[NSString class]]) {
      return priceInEurosValue;
    }
    
    return [priceInEurosValue stringValue];
  } reverseBlock:^id(NSString *price, BOOL *success, NSError *__autoreleasing *error) {
    return price;
  }];
}

+ (NSValueTransformer *)arrivalTimeJSONTransformer {
  return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *dateString, BOOL *success, NSError *__autoreleasing *error) {
    return [self.dateFormatter dateFromString:dateString];
  } reverseBlock:^id(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
    return [self.dateFormatter stringFromDate:date];
  }];
}

@end
