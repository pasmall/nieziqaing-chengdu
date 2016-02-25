//
//  MenuCell.h
//  Shopping
//
//  Created by 聂自强 on 15/12/11.
//  Copyright © 2015年 nieziqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuCellDelegate <NSObject>

- (void)selectMenuWithIndex:(int)index;

@end

@interface MenuCell : UITableViewCell

@property (nonatomic , assign)id<MenuCellDelegate>delegate;

@end
