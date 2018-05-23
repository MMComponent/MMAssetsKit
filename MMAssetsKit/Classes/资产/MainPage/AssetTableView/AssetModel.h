//
//  AssetModel.h
//  MyMoney
//
//  Created by boxytt on 2018/3/27.
//  Copyright © 2018年 boxytt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"

@interface AssetModel : NSObject

@property (nonatomic, strong) NSString *iconName;
@property (nonatomic, strong) NSString *accountName;
@property (nonatomic, strong) NSNumber *money;

- (instancetype)initWithAccount:(Account *)account;

@end

