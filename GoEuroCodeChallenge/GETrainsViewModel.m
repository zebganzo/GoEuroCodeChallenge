//
//  GETrainsViewModel.m
//  GoEuroCodeChallenge
//
//  Created by Sebastiano Catellani on 29/01/17.
//  Copyright © 2017 Sebastiano Catellani. All rights reserved.
//

#import "GETrainsViewModel.h"
#import "GETravel.h"
#import "GEAPIClient.h"
#import <BlocksKit/NSArray+BlocksKit.h>

@interface GETrainsViewModel()

@property (nonatomic, strong, readonly) GEAPIClient *apiClient;
@property (nonatomic, strong) NSArray *trains;
@property (nonatomic, strong) NSArray *buses;
@property (nonatomic, strong) NSArray *flights;

@property (nonatomic, assign) GETravelOption travelOption;

@end

@implementation GETrainsViewModel

#pragma mark - Lifecycle

- (instancetype)initWithAPIClient:(GEAPIClient *)apiClient
                         delegate:(id<GETrainsViewModelDelegate>)delegate {
  self = [super init];
  if (!self) return nil;
  
  _apiClient = apiClient;
  _delegate = delegate;
  _travelOption = Bus;
  
  [self.delegate refreshIndicatorVisible:true];
  
  [self fetchBuses];
  [self fetchTrains];
  [self fetchFlights];
  
  return self;
}

- (instancetype)init {
  return [self initWithAPIClient:nil delegate:nil];
}

#pragma mark - Fetching data


// ordered by departure time
- (void)fetchTrains {
  [_apiClient fetchTrainsWithCompletionHandler:^(NSArray * travels) {
    [travels bk_each:^(GETravel *travel) {
      travel.travelOption = Train;
    }];
    self.trains = [self sortArrayByDepartureTime:travels];
    
    if (self.travelOption == Train) {
      [self.delegate reloadData];
    }
  }];
}

- (void)fetchBuses {
  [_apiClient fetchBusesWithCompletionHandler:^(NSArray * travels) {
    [travels bk_each:^(GETravel *travel) {
      travel.travelOption = Bus;
    }];
    self.buses = [self sortArrayByDepartureTime:travels];
    
    [self.delegate refreshIndicatorVisible:false];
    [self.delegate reloadData];
  }];
}

- (void)fetchFlights {
  [_apiClient fetchFlightsWithCompletionHandler:^(NSArray * travels) {
    [travels bk_each:^(GETravel *travel) {
      travel.travelOption = Flight;
    }];
    self.flights = [self sortArrayByDepartureTime:travels];
    
    if (self.travelOption == Flight) {
      [self.delegate reloadData];
    }
  }];
}

#pragma mark - Content

- (void)selectedTravelOption:(GETravelOption)travelOption {
  self.travelOption = travelOption;
  [self.delegate reloadData];
}

- (NSInteger)numberOfSections {
  return 1;
}

- (NSInteger)numberOfItemsInSection:(NSInteger)section {
  return [self currentItems].count;
}

- (GETravelTableViewCellModel *)viewModelForTravelAtRow:(NSInteger)row inSection:(NSInteger)section {
  GETravel *train = [[self currentItems] objectAtIndex:row];
  
  GETravelTableViewCellModel* cellViewModel = [GETravelTableViewCellModel new];
  
  cellViewModel.providerLogoURL = [self providerLogoURLWithString:train.providerLogo];
  cellViewModel.departureAndArrivalTime = [self stringWithDepartureTime:train.departureTime
                                                         andArrivalTime:train.arrivalTime];
  cellViewModel.numberOfStop = [self stringNumberOfStops:train.numberOfStops];
  cellViewModel.travelTime = [self travelTimeWithDepartureTime:train.departureTime
                                                andArrivalTime:train.arrivalTime];
  cellViewModel.price = [self stringWithPrice:train.priceInEuros];
  
  return cellViewModel;
}

#pragma mark - Presenter helpers

- (NSURL *)providerLogoURLWithString:(NSString*)url {
  NSString* urlWithSize = [url stringByReplacingOccurrencesOfString:@"{size}"
                                                         withString:[@63 stringValue]];
  return [NSURL URLWithString:urlWithSize];
}

- (NSString *)stringWithDepartureTime:(NSDate*)departure andArrivalTime:(NSDate*)arrival {
  
  NSDateFormatter *dateFormatter = [GETrainsViewModel dateFormatter];
  
  NSString *sufix = @"";
  if ([departure compare:arrival] == NSOrderedDescending) {
    sufix = @" (+1)";
  }
  
  return [NSString stringWithFormat:@"%@ - %@%@",
          [dateFormatter stringFromDate:departure],
          [dateFormatter stringFromDate:arrival],
          sufix];
}

- (NSString *)stringNumberOfStops:(NSInteger)stops {
  switch (stops) {
    case 0:
      return @"Direct";
      break;
    case 1:
      return @"1 Stop";
      break;
    default:
      return [NSString stringWithFormat:@"%ld Stops", (long)stops];
      break;
  }
}

- (NSString *)travelTimeWithDepartureTime:(NSDate*)departure andArrivalTime:(NSDate*)arrival {
  int seconds = [arrival timeIntervalSinceDate:departure];
  
  int totalMinutes = seconds / 60;
  int minutes = totalMinutes % 60;
  int hours = totalMinutes / 60;
  
  if (hours) {
    return [NSString stringWithFormat:@"%d:%dh", hours, minutes];
  }
  
  return [NSString stringWithFormat:@"%dm", minutes];
}

- (NSString *)stringWithPrice:(NSNumber*)price {
  return [NSString stringWithFormat:@"€%@", [NSString stringWithFormat:@"%.2f", [price doubleValue]]];
}

#pragma mark - Helpers

- (NSArray*)currentItems {
  switch (self.travelOption) {
    case Bus:
      return self.buses;
      break;
    case Train:
      return self.trains;
      break;
    case Flight:
      return self.flights;
      break;
    case Unknown:
      return @[];
      break;
  }
}

- (NSArray *)sortArrayByDepartureTime:(NSArray *)array {
  NSArray *sortedArray = [array sortedArrayUsingComparator:^NSComparisonResult(GETravel *first, GETravel *second) {
    return [first.departureTime compare:second.departureTime];
  }];
  return sortedArray;
}

+ (NSDateFormatter *)dateFormatter {
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  dateFormatter.dateFormat = @"HH:mm";
  return dateFormatter;
}

@end
