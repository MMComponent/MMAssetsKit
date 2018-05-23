//
//  NewAccountPickerViewTableViewCell.m
//  MyMoney
//
//  Created by boxytt on 2018/4/14.
//  Copyright © 2018年 boxytt. All rights reserved.
//

#import "NewAccountPickerViewTableViewCell.h"
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)

@interface NewAccountPickerViewTableViewCell ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *pickedIconImageView;

@end

@implementation NewAccountPickerViewTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 30, 30)];
        [self addSubview:self.iconImageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.iconImageView.frame.origin.x + self.iconImageView.frame.size.width + 10, 0, 200, 60)];
        [self addSubview:self.titleLabel];
        
        self.pickedIconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 30 - 40, 10, 40, 40)];
        [self addSubview:self.pickedIconImageView];
        
    }
    return self;
}

- (void)configureWithIconName:(NSString *)iconName title:(NSString *)title pickedIconName:(NSString *)pickedIconName {
    self.iconImageView.image = [UIImage imageNamed:iconName];
    self.titleLabel.text = title;
    self.pickedIconImageView.image = [UIImage imageNamed:pickedIconName];
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
