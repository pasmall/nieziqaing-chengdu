//
//  SearchViewController.h
//  Shopping
//
//  Created by 聂自强 on 16/3/7.
//  Copyright © 2016年 nieziqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController<UITableViewDelegate , UITableViewDataSource>{
    UIView *_navView;
    UIButton *_backBtn;
    UITextField *_title;
}
@property (nonatomic , strong)NSArray *deals;

@property (nonatomic,strong)UITableView *tableView;
@end
