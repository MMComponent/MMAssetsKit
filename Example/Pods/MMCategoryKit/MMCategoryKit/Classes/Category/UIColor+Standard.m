//
//  UIColor+Standard.m
//  MyMoney
//
//  Created by boxytt on 2018/3/16.
//  Copyright © 2018年 boxytt. All rights reserved.
//

#import "UIColor+Standard.h"

@implementation UIColor (Standard)

+ (UIColor *)mainBlueColor {
    return [UIColor colorWithRed:60.0/255.0 green:150.0/255.0 blue:190.0/255.0 alpha:1.0];
}

+ (UIColor *)darkBlueColor {
    return [UIColor colorWithRed:80.0/255.0 green:115.0/255.0 blue:135.0/255.0 alpha:1.0];
}

+ (UIColor *)lightBlueColor {
    return [UIColor colorWithRed:165.0/255.0 green:185.0/255.0 blue:190.0/255.0 alpha:1.0];
}

+ (UIColor *)incomeRedColor {
    return [UIColor colorWithRed:240.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1.0];
}

+ (UIColor *)expenseGreenColor {
    return [UIColor colorWithRed:60.0/255.0 green:195.0/255.0 blue:155.0/255.0 alpha:1.0];
}
@end
