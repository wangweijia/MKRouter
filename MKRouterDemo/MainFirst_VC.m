//
//  MainFirst_VC.m
//  MKRouterDemo
//
//  Created by xmk on 16/9/27.
//  Copyright © 2016年 mk. All rights reserved.
//

#import "MainFirst_VC.h"
#import "MKRouterConst.h"

@interface MainFirst_VC ()
@end

@implementation MainFirst_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];

    [self.datasArray addObject:@"0 "];
    [self.datasArray addObject:@"1 "];
    [self.datasArray addObject:@"2 "];
    [self.datasArray addObject:@"3 "];
    [self.datasArray addObject:@"4 "];
    [self.datasArray addObject:@"5 "];
    [self.datasArray addObject:@"6 "];
    [self.datasArray addObject:@"7 "];
    [self.datasArray addObject:@"8 "];
    [self setupUISingleTableView];

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"first"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"first"];
    cell.backgroundColor = [UIColor redColor];
    cell.textLabel.text = [self.datasArray objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:{
            [[MKRouter router] open:@"/home/home/home"];
        }
            break;
        case 1:{
            [[MKRouter router] open:@"/user/10238372?lalal=88&sss=999&rr=11"];
        }
            break;
        case 2:{
            [[MKRouter router] open:@"/home/user/10238372"];
        }
            break;
        case 3:{
            [[MKRouter router] redirect:@"MAIN"];

//            [[MKRouter router] open:@"/test1/test1/test1"];
//            [[MKRouter router] open:@"/test2"];
//            [[MKRouter router] open:@"MKRouterDemo://test3"];
        }
            break;
//        case 4:{
//            [[MKRouter router] open:@"MKRouterDemo://test1/text2/666666?lalala=88&sss=99"];
//        }
//            break;
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
