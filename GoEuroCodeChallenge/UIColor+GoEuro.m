//
//  UIColor+GoEuro.m
//  GoEuroCodeChallenge
//
//  Created by Sebastiano Catellani on 28/01/17.
//  Copyright © 2017 Sebastiano Catellani. All rights reserved.
//

#import "UIColor+GoEuro.h"

@implementation UIColor (GoEuro)

+ (UIColor *)geBlueColor {
  return [UIColor colorWithRed:15.0/255.0 green:97.0/255.0 blue:163.0/255.0 alpha:1.0];
}

+ (UIColor *)geLightGrayTextColor {
  return [UIColor colorWithWhite:137.0/255.0 alpha:1];
}

+ (UIColor *)geDarkGrayTextColor {
  return [UIColor colorWithRed:64.0/255.0 green:74.0/255.0 blue:91.0/255.0 alpha:1.0];
}

+ (UIColor *)geOrangeColor {
  return [UIColor colorWithRed:252/255.0 green:156.0/255.0 blue:33.0/255.0 alpha:1.0];
}

@end
