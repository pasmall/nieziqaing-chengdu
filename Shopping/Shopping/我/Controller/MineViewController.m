//
//  MineViewController.m
//  Shopping
//
//  Created by 聂自强 on 16/1/5.
//  Copyright © 2016年 nieziqiang. All rights reserved.
//

#import "MineViewController.h"
#import "Common.h"
#import "LoginViewController.h"
#import "OderViewController.h"


@interface MineViewController ()<UIAlertViewDelegate>{
    UIButton *loginbtn;
    
    UIButton *userIcon;
    
    UILabel *tipLab;
    
    UILabel *tip;
    
    UIButton *offBtn;
    
    UIButton *oderBtn;
}

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets  = NO;
    
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, MainW , MainH - 44)];
    scroll.contentSize = CGSizeMake(MainW, 631);
    scroll.bounces = YES;
    scroll.backgroundColor = RGB(239, 244, 244);
    scroll.showsVerticalScrollIndicator = NO;
    scroll.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scroll];
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainW, 150)];
    topView.backgroundColor = RGB(232, 201, 87);
    
    userIcon = [UIButton buttonWithType:UIButtonTypeCustom];
    userIcon.frame = CGRectMake(20, 20, 34, 34);
    userIcon.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [userIcon setImage:[UIImage imageNamed:@"icon_user_1"] forState:UIControlStateNormal];
    userIcon.hidden = YES;
    
    
    loginbtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 24)];
    loginbtn.centerX = MainW/2;
    loginbtn.centerY = 75 + 20;
    loginbtn.titleLabel.font = [UIFont systemFontOfSize:12 weight:10];
    loginbtn.backgroundColor = [UIColor whiteColor];
    [loginbtn setTitle:@"登陆" forState:UIControlStateNormal];
    [loginbtn setTitleColor:mainColor forState:UIControlStateNormal];
    loginbtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [loginbtn addTarget:self action:@selector(tapLogin) forControlEvents:UIControlEventTouchUpInside];
    
    tip = [[UILabel alloc]initWithFrame:CGRectMake(0, loginbtn.y + 34 , 200, 24)];
    tip.centerX = MainW/2;
    tip.font = [UIFont systemFontOfSize:10];
    tip.text = @"(´•༝• `)~~用shopping,方便快捷，省钱省心.";
    tip.textAlignment =NSTextAlignmentCenter;
    
    tipLab = [[UILabel alloc]initWithFrame:CGRectMake(64, 20, MainW - 64, 34)];
    tipLab.font = [UIFont systemFontOfSize:12];
    tipLab.textColor = RGB(131, 175, 155);
    tipLab.hidden = YES;
    
    [topView addSubview:tipLab];
    [topView addSubview:userIcon];
    [topView addSubview:tip];
    [topView addSubview:loginbtn];
    [scroll addSubview:topView];
    
    offBtn = [[UIButton alloc]initWithFrame:CGRectMake(MainW - 40, 20, 40, 20)];
    [offBtn setTitle:@"注销" forState:UIControlStateNormal];
    [offBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [offBtn addTarget:self action:@selector(clearing) forControlEvents:UIControlEventTouchUpInside];
    offBtn.titleLabel.font =[UIFont systemFontOfSize:12 weight:4];
    offBtn.hidden = YES;
    [topView addSubview:offBtn];
    
    UIImageView *imgView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 150, MainW, 261)];
    imgView1.contentMode = UIViewContentModeScaleAspectFit;
    [imgView1 setImage:[UIImage imageNamed:@"me.jpeg"]];
    imgView1.backgroundColor = [UIColor redColor];
    [scroll addSubview:imgView1];
    
    UIImageView *imgView2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 150 +261, MainW, 220)];
    imgView2.contentMode = UIViewContentModeScaleAspectFit;
    [imgView2 setImage:[UIImage imageNamed:@"me2.jpeg"]];
    imgView2.backgroundColor = [UIColor redColor];
    [scroll addSubview:imgView2];
    
    oderBtn = [[UIButton alloc]initWithFrame:CGRectMake(MainW- 80, 160, 80, 20)];
    [oderBtn addTarget:self action:@selector(tapOder) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:oderBtn];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    if ([AppDataSource sharedDataSource].isLogin) {
        loginbtn.hidden = YES;
        userIcon.hidden = NO;
        tipLab.text = [NSString stringWithFormat:@"欢迎%@",[AppDataSource sharedDataSource].userName];
        tipLab.hidden = NO;
        tip.y = loginbtn.y ;
        offBtn.hidden = NO;
        
    }else{
        loginbtn.hidden = NO;
        userIcon.hidden = YES;
        tipLab.hidden = YES;
        tip.y = loginbtn.y + 34;
        offBtn.hidden = YES;
    }
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma  mark --action

- (void)tapLogin{
    
    [self.navigationController pushViewController:[[LoginViewController alloc]init] animated:YES];

}

- (void)clearing{
    
    UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确定要退出登录吗？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    alter.tag = 66;
    [alter show];
    
    
   
    
}


- (void)tapOder{
    [self.navigationController pushViewController:[[OderViewController alloc]init] animated:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 66) {
        if (buttonIndex == 0) {
            [[AppDataSource sharedDataSource] clearDatas];
            loginbtn.hidden = NO;
            userIcon.hidden = YES;
            tipLab.hidden = YES;
            tip.y = loginbtn.y + 34;
            offBtn.hidden = YES;
        }
    }
}

@end
