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


@interface cartDealCell : UITableViewCell

@property (nonatomic , strong)DealInfoData *dealData;


@property (nonatomic , strong)DBdealModel *DBmodel;

@end
