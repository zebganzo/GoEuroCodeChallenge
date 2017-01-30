//
//  GETrainsViewModel.h
//  GoEuroCodeChallenge
//
//  Created by Sebastiano Catellani on 29/01/17.
//  Copyright © 2017 Sebastiano Catellani. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GETravelTableViewCellModel.h"
#import "GETravel.h"

@class GEAPIClient;

@protocol GETrainsViewModelDelegate<NSObject>

- (void)refreshIndicatorVisible:(BOOL)isVisible;
- (void)reloadData;

@end

@interface GETrainsViewModel : NSObject

@property (weak, nonatomic) id <GETrainsViewModelDelegate> delegate;

- (instancetype)initWithAPIClient:(GEAPIClient *)apiClient
                         delegate:(id<GETrainsViewModelDelegate>)delegate;

- (NSInteger)numberOfSections;
- (NSInteger)numberOfItemsInSection:(NSInteger)section;
- (GETravelTableViewCellModel *)viewModelForTravelAtRow:(NSInteger)row inSection:(NSInteger)section;

- (void)selectedTravelOption:(GETravelOption)travelOption;

@end
