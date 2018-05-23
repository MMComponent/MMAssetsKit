//
//  NewAccountTextFieldTableViewCell.h
//  MyMoney
//
//  Created by boxytt on 2018/4/14.
//  Copyright © 2018年 boxytt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewAccountTextFieldTableViewCell : UITableViewCell

@property (nonatomic, strong) UITextField *inputTextField;

- (void)configureWithIconName:(NSString *)iconName title:(NSString *)title text:(NSString *)text placeHolder:(NSString *)placeHolder;

@end
