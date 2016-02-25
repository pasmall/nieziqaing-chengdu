//
//  DealInfoTipCell.h
//  Shopping
//
//  Created by 聂自强 on 16/2/16.
//  Copyright © 2016年 nieziqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DealInfoTipCell : UITableViewCell

@property (nonatomic ,copy)NSString *data;

@property (nonatomic , strong)UIWebView *webView;

@property (nonatomic , strong)UILabel *title;

@property (nonatomic , strong)UIView *headView;

@property (nonatomic , assign)NSUInteger count;

@end
