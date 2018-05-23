//
//  UIColor+Standard.h
//  MyMoney
//
//  Created by boxytt on 2018/3/16.
//  Copyright © 2018年 boxytt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Standard)


/**
 主题色

 @return #3C96BE
 */
+ (UIColor *)mainBlueColor;


/**
 深色

 @return #507387
 */
+ (UIColor *)darkBlueColor;


/**
 浅色

 @return #A5B9BE
 */
+ (UIColor *)lightBlueColor;

/**
 收入红
 
 @return #F06464
 */
+ (UIColor *)incomeRedColor;

/**
 支出绿
 
 @return #3CC39B
 */
+ (UIColor *)expenseGreenColor;
@end
