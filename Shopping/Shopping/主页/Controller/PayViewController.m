//
//  PayViewController.m
//  Shopping
//
//  Created by 聂自强 on 16/3/3.
//  Copyright © 2016年 nieziqiang. All rights reserved.
//

#import "PayViewController.h"
#import "Common.h"
#import "WXApi.h"
#import "AppDelegate.h"

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.view.backgroundColor = RGB(244, 244, 244);
    self.navigationController.navigationBarHidden = YES;
    
    [self initNav];
    [self initDownBtn];
    
}



- (void)initNav{
    
    
    UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainW, 64)];
    navView.backgroundColor = [UIColor whiteColor];
    _navView = navView;
    [self.view addSubview:navView];
    
    
    _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 20, 44, 44)];
    _backBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_backBtn setImage:[UIImage imageNamed:@"icon_nav_fanhui_normal"] forState:UIControlStateNormal];
    [_backBtn setImage:[UIImage imageNamed:@"icon_nav_fanhui_normal"] forState:UIControlStateHighlighted];
    [_backBtn addTarget:self action:@selector(backToLast) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:_backBtn];
    
    _title = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, MainW- 130, 44)];
    _title.centerX = MainW /2;
    _title.text = @"收银台";
    _title.textAlignment = NSTextAlignmentCenter;
    _title.textColor = [UIColor blackColor];
    [_navView addSubview:_title];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 63, MainW, 0.5)];
    line.backgroundColor  = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    [_navView addSubview:line];
    
    
}

- (void)initDownBtn{
    UIButton *payBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, MainH - 54, MainW - 40, 39)];
    payBtn.backgroundColor = RGB(224, 47, 52);
    
    NSString *str = [NSString stringWithFormat:@"支付 %@" ,_price];
    [payBtn setTitle:str forState:UIControlStateNormal];
    [payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    payBtn.layer.cornerRadius = 5;
    payBtn.layer.masksToBounds = YES;
    
    [payBtn addTarget:self action:@selector(tapPayBtn) forControlEvents:UIControlEventTouchUpInside];
    payBtn.titleLabel.font = [UIFont systemFontOfSize:12 weight:4];
    
    [self.view addSubview:payBtn];
    
}


#pragma  mark -Action
- (void)backToLast{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)tapPayBtn{
  [self jumpToBizPay];
    
}

- (void)jumpToBizPay {
    
    //============================================================
    // V3&V4支付流程实现
    // 注意:参数配置请查看服务器端Demo
    // 更新时间：2015年11月20日
    //============================================================
    NSString *urlString   = @"http://wxpay.weixin.qq.com/pub_v2/app/app_pay.php?plat=ios";
    //解析服务端返回json数据
    NSError *error;
    //加载一个NSURL对象
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    //将请求的url数据放到NSData对象中
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if ( response != nil) {
        NSMutableDictionary *dict = NULL;
        //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
        dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
        
        NSLog(@"url:%@",urlString);
        if(dict != nil){
            NSMutableString *retcode = [dict objectForKey:@"retcode"];
            if (retcode.intValue == 0){
                NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
                
                //调起微信支付
                PayReq* req             = [[PayReq alloc] init];
                req.partnerId           = [dict objectForKey:@"partnerid"];
                req.prepayId            = [dict objectForKey:@"prepayid"];
                req.nonceStr            = [dict objectForKey:@"noncestr"];
                req.timeStamp           = stamp.intValue;
                req.package             = [dict objectForKey:@"package"];
                req.sign                = [dict objectForKey:@"sign"];
                [WXApi sendReq:req];
                //日志输出
                NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[dict objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
                UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"恭喜" message:@"成功购买,还想再逛逛?" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:@"查看我的订单", nil];
                alter.tag =66;
                [alter show];
//                return @"";
            }else{
//                return [dict objectForKey:@"retmsg"];
                UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"提示" message:[dict objectForKey:@"retmsg"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alter show];
            }
        }else{
//            return @"服务器返回错误，未获取到json对象";
            UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"提示" message:@"服务器返回错误，未获取到json对象" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alter show];
        }
    }else{
        UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"提示" message:@"服务器返回错误" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alter show];
//        return @"服务器返回错误";
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 66) {
        if (buttonIndex == 0) {
            AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
            app.rootTabbarVc.tabBar.hidden = NO;
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }else{
            
        }
    }
    
}

@end
