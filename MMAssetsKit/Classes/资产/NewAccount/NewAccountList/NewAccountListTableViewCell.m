//
//  NewAccountListTableViewCell.m
//  MyMoney
//
//  Created by boxytt on 2018/4/14.
//  Copyright © 2018年 boxytt. All rights reserved.
//

#import "NewAccountListTableViewCell.h"

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)

@interface NewAccountListTableViewCell ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *accountNameLabel;


@end

@implementation NewAccountListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 40, 40)];
        [self addSubview:self.iconImageView];
        
        self.accountNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.iconImageView.frame.origin.x + self.iconImageView.frame.size.width + 10, 0, 200, 60)];
        [self addSubview:self.accountNameLabel];
        
    }
    return self;
}

- (void)configureWithModel:(NewAccountListModel *)model {
    self.iconImageView.image = [UIImage imageNamed:model.iconName];
    self.accountNameLabel.text = model.accountName;
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
