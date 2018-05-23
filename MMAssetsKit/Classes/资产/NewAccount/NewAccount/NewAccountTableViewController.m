//
//  NewAccountTableViewController.m
//  MyMoney
//
//  Created by boxytt on 2018/4/14.
//  Copyright © 2018年 boxytt. All rights reserved.
//

#import "NewAccountTableViewController.h"
#import "NewAccountTextFieldTableViewCell.h"
#import "NewAccountPickerViewTableViewCell.h"
#import "UIColor+Standard.h"
#import "MMPickerView.h"
#import "Book.h"
@interface NewAccountTableViewController () <UITextFieldDelegate, MMPickerViewDelegate>

@property (nonatomic, strong) NSString *accountName;
@property (nonatomic, strong) NSString *pickedIconName;
@property (nonatomic, strong) NSString *money;
@property (nonatomic, strong) NSArray *iconArray;

@property (nonatomic, strong) Account *editedAccount;

@end

@implementation NewAccountTableViewController

- (instancetype)initWithEditedAccount:(Account *)account {
    if (self = [super init]) {
        self.editedAccount = account;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavRightBtn];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.tableView registerClass:[NewAccountTextFieldTableViewCell class] forCellReuseIdentifier:@"accountTextFieldCell"];
    [self.tableView registerClass:[NewAccountPickerViewTableViewCell class] forCellReuseIdentifier:@"accountPickerViewCell"];
    
    self.iconArray = @[@"现金", @"支付宝", @"微信", @"信用卡", @"分期乐", @"花呗"];
    
    self.accountName = (self.editedAccount != nil) ? self.editedAccount.accountName : @"";
    self.pickedIconName = (self.editedAccount != nil) ? self.editedAccount.iconName : @"现金";
    self.money = (self.editedAccount != nil) ? [NSString stringWithFormat:@"%.2f", [self.editedAccount.money floatValue]] : @"";
    [self.tableView reloadData];
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void)addNavRightBtn {
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(didClickedSave)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor mainBlueColor]];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    switch (indexPath.row) {
        case 0: {
            NSString *cellID = @"accountTextFieldCell";
            NewAccountTextFieldTableViewCell *cell = [[NewAccountTextFieldTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            [cell configureWithIconName:@"账户名" title:@"账户名" text:self.accountName placeHolder:@"输入账户名"];
            
            cell.inputTextField.delegate = self;
            cell.inputTextField.tag = indexPath.row;
            [cell.inputTextField addTarget:self action:@selector(changedTextField:) forControlEvents:UIControlEventEditingChanged];
            return cell;
        }
        case 1: {
            NSString *cellID = @"accountPickerViewCell";
            NewAccountPickerViewTableViewCell *cell = [[NewAccountPickerViewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            [cell configureWithIconName:@"图标" title: @"图标" pickedIconName:self.pickedIconName];
            return cell;
        }

        case 2: {
            NSString *cellID = @"accountTextFieldCell";
            NewAccountTextFieldTableViewCell *cell = [[NewAccountTextFieldTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            if ([self.accountType isEqualToString:@"信用卡"] || [self.accountType isEqualToString:@"分期乐"] || [self.accountType isEqualToString:@"花呗"]) {
                [cell configureWithIconName:@"金额" title:@"欠款" text:self.money placeHolder:@"输入金额"];
            } else {
                [cell configureWithIconName:@"金额" title:@"金额" text:self.money placeHolder:@"输入金额"];
            }
            
            
            cell.inputTextField.delegate = self;
            cell.inputTextField.keyboardType = UIKeyboardTypeDecimalPad;
            cell.inputTextField.tag = indexPath.row;
            [cell.inputTextField addTarget:self action:@selector(changedTextField:) forControlEvents:UIControlEventEditingChanged];

            return cell;
        }
        default:
            return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.view endEditing:YES];

    if (indexPath.row == 1) {
        MMPickerView *picker = [[MMPickerView alloc] init];
        picker.isIcon = YES;
        picker.isSecond = NO;
        picker.delegate = self;
        picker.title = @"选择图标";
        picker.array = self.iconArray;
        [picker show];
    }
}

#pragma mark - MMPickerViewDelegate
- (void)didPickedResult:(NSString *)result {
    self.pickedIconName = result;
    [self.tableView reloadData];
}


- (void)didClickedSave {
    
    [self.view endEditing:YES];
    
    if ([self.accountName isEqualToString:@""]) {
        [self showAlertViewWithTitle:@"提示" message:@"请输入账户名"];
        return;
    }
    if ([self.money isEqualToString:@""]) {
        [self showAlertViewWithTitle:@"提示" message:@"请输入金额"];
        return;
    }
    
    AccountManager *accountManager = [AccountManager shareInstance];
    NSArray *accounts = [accountManager selectAllAccount];
    
    if (self.editedAccount) {
        if (self.editedAccount.accountName != self.accountName || self.editedAccount.iconName != self.pickedIconName || ![[NSString stringWithFormat:@"%.2f", [self.editedAccount.money floatValue]] isEqualToString:self.money]) {
            self.editedAccount.accountName = self.accountName;
            self.editedAccount.iconName = self.pickedIconName;
            self.editedAccount.money = [NSNumber numberWithFloat:[self.money floatValue]];
            [accountManager updateAccountWithAccount:self.editedAccount];
        }
       
    } else {
        for (Account *account in accounts) {
            if ([account.accountName isEqualToString:self.accountName]) {
                [self showAlertViewWithTitle:@"提示" message:@"已存在此同名账户"];
                return;
            }
        }
        
        BOOL isDebt = NO;
        if ([self.accountType containsString:@"信用卡"] || [self.accountType containsString:@"花呗"] || [self.accountType containsString:@"分期乐"]) {
            isDebt = YES;
        }
        NSInteger currentAccountID = (accounts.count == 0) ? 0 : ([[[accounts lastObject] valueForKey:@"accountID"] integerValue] + 1);
        Account *newAccount = [[Account alloc] initWithAccountID:currentAccountID accountName:self.accountName iconName:self.pickedIconName money:[NSNumber numberWithFloat:[self.money floatValue]] isDebt:isDebt bookName:[[BookManager shareInstance] currentBookName]];
        [accountManager insertAccountWithAccount:newAccount];
    }
    
    UIViewController *vc = self.navigationController.viewControllers[1];
    [self.navigationController popToViewController:vc animated:YES];
}

- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault
                                                          handler:nil];
    
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - keyboard
- (void)changedTextField:(id)sender {
    UITextField *tempTextField = (UITextField *)sender;
    
    if (tempTextField.tag == 0) {
        self.accountName = tempTextField.text;
    } else {
        self.money = tempTextField.text;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

/** 限制金额输入框输入金额模式 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField.tag == 0) {
        return YES;
    }
    
    if (textField.text.length > 10) {
        return range.location < 11;
    } else {
        BOOL isHaveDian = YES;
        if ([textField.text rangeOfString:@"."].location == NSNotFound) {
            isHaveDian = NO;
        }
        if ([string length] > 0) {
            unichar single = [string characterAtIndex:0];   //当前输入的字符
            
            if ((single >= '0' && single <= '9') || single == '.') {     //数据格式正确
                
                //首字母不能为小数点
                if ([textField.text length] == 0) {
                    if (single == '.') {
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                }
                if ([textField.text length] == 1 && [textField.text isEqualToString:@"0"]) {
                    if (single != '.') {
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                }
                if (single=='.') {
                    if (!isHaveDian) {  //text中还没有小数点
                        isHaveDian = YES;
                        return YES;
                    } else {
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                } else {
                    if (isHaveDian) {   //存在小数点
                        
                        //判断小数点的位数
                        NSRange ran = [textField.text rangeOfString:@"."];
                        NSInteger tt = range.location - ran.location;
                        if (tt <= 2) {
                            return YES;
                        } else {
                            return NO;
                        }
                    } else {
                        return YES;
                    }
                }
            } else {    //输入的数据格式不正确
                [textField.text stringByReplacingCharactersInRange:range withString:@""];
                return NO;
            }
        } else {
            return YES;
        }
    }
}



@end
