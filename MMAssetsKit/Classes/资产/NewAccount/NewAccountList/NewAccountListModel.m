//
//  NewAccountListModel.m
//  MyMoney
//
//  Created by boxytt on 2018/4/14.
//  Copyright © 2018年 boxytt. All rights reserved.
//

#import "NewAccountListModel.h"

@implementation NewAccountListModel

- (instancetype)initWithAccountName:(NSString *)accountName {
    if (self = [super init]) {
        
        self.accountName = accountName;
        self.iconName = @"现金";
    }
    return self;
}

@end
