//
//  AssetTableViewCell.m
//  MyMoney
//
//  Created by boxytt on 2018/3/27.
//  Copyright © 2018年 boxytt. All rights reserved.
//

#import "AssetTableViewCell.h"
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)

@interface AssetTableViewCell ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *accountNameLabel;
@property (nonatomic, strong) UILabel *moneyLabel;

@end

@implementation AssetTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        
        self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 40, 40)];
        [self addSubview:self.iconImageView];
        
        self.accountNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.iconImageView.frame.origin.x + self.iconImageView.frame.size.width + 10, 0, 200, 60)];
        [self addSubview:self.accountNameLabel];
        
        self.moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 100 - 35, 0, 100, 60)];
        self.moneyLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.moneyLabel];
        

    }
    return self;
}

- (void)configureWithModel:(AssetModel *)model {
    self.iconImageView.image = [UIImage imageNamed:model.iconName];
    self.accountNameLabel.text = model.accountName;
    self.moneyLabel.text = [NSString stringWithFormat:@"%.2f", [model.money floatValue]];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
