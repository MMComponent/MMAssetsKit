//
//  CALayer+LayerColor.m
//  MyMoney
//
//  Created by boxytt on 2018/3/16.
//  Copyright © 2018年 boxytt. All rights reserved.
//

#import "CALayer+LayerColor.h"

@implementation CALayer (LayerColor)

- (void)setBorderColorFromUIColor:(UIColor *)color {
    self.borderColor = color.CGColor;
}


@end
