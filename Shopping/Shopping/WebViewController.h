//
//  WebViewController.h
//  MAPP
//
//  Created by kawa on 2015/10/15.
//  Copyright © 2015年 Branko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController<UIWebViewDelegate>
{
    UIWebView *commonweb;
}
@property (nonatomic, assign) BOOL needParams;
@property (nonatomic, getter=isNeedFilter) BOOL needFilter;
@property (nonatomic, strong) NSString *urlString;
@property (nonatomic, strong) NSString *titleString;
@property (nonatomic, getter=isNeedHidingRightItem) BOOL needHidingRightItem;
@property (nonatomic, getter=isNeedCheckLogin) BOOL needCheckLogin;
@property (nonatomic, getter=isNeedConfigBackBtn) BOOL needConfigBackBtn;
-(void)startwith:(NSString *)strurl;
@end
