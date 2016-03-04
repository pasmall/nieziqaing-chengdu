//
//  OderViewCell.h
//  Shopping
//
//  Created by 聂自强 on 16/3/4.
//  Copyright © 2016年 nieziqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBOderMdoel.h"
#import "DealInfoData.h"


@interface OderViewCell : UITableViewCell

@property (nonatomic ,strong)DBOderMdoel *oder;

@property (nonatomic ,strong)DealInfoData *deal;

@end
