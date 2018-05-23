//
//  AssetHeaderView.h
//  MyMoney
//
//  Created by boxytt on 2018/3/28.
//  Copyright © 2018年 boxytt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AssetHeaderView : UITableViewHeaderFooterView

- (void)configureWithTitle:(NSString *)title money:(NSNumber *)money;

@end
