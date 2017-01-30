//
//  GEAPIClient.m
//  GoEuroCodeChallenge
//
//  Created by Sebastiano Catellani on 29/01/17.
//  Copyright © 2017 Sebastiano Catellani. All rights reserved.
//

#import "GEAPIClient.h"
#import "GETravel.h"
#import "GEAPISessionManager.h"

@interface GEAPIClient ()

@property (nonatomic, strong, readonly) GEAPISessionManager *apiSessionManager;

@end

@implementation GEAPIClient

#pragma mark - Lifecycle

- (instancetype)init {
  self = [super init];
  if (!self) return nil;
  
  _apiSessionManager = [[GEAPISessionManager alloc] init];
  
  return self;
}

#pragma mark - Travels

- (void)fetchTrainsWithCompletionHandler:(void(^)(NSArray*))handler {
  NSURLRequest* request = [_apiSessionManager requestForURL:@"3zmcy"];
  [self fetchTravelsWithRequest:request completionHandler:handler];
}

- (void)fetchBusesWithCompletionHandler:(void(^)(NSArray*))handler {
  NSURLRequest* request = [_apiSessionManager requestForURL:@"37yzm"];
  [self fetchTravelsWithRequest:request completionHandler:handler];
}

- (void)fetchFlightsWithCompletionHandler:(void(^)(NSArray*))handler {
  NSURLRequest* request = [_apiSessionManager requestForURL:@"w60i"];
  [self fetchTravelsWithRequest:request completionHandler:handler];
}

- (void)fetchTravelsWithRequest:(NSURLRequest*)request completionHandler:(void(^)(NSArray*))handler {
  [[_apiSessionManager
    dataTaskWithRequest:request
    completionHandler:^(NSURLResponse * response, id responseObject, NSError * error) {
      if (error) {
        handler(@[]);
        return;
      }
      
      NSArray *travelsJSONArray = responseObject;
      NSArray *travels = [MTLJSONAdapter modelsOfClass:GETravel.class fromJSONArray:travelsJSONArray error:NULL];
      handler(travels);
      
    }] resume];
}

@end
