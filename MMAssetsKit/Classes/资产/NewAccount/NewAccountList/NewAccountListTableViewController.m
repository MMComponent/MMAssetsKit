//
//  NewAccountListTableViewController.m
//  MyMoney
//
//  Created by boxytt on 2018/4/14.
//  Copyright © 2018年 boxytt. All rights reserved.
//

#import "NewAccountListTableViewController.h"
#import "NewAccountListTableViewCell.h"
#import "UIColor+Standard.h"

#import "NewAccountTableViewController.h"

@interface NewAccountListTableViewController ()

@property (nonatomic, strong) NSDictionary *accountDic;


@end

@implementation NewAccountListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.accountDic = [[NSMutableDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"newAccount" ofType:@"plist"]];
    [self.tableView registerClass:[NewAccountListTableViewCell class] forCellReuseIdentifier:@"accountListCell"];
    [self.tableView reloadData];
    self.tableView.tableFooterView = [[UIView alloc] init];
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return [self.accountDic[@"资产账户"] count];
    } else {
        return [self.accountDic[@"负债账户"] count];
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewAccountListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"accountListCell" forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[NewAccountListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"accountListCell"];
    }
    
    NSString *accountName = indexPath.section == 0 ? self.accountDic[@"资产账户"][indexPath.row] : self.accountDic[@"负债账户"][indexPath.row];
    NewAccountListModel *model = [[NewAccountListModel alloc] initWithAccountName:accountName];
    [cell configureWithModel:model];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"资产账户";
    } else {
        return @"负债账户";
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.textLabel.font = [UIFont systemFontOfSize:14];
    header.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NewAccountTableViewController *vc = [[NewAccountTableViewController alloc] init];
    
    NSString *selectedAccount = indexPath.section == 0 ? self.accountDic[@"资产账户"][indexPath.row] : self.accountDic[@"负债账户"][indexPath.row];
    vc.accountType = selectedAccount;
    
    NSString *backItemTitle;
    if ([selectedAccount containsString:@"("]) {
        backItemTitle = @"新建储值卡账户";
    } else if ([selectedAccount hasSuffix:@"账户"]) {
        backItemTitle = [NSString stringWithFormat:@"新建%@", selectedAccount];
    } else {
        backItemTitle = [NSString stringWithFormat:@"新建%@账户", selectedAccount];
    }
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:backItemTitle style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController pushViewController:vc animated:YES];
}




@end
