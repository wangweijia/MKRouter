//
//  MKBaseTableViewController.h
//  MKDevelopSolutions
//
//  Created by xiaomk on 16/9/9.
//  Copyright © 2016年 xiaomk. All rights reserved.
//

#import "MKBaseViewController.h"

@interface MKBaseTableViewController : MKBaseViewController

@property (nonatomic, weak) UITableView* tableView;     /*!< main tableView */
@property (nonatomic, assign) UITableViewStyle tableViewStyle;  /*!< 初始化init的时候 设置 tableView的样式才有效 */
@property (nonatomic, strong) NSMutableArray *datasArray;   /*!< 数据源 */


/**
 *  设置单独 tableView 的UI
 */
- (void)setupUISingleTableView;
- (void)setupUISingleTableViewWithStyle:(UITableViewStyle)style;

/**
 *  加载本地或者网络数据源 下拉刷新调用 此方法， 记得重置  datasArray
 */
- (void)loadDataSource;

/**
 *  去除iOS7 新的功能 api tableView 的分割线 变成iOS6的正常的样式
 */
- (void)configuraTableViewSeparatorInset;

/**
 *  配置tableView右侧的index title 背景颜色，因为在iOS7有白色底色，iOS6没有
 *
 *  @param tableView 目标tableView
 */
- (void)configuraSectionIndexBackgroundColorWithTableView:(UITableView *)tableView;

@end
