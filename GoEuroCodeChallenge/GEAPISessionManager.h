//
//  GEAPISessionManager.h
//  GoEuroCodeChallenge
//
//  Created by Sebastiano Catellani on 29/01/17.
//  Copyright © 2017 Sebastiano Catellani. All rights reserved.
//

#import <AFNetworking/AFURLSessionManager.h>

@interface GEAPISessionManager : AFURLSessionManager

- (NSURLRequest *)requestForURL:(NSString*)url;

@end
