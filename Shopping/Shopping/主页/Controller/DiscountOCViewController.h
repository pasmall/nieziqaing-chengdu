//
//  DiscountOCViewController.h
//  meituan
//  折扣view，type为0
//  Created by jinzelu on 15/7/3.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiscountOCViewController : UIViewController

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, copy) NSString *ID;
@property(nonatomic, copy) NSString *title;

@end
