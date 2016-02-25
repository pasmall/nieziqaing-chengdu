//
//  SelectedCondition.h
//  Shopping
//
//  Created by 聂自强 on 16/1/4.
//  Copyright © 2016年 nieziqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectedConditionDelegate <NSObject>

@optional
- (void)seletedChangeWithIndex:(int)x;

@end

@interface SelectedCondition : UIView

@property (nonatomic , assign)int index;

@property (nonatomic , assign)id<SelectedConditionDelegate>delegate;
@end
