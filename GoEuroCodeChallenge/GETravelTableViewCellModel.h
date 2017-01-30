//
//  GETravelTableViewCellModel.h
//  GoEuroCodeChallenge
//
//  Created by Sebastiano Catellani on 29/01/17.
//  Copyright © 2017 Sebastiano Catellani. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GETravelTableViewCellModel : NSObject

@property (retain, nonatomic) NSURL *providerLogoURL;
@property (retain, nonatomic) NSString *departureAndArrivalTime;
@property (retain, nonatomic) NSString *numberOfStop;
@property (retain, nonatomic) NSString *travelTime;
@property (retain, nonatomic) NSString *price;

@end
