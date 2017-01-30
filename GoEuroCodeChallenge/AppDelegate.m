//
//  AppDelegate.m
//  GoEuroCodeChallenge
//
//  Created by Sebastiano Catellani on 28/01/17.
//  Copyright © 2017 Sebastiano Catellani. All rights reserved.
//

#import "AppDelegate.h"
#import "GEAPIClient.h"
#import "GETrainsViewModel.h"
#import "GETravelsViewController.h"
#import "UIColor+GoEuro.h"
#import "UIFont+GoEuro.h"
#import <SVProgressHUD.h>

@interface AppDelegate ()

@property (nonatomic, strong) GEAPIClient *apiClient;

@end

@implementation AppDelegate

#pragma mark - Lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
  self.apiClient = [[GEAPIClient alloc] init];
  
  [self setupApparence];
  [self setupMVVM];
  
  return YES;
}

- (void)setupMVVM {
  UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
  GETravelsViewController *trainsViewController = (GETravelsViewController *)navigationController.topViewController;
  GETrainsViewModel *trainsViewModel = [[GETrainsViewModel alloc]
                                        initWithAPIClient:self.apiClient
                                        delegate:trainsViewController];
  trainsViewController.viewModel = trainsViewModel;
}

#pragma mark - Apparence

- (void)setupApparence {
  self.window.tintColor = [UIColor geBlueColor];
  
  [UINavigationBar appearance].barStyle = UIBarStyleBlack;
  [UINavigationBar appearance].barTintColor = [UIColor geBlueColor];
  [UINavigationBar appearance].tintColor = [UIColor whiteColor];
  [UINavigationBar appearance].translucent = NO;
  [UINavigationBar appearance].titleTextAttributes = @{
                                                       NSFontAttributeName: [UIFont robotoRegularFontWithSize:17],
                                                       NSForegroundColorAttributeName: [UIColor whiteColor]
                                                       };
  [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
  [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
  
  [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil]
   setTitleTextAttributes:@{
                            NSFontAttributeName: [UIFont robotoRegularFontWithSize:16]
                            }
   forState:UIControlStateNormal];
  
  [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
  [SVProgressHUD setFont:[UIFont robotoRegularFontWithSize:18]];
  [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
  [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
  [SVProgressHUD setBackgroundColor:[UIColor geBlueColor]];
}

@end
