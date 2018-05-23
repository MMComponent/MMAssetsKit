//
//  AssetTopView.m
//  MyMoney
//
//  Created by boxytt on 2018/3/28.
//  Copyright © 2018年 boxytt. All rights reserved.
//

#import "AssetTopView.h"
#import "Account.h"

@interface AssetTopView ()

@property (weak, nonatomic) IBOutlet UILabel *firstValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstKeyLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondKeyLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdKeyLabel;



@end

@implementation AssetTopView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.firstKeyLabel.text = @"净资产";
        self.secondKeyLabel.text = @"资产";
        self.thirdKeyLabel.text = @"负债";
    }
    return self;
}

- (void)configureWithAccountDic:(NSDictionary *)accountDic {
    
    CGFloat firstValue = 0.00;
    CGFloat secondValue = 0.00;
    CGFloat thirdValue = 0.00;
    
    
    for (Account *account in accountDic[@"assetAccounts"]) {
        secondValue += [account.money floatValue];
    }
    
    for (Account *account in accountDic[@"debtAccounts"]) {
        thirdValue += [account.money floatValue];
    }
    
    firstValue = secondValue - thirdValue;
    
    self.firstValueLabel.text = [NSString stringWithFormat:@"%.2f", firstValue];
    self.secondValueLabel.text = [NSString stringWithFormat:@"%.2f", secondValue];
    self.thirdValueLabel.text = [NSString stringWithFormat:@"%.2f", thirdValue];

}



@end
