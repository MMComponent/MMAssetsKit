//
//  AssetHeaderView.m
//  MyMoney
//
//  Created by boxytt on 2018/3/28.
//  Copyright © 2018年 boxytt. All rights reserved.
//

#import "AssetHeaderView.h"
#import "UIColor+Standard.h"
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)


@interface AssetHeaderView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *moneyLabel;

@end

@implementation AssetHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
                
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 30)];
        self.titleLabel.textColor = [UIColor lightBlueColor];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.titleLabel];
        
        self.moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 15 - 100, 0, 100, 30)];
        self.moneyLabel.textAlignment = NSTextAlignmentRight;
        self.moneyLabel.textColor = [UIColor lightBlueColor];
        self.moneyLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.moneyLabel];
    }
    return self;
}


- (void)configureWithTitle:(NSString *)title money:(NSNumber *)money {
    self.titleLabel.text = title;
    self.moneyLabel.text = [NSString stringWithFormat:@"%.2f", [money floatValue]];
}

@end
