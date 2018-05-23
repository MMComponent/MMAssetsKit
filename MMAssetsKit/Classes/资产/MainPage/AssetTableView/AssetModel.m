//
//  AssetModel.m
//  MyMoney
//
//  Created by boxytt on 2018/3/27.
//  Copyright © 2018年 boxytt. All rights reserved.
//

#import "AssetModel.h"

@implementation AssetModel


- (instancetype)initWithAccount:(Account *)account {
    if (self = [super init]) {
        self.iconName = account.iconName;
        self.accountName = account.accountName;
        self.money = account.money;
    }
    return self;
}

@end
