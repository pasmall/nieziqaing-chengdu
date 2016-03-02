//
//  cartDealCell.h
//  Shopping
//
//  Created by 聂自强 on 16/2/18.
//  Copyright © 2016年 nieziqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DealInfoData.h"
#import "DBdealModel.h"

typedef enum : NSUInteger {
    ECOff,
    ECOn,
} ECselect;

@interface cartDealCell : UITableViewCell

@property (nonatomic , strong)DealInfoData *dealData;


@property (nonatomic , strong)DBdealModel *DBmodel;

@property (nonatomic , assign)ECselect isSelect;

@property (nonatomic ,assign)int sumPirce;

@property (nonatomic , assign)int count;

@property (nonatomic , copy)NSString *dealName;

@property (nonatomic , copy)NSString *onePrice;


@end
