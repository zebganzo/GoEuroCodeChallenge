//
//  GEAPISessionManager.m
//  GoEuroCodeChallenge
//
//  Created by Sebastiano Catellani on 29/01/17.
//  Copyright © 2017 Sebastiano Catellani. All rights reserved.
//

#import "GEAPISessionManager.h"

static NSString * const APIBaseString = @"https://api.myjson.com/bins/";

@implementation GEAPISessionManager

- (instancetype)init {
  self = [super initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
  if (!self) return nil;
  
  return self;
}

- (NSURL*)buildURLWith:(NSString*)url {
  return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",APIBaseString, url]];
}

- (NSURLRequest *)requestForURL:(NSString*)url {
  NSURL *URL = [self buildURLWith:url];
  return [NSURLRequest requestWithURL:URL];
}

@end
