//
//  GETravelsViewController.h
//  GoEuroCodeChallenge
//
//  Created by Sebastiano Catellani on 29/01/17.
//  Copyright © 2017 Sebastiano Catellani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GETrainsViewModel.h"

@interface GETravelsViewController : UIViewController<GETrainsViewModelDelegate>

@property (nonatomic, strong) GETrainsViewModel *viewModel;

@end
