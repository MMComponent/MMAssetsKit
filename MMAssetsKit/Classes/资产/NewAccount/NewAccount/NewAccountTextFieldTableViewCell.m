//
//  NewAccountTextFieldTableViewCell.m
//  MyMoney
//
//  Created by boxytt on 2018/4/14.
//  Copyright © 2018年 boxytt. All rights reserved.
//

#import "NewAccountTextFieldTableViewCell.h"
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)

@interface NewAccountTextFieldTableViewCell ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation NewAccountTextFieldTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 30, 30)];
        [self addSubview:self.iconImageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.iconImageView.frame.origin.x + self.iconImageView.frame.size.width + 10, 0, 200, 60)];
        [self addSubview:self.titleLabel];
        
        self.inputTextField = [[UITextField alloc] initWithFrame:CGRectMake(self.titleLabel.frame.origin.x + self.titleLabel.frame.size.width + 10, 0, SCREEN_WIDTH - 15 - (self.titleLabel.frame.origin.x + self.titleLabel.frame.size.width + 10), 60)];
        self.inputTextField.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.inputTextField];
        
    }
    return self;
}

- (void)configureWithIconName:(NSString *)iconName title:(NSString *)title text:(NSString *)text placeHolder:(NSString *)placeHolder {
    self.iconImageView.image = [UIImage imageNamed:iconName];
    self.titleLabel.text = title;
    self.inputTextField.placeholder = placeHolder;
    self.inputTextField.text = text;
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
