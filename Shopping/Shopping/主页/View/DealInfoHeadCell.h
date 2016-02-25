//
//  DealInfoHeadCell.h
//  Shopping
//
//  Created by 聂自强 on 16/1/13.
//  Copyright © 2016年 nieziqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DealInfoData.h"


@interface DealInfoHeadCell : UITableViewCell{

//    UIImageView *bgImage;
    
    UILabel *lab1;
    UIButton *btn4;
    
    UITextView *textView;
    
//    UIView *navView;
    
}
@property (nonatomic ,strong)UIImageView *bgImage;

@property (nonatomic ,strong)DealInfoData *data;

@end
