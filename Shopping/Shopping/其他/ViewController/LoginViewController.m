//
//  LoginViewController.m
//  Shopping
//
//  Created by 聂自强 on 16/2/19.
//  Copyright © 2016年 nieziqiang. All rights reserved.
//

#import "LoginViewController.h"
#import "Common.h"
#import "AppDelegate.h"
#import "RegisterViewController.h"

@interface LoginViewController()<UITextFieldDelegate>{
    UITextField *_phoneField;
    UITextField *_passWordField;
    UIButton *_logInBtn;
}

@end

@implementation LoginViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:RGB(255, 214, 224)];
    [self.navigationController setNavigationBarHidden:YES];
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(25, 20, 50, 50)];
    [imgView setImage:[UIImage imageNamed:@"login_icon.jpg"]];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    
    imgView.layer.cornerRadius = 25;
    imgView.layer.masksToBounds = YES;
    
    [self.view addSubview:imgView];
    
    
    /**
     关闭按钮
     */
    UIButton *closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(MainW - 40 - 10, 25, 40, 40)];
    closeBtn.backgroundColor = [UIColor whiteColor];
    [closeBtn setImage:[UIImage imageNamed:@"icon_nav_quxiao_normal"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(clickCloseBtn) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.layer.cornerRadius = 20;
    closeBtn.layer.masksToBounds = YES;
    [self.view addSubview:closeBtn];
    
    UIView *fieldView = [[UIView alloc]initWithFrame:CGRectMake(20, 130,280, 80)];
    [fieldView setBackgroundColor:[UIColor whiteColor]];
    [fieldView.layer setBorderWidth:0.5f];
    [fieldView.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.view addSubview:fieldView];
    
    _phoneField = [[UITextField alloc]initWithFrame:CGRectMake(20, 0, MainW - 40, CGRectGetHeight(fieldView.bounds)/2)];
    [_phoneField setPlaceholder:@"请输入账号"];
    [_phoneField setKeyboardType:UIKeyboardTypeEmailAddress];
    [_phoneField setDelegate:self];
    [_phoneField addTarget:self action:@selector(checkTextFieldInput:) forControlEvents:UIControlEventEditingChanged];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_phoneField.bounds), CGRectGetWidth(fieldView.bounds) - 20, 0.5f)];
    [lineView setBackgroundColor:[UIColor lightGrayColor]];
    
    _passWordField = [[UITextField alloc]initWithFrame:CGRectMake(20, CGRectGetHeight(fieldView.bounds)/2, MainW - 40, CGRectGetHeight(fieldView.bounds)/2)];
    [_passWordField setPlaceholder:@"请输入密码"];
    [_passWordField setKeyboardType:UIKeyboardTypeDefault];
    [_passWordField setSecureTextEntry:YES];
    [_passWordField setDelegate:self];
    [_passWordField addTarget:self action:@selector(checkTextFieldInput:) forControlEvents:UIControlEventEditingChanged];
    [fieldView addSubview:_phoneField];
    [fieldView addSubview:lineView];
    [fieldView addSubview:_passWordField];
    
    
    
    _logInBtn= [[UIButton alloc]initWithFrame:CGRectMake(0 ,CGRectGetMaxY(fieldView.frame)+44, 80, 40)];
    _logInBtn.centerX = MainW/2;
    [_logInBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_logInBtn setTitle:@"登录" forState:UIControlStateDisabled];
    _logInBtn.titleLabel.font = [UIFont systemFontOfSize:15 weight:10];
    [_logInBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [_logInBtn setTitleColor:mainColor forState:UIControlStateNormal];
    _logInBtn.backgroundColor = [UIColor whiteColor ];
    [_logInBtn addTarget:self action:@selector(clickedLogInBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_logInBtn];
    [_logInBtn setEnabled:NO];
    
    
    UIButton *registBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_logInBtn.frame)+80, MainW, 24)];
    [registBtn setTitle:@"౿(།﹏།)૭还没有账号,立刻点击注册吧~~" forState:UIControlStateNormal];
    [registBtn setTitleColor:RGB(147, 120, 181) forState:UIControlStateNormal];
    registBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    registBtn.titleLabel.font = [UIFont systemFontOfSize:12 weight:8];
    [registBtn addTarget:self action:@selector(Tapregister) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registBtn];
    
}

- (void)viewWillAppear:(BOOL)animated{
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    app.rootTabbarVc.tabBar.hidden = YES;
}


#pragma mark --action

- (void)clickCloseBtn{
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    app.rootTabbarVc.tabBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)clickedLogInBtn:(UIButton *)sender{
    UserModel *model = [[UserModel alloc]init];
    model.userName =_phoneField.text;
    model.userPsd  = _passWordField.text;
    BOOL resut =  [DBHelper isExistUser:model];
    if(resut){
        [SVProgressHUD showWithStatus:@"正在登陆..." maskType:SVProgressHUDMaskTypeClear];
        
        __block LoginViewController *weakSelf = self;
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC));
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        
            [weakSelf clickCloseBtn];
            [[AppDataSource sharedDataSource] setUserName:model.userName];
            [[AppDataSource sharedDataSource] setIsLogin:YES];
            [SVProgressHUD dismiss];
        });
        
        
        
    }else{
        [MBProgressHUD_Custom showSuccess:@"(˃᷄˶˶̫˶˂᷅)亲~ 用户名或者密码有误哦"];
    }

}

- (void)Tapregister{
    [self.navigationController pushViewController:[[RegisterViewController alloc]init] animated:YES];
}

#pragma mark - UITextField Delegate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == _passWordField)
    {
        //TODO 正则匹配验证电话号码的有效性
    }
    else if (textField == _passWordField)
    {
        return;
    }
}

- (void)checkTextFieldInput:(UITextField *)textField
{
    //当用户输入了电话和密码时候logIN按钮才能点击
    if (_passWordField.text.length > 0 && _phoneField.text.length > 0) {
        [_logInBtn setEnabled:YES];
    }else{
        [_logInBtn setEnabled:NO];
    }
    
}

@end
