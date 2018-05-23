//
//  AssetTableViewCell.h
//  MyMoney
//
//  Created by boxytt on 2018/3/27.
//  Copyright © 2018年 boxytt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AssetModel.h"

@interface AssetTableViewCell : UITableViewCell

- (void)configureWithModel:(AssetModel *)model;

@end
