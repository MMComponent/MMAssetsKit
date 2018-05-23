//
//  AssetViewController.m
//  MyMoney
//
//  Created by boxytt on 2018/3/27.
//  Copyright © 2018年 boxytt. All rights reserved.
//

#import "AssetViewController.h"
#import "AssetTableViewCell.h"
#import "AssetHeaderView.h"
#import "AssetTopView.h"
#import "NewAccountListTableViewController.h"
#import "NewAccountTableViewController.h"

#import "UIColor+Standard.h"

#import "Account.h"

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

@interface AssetViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) AssetTopView *topView;
@property (nonatomic, strong) NSDictionary *accountDic;

@end

@implementation AssetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addNavRightBtn];
    [self initTopView];
    
    [self initData];
    
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[AssetHeaderView class] forHeaderFooterViewReuseIdentifier:@"assetHeaderView"];
    
}


- (void)initData {
    AccountManager *accountManager = [AccountManager shareInstance];
    NSArray *accounts = [accountManager selectAllAccount];
    
    NSMutableArray *assetAccounts = [[NSMutableArray alloc] init];
    NSMutableArray *debtAccounts = [[NSMutableArray alloc] init];
    for (Account *account in accounts) {
        if (![[account valueForKey:@"isDebt"] boolValue]) {
            [assetAccounts addObject:account];
        } else {
            [debtAccounts addObject:account];
        }
    }
    
    self.accountDic = @{@"assetAccounts": [assetAccounts copy],
                        @"debtAccounts": [debtAccounts copy]};
    
    [self.topView configureWithAccountDic:self.accountDic];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    [self initData];
    [self.tableView reloadData];
}

- (void)initTopView {
    UIColor *startColor = [UIColor mainBlueColor];
    UIColor *endColor = [UIColor colorWithRed:155.0/255.0 green:213.0/255.0 blue:240.0/255.0 alpha:1.0];
    CAGradientLayer *layer = [[CAGradientLayer alloc] init];
    layer.colors = @[(__bridge id)startColor.CGColor, (__bridge id)endColor.CGColor];
    layer.startPoint = CGPointMake(0.5, 0);
    layer.endPoint = CGPointMake(0.5, 1);
    layer.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH * 0.5);
    [self.view.layer addSublayer:layer];
    
    [self.view addSubview:self.topView];
    
    
}

- (void)addNavRightBtn {
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"添加"] style:UIBarButtonItemStylePlain target:self action:@selector(addButtonClicked)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}

- (void)addButtonClicked {
    NewAccountListTableViewController *vc = [[NewAccountListTableViewController alloc] init];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加账户" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController pushViewController:vc animated:YES];
   
}


#pragma mark - TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([self.accountDic[@"assetAccounts"] count] && [self.accountDic[@"debtAccounts"] count]) {
        return 2;
    } else if (![self.accountDic[@"assetAccounts"] count] && ![self.accountDic[@"debtAccounts"] count]) {
        return 0;
    } else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0: {
            return [self.accountDic[@"assetAccounts"] count];
        }
        case 1: {
            return [self.accountDic[@"debtAccounts"] count];
        }
        default:
            return 0;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"assetCell";
    AssetTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[AssetTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    Account *account = (indexPath.section == 0 && [self.accountDic[@"assetAccounts"] count] != 0) ?
                                                 self.accountDic[@"assetAccounts"][indexPath.row] :
                                                 self.accountDic[@"debtAccounts"][indexPath.row];
    AssetModel *model = [[AssetModel alloc] initWithAccount:account];
    
    [cell configureWithModel:model];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    AssetHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"assetHeaderView"];
    if (!headerView) {
        headerView = [[AssetHeaderView alloc] initWithReuseIdentifier:@"assetHeaderView"];
    }
    
    if (section == 0 && [self.accountDic[@"assetAccounts"] count] != 0) {
        CGFloat money = 0.00;
        for (Account *account in self.accountDic[@"assetAccounts"]) {
            money += [account.money floatValue];
        }
        
        [headerView configureWithTitle:@"资产账户" money:[NSNumber numberWithFloat:money]];
    } else {
        CGFloat money = 0.00;
        for (Account *account in self.accountDic[@"debtAccounts"]) {
            money += [account.money floatValue];
        }
        [headerView configureWithTitle:@"负债账户" money:[NSNumber numberWithFloat:money]];
    }
    
    return headerView;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *headerView = (UITableViewHeaderFooterView *)view;
    headerView.contentView.backgroundColor = [UIColor whiteColor];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return view;}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Account *selectedAccount = [[Account alloc] init];
    if (indexPath.section == 0 && [self.accountDic[@"assetAccounts"] count] != 0) {
        selectedAccount = self.accountDic[@"assetAccounts"][indexPath.row];
    } else {
        selectedAccount = self.accountDic[@"debtAccounts"][indexPath.row];
    }
    
    NSString *backItemTitle;
    if ([selectedAccount.accountName containsString:@"("]) {
        backItemTitle = @"编辑储值卡账户";
    } else if ([selectedAccount.accountName hasSuffix:@"账户"]) {
        backItemTitle = [NSString stringWithFormat:@"编辑%@", selectedAccount.accountName];
    } else {
        backItemTitle = [NSString stringWithFormat:@"编辑%@账户", selectedAccount.accountName];
    }
    NewAccountTableViewController *vc = [[NewAccountTableViewController alloc] initWithEditedAccount:selectedAccount];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:backItemTitle style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 30;
    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0,0);
    } else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SCREEN_WIDTH * 0.5, SCREEN_WIDTH, SCREEN_HEIGHT - SCREEN_WIDTH * 0.5) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _tableView;
}

- (AssetTopView *)topView {
    if (!_topView) {
        _topView = [[NSBundle mainBundle] loadNibNamed:@"AssetTopView" owner:self options:nil][0];
        _topView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH * 0.5);
        
    }
    return _topView;
}

- (NSDictionary *)accountDic {
    if (!_accountDic) {
        _accountDic = [[NSDictionary alloc] init];
    }
    return _accountDic;
}

@end
