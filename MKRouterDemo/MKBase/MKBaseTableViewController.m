//
//  MKBaseTableViewController.m
//  MKDevelopSolutions
//
//  Created by xiaomk on 16/9/9.
//  Copyright © 2016年 xiaomk. All rights reserved.
//

#import "MKBaseTableViewController.h"
#import "MKRouterConst.h"

@interface MKBaseTableViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation MKBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setupUISingleTableView{
    [self setupUISingleTableViewWithStyle:UITableViewStylePlain];
}

- (void)setupUISingleTableViewWithStyle:(UITableViewStyle)style{
    _tableViewStyle = style;
    self.tableView.backgroundColor = [UIColor whiteColor];
    MKWEAKSELF
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
}


- (void)loadDataSource {
    [self.datasArray removeAllObjects];
    // subClasse
}

#pragma mark - ***** UITableView delegate ******
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // in subClass
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasArray.count ? self.datasArray.count : 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}


#pragma mark - ***** other method ******
- (void)configuraTableViewSeparatorInset {
    if ([self validateSeparatorInset]) {
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
    }
}

- (void)configuraSectionIndexBackgroundColorWithTableView:(UITableView *)tableView {
    if ([tableView respondsToSelector:@selector(setSectionIndexBackgroundColor:)]) {
        tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    }
}

- (BOOL)validateSeparatorInset {
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        return YES;
    }
    return NO;
}

#pragma mark - ***** lazy ******
- (UITableView *)tableView{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:self.tableViewStyle];
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}

- (UITableViewStyle)tableViewStyle{
    if (!_tableViewStyle) {
        _tableViewStyle = UITableViewStylePlain;
    }
    return _tableViewStyle;
}

- (NSMutableArray *)datasArray {
    if (!_datasArray) {
        _datasArray = [[NSMutableArray alloc] init];
    }
    return _datasArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
