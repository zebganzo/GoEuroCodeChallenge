//
//  GETravelTableViewCell.m
//  GoEuroCodeChallenge
//
//  Created by Sebastiano Catellani on 28/01/17.
//  Copyright © 2017 Sebastiano Catellani. All rights reserved.
//

#import "GETravelTableViewCell.h"
#import "UIFont+GoEuro.h"
#import "UIColor+GoEuro.h"
#import <BlocksKit/NSArray+BlocksKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "GETravelTableViewCellModel.h"

@interface GETravelTableViewCell()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewWidthConstraint;

@end

@implementation GETravelTableViewCell

#pragma mark - Lifecycle

- (void)awakeFromNib {
  [super awakeFromNib];
  
  [self setupApparence];
  [self prepareForReuse];
}

- (void)prepareForReuse {
  _providerLogoImageView.image = nil;
  _departureAndArrivalTimeLabel.text = nil;
  _numberOfStopLabel.text = nil;
  _travelTimeLabel.text = nil;
  _priceLabel.text = nil;
}

#pragma mark - Content

- (void)populateCellWithViewModel:(GETravelTableViewCellModel*)viewModel {
  
  [_providerLogoImageView sd_setImageWithURL:viewModel.providerLogoURL
                            placeholderImage:nil
                                   completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                                     CGFloat imageWidth = image.size.width;
                                     CGFloat imageHeight = image.size.height;
                                     self.imageViewWidthConstraint.constant = (imageWidth * 30.0) / imageHeight;
                                   }];
  _departureAndArrivalTimeLabel.text = viewModel.departureAndArrivalTime;
  _numberOfStopLabel.text = viewModel.numberOfStop;
  _travelTimeLabel.text = viewModel.travelTime;
  _priceLabel.text = viewModel.price;
}

#pragma mark - Apparence

- (void)setupApparence {
  _departureAndArrivalTimeLabel.font = [UIFont robotoRegularFontWithSize:15];
  _numberOfStopLabel.font = [UIFont robotoLightFontWithSize:14];
  _travelTimeLabel.font = [UIFont robotoLightFontWithSize:14];
  _priceLabel.font = [UIFont robotoBoldFontWithSize:18];
  
  _priceLabel.textColor = [UIColor geDarkGrayTextColor];
  [@[_departureAndArrivalTimeLabel, _numberOfStopLabel, _travelTimeLabel] bk_each:^(UILabel* label) {
    label.textColor = [UIColor geLightGrayTextColor];
  }];
}

#pragma mark - Public Methods

+ (NSString *)defaultReuseIdentifier {
  return @"travel_cell";
}

+ (CGFloat)estimatedHeight {
  return 100.0;
}

+ (UINib *)nibForCell {
  return [UINib nibWithNibName:@"GETravelTableViewCell" bundle:nil];
}

@end
