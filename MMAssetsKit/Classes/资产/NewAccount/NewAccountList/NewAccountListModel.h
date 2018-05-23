//
//  NewAccountListModel.h
//  MyMoney
//
//  Created by boxytt on 2018/4/14.
//  Copyright © 2018年 boxytt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewAccountListModel : NSObject

@property (nonatomic, strong) NSString *iconName;
@property (nonatomic, strong) NSString *accountName;

- (instancetype)initWithAccountName:(NSString *)accountName;
@end
