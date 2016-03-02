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

@property (nonatomic, strong) NSString *urlString;
@property (nonatomic, strong) NSString *titleString;

@end
