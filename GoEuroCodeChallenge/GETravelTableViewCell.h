//
//  GETravelTableViewCell.h
//  GoEuroCodeChallenge
//
//  Created by Sebastiano Catellani on 28/01/17.
//  Copyright © 2017 Sebastiano Catellani. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GETravelTableViewCellModel;

@interface GETravelTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *providerLogoImageView;
@property (weak, nonatomic) IBOutlet UILabel *departureAndArrivalTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfStopLabel;
@property (weak, nonatomic) IBOutlet UILabel *travelTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

+ (NSString *)defaultReuseIdentifier;
+ (CGFloat)estimatedHeight;
+ (UINib *)nibForCell;

- (void)populateCellWithViewModel:(GETravelTableViewCellModel*)viewModel;

@end
