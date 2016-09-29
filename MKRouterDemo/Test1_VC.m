//
//  Test1_VC.m
//  MKRouterDemo
//
//  Created by xmk on 16/9/27.
//  Copyright © 2016年 mk. All rights reserved.
//

#import "Test1_VC.h"
#import "MKRouterConst.h"

@interface Test1_VC ()

@end

@implementation Test1_VC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"test1";
    
    [self.datasArray addObject:@"0 "];
    [self.datasArray addObject:@"1 "];
    [self.datasArray addObject:@"2 "];
    
    [self setupUISingleTableView];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"test1"];
    
}

- (void)mk_viewDidLoadQuery:(NSDictionary *)queryItems{
    ELog(@"test1 queryItems : %@", queryItems);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"test1"];
    cell.backgroundColor = [UIColor greenColor];
    cell.textLabel.text = [self.datasArray objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:{
            [[MKRouter router] open:@"/first"];
        }
            break;
        case 1:{
            
        }
            break;
        default:
            break;
    }
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
