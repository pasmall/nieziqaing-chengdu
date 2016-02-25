//
//  MImageCell.h
//  Shopping
//
//  Created by 聂自强 on 15/12/15.
//  Copyright © 2015年 nieziqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MImageCell : UITableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier menuArray:(NSMutableArray *)imageArray;

@end
