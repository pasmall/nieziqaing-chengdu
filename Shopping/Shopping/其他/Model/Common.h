//
//  Common.h
//  Shopping
//
//  Created by 聂自强 on 15/12/11.
//  Copyright © 2015年 nieziqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIView+Extension.h"
#import "UIImageView+WebCache.h"
#import "BaiDuAPI.h"
#import "DBHelper.h"
#import "MBProgressHUD+Custom.h"
#import "SVProgressHUD.h"
#import "AppDataSource.h"

// 屏幕大小尺寸
#define MainW [UIScreen mainScreen].bounds.size.width
#define MainH [UIScreen mainScreen].bounds.size.height

//获得RGB颜色
#define RGBA(r, g, b, a)                    [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r, g, b)                        RGBA(r, g, b, 1.0f)

#define mainColor RGB(255, 36, 111)
#define hightColor RGB(128, 128, 128)

#define navColor RGB(241, 241, 241)