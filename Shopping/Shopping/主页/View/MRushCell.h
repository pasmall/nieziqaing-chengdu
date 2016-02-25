//
//  MRushCell.h
//  Shopping
//
//  Created by 聂自强 on 15/12/17.
//  Copyright © 2015年 nieziqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaiDuDealData.h"

@protocol RushDelegate <NSObject>

@optional
-(void)didSelectRushIndex:(NSInteger )index;

@end

@interface MRushCell : UITableViewCell{

    UIView *line;
}

@property(nonatomic, strong) NSArray *rushData;


@property(nonatomic, assign) id<RushDelegate> delegate;

@end
