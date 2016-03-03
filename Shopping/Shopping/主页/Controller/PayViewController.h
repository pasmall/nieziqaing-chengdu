//
//  PayViewController.h
//  Shopping
//
//  Created by 聂自强 on 16/3/3.
//  Copyright © 2016年 nieziqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayViewController : UIViewController<UIAlertViewDelegate>{
    UIView *_navView;
    UIButton *_backBtn;
    UILabel *_title;
}

@property (nonatomic , copy)NSString *price;

@end
