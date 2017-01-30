//
//  GETravelsViewController.m
//  GoEuroCodeChallenge
//
//  Created by Sebastiano Catellani on 29/01/17.
//  Copyright © 2017 Sebastiano Catellani. All rights reserved.
//

#import "GETravelsViewController.h"
#import "GETravelTableViewCell.h"
#import <SVProgressHUD.h>
#import "UIFont+GoEuro.h"
#import "UIColor+GoEuro.h"
#import <BlocksKit/NSArray+BlocksKit.h>
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

@interface GETravelsViewController () <UITableViewDataSource, UITableViewDelegate, DZNEmptyDataSetSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *topContainerView;
@property (weak, nonatomic) IBOutlet UIButton *showTrainsButton;
@property (weak, nonatomic) IBOutlet UIButton *showBusesButton;
@property (weak, nonatomic) IBOutlet UIButton *showFlightsButton;

@property (weak, nonatomic) IBOutlet UILabel *trainsLabel;
@property (weak, nonatomic) IBOutlet UILabel *busesLabel;
@property (weak, nonatomic) IBOutlet UILabel *flightsLabel;
@property (weak, nonatomic) IBOutlet UIView *indicatorView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *indicatorViewWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *indicatorViewLeadingConstraint;

@end

@implementation GETravelsViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self setNavigationBarTitle];
  
  self.tableView.emptyDataSetSource = self;
  [self.tableView registerNib:[GETravelTableViewCell nibForCell] forCellReuseIdentifier:[GETravelTableViewCell defaultReuseIdentifier]];
  self.tableView.tableFooterView = [UIView new];
  
  [self setupApparence];
}

#pragma mark - Apparence

- (void)setNavigationBarTitle {
  UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 480, 44)];
  label.numberOfLines = 2;
  label.font = [UIFont robotoRegularFontWithSize:15];
  label.textColor = [UIColor whiteColor];
  label.textAlignment = NSTextAlignmentCenter;
  
  NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
  dateFormatter.dateFormat = @"MMMM dd";
  label.text = [NSString stringWithFormat:@"Berlin - Munich\n%@", [dateFormatter stringFromDate:[NSDate date]]];

  self.navigationItem.titleView = label;
}

- (void)setupApparence {
  
  [_topContainerView setBackgroundColor:[UIColor geBlueColor]];
  
  [@[_busesLabel, _trainsLabel, _flightsLabel] bk_each:^(UILabel *label) {
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont robotoRegularFontWithSize:16];
  }];
  
  [_indicatorView setBackgroundColor:[UIColor geOrangeColor]];
  
  dispatch_async(dispatch_get_main_queue(), ^{
    [self moveIndicatorViewToLabel:_busesLabel animated:false];
  });
}

- (void)moveIndicatorViewToLabel:(UILabel*)label  animated:(BOOL)animated {
  _indicatorViewWidthConstraint.constant = CGRectGetWidth(label.frame) * 2;
  _indicatorViewLeadingConstraint.constant = CGRectGetMinX(label.frame) - CGRectGetWidth(label.frame) / 2;
  
  if (animated) {
    [UIView animateWithDuration:0.3
                     animations:^{
                       [self.view layoutIfNeeded];
                     }];
  }
}

#pragma mark - DZNEmptyDataSetSource

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
  NSString *text = @"No travels found!";
  NSDictionary *attributes = @{
                               NSFontAttributeName: [UIFont robotoBoldFontWithSize:16],
                               NSForegroundColorAttributeName: [UIColor geDarkGrayTextColor]
                               };
  return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
  NSString *text = @"Please, take a look at the other travel option.";
  NSDictionary *attributes = @{
                               NSFontAttributeName: [UIFont robotoRegularFontWithSize:15],
                               NSForegroundColorAttributeName: [UIColor geLightGrayTextColor]
                               };
  return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

#pragma mark - GETrainsViewModelDelegate

- (void)refreshIndicatorVisible:(BOOL)isVisible {
  if (isVisible) {
    [SVProgressHUD showWithStatus:@"Loading..."];
  } else {
    [SVProgressHUD dismiss];
  }
}

- (void)reloadData {
  [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return [self.viewModel numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.viewModel numberOfItemsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  GETravelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[GETravelTableViewCell defaultReuseIdentifier] forIndexPath:indexPath];
  
  NSInteger row = indexPath.row;
  NSInteger section = indexPath.section;
  GETravelTableViewCellModel * cellViewModel = [_viewModel viewModelForTravelAtRow:row inSection:section];
  [cell populateCellWithViewModel:cellViewModel];
  
  return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return [GETravelTableViewCell estimatedHeight];
}

#pragma mark - IBActions

- (IBAction)showTrains:(id)sender {
  [self moveIndicatorViewToLabel:_trainsLabel animated:true];
  [self.viewModel selectedTravelOption:Train];
}

- (IBAction)showBuses:(id)sender {
  [self moveIndicatorViewToLabel:_busesLabel animated:true];
  [self.viewModel selectedTravelOption:Bus];
}

- (IBAction)showFlights:(id)sender {
  [self moveIndicatorViewToLabel:_flightsLabel animated:true];
  [self.viewModel selectedTravelOption:Flight];
}

@end
