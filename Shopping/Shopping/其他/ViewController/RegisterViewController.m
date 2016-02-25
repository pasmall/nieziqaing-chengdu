//
//  RegisterViewController.m
//  Shopping
//
//  Created by 聂自强 on 16/2/19.
//  Copyright © 2016年 nieziqiang. All rights reserved.
//

#import "RegisterViewController.h"
#import "Common.h"
#import "AppDelegate.h"


@interface RegisterViewController()<UITextFieldDelegate ,UIAlertViewDelegate>{
    UITextField *_phoneField;
    UITextField *_passWordField;
    UIButton *_logInBtn;
    
    UIImageView *_img1;
    UIImageView *_img2;

}

@end

@implementation RegisterViewController


- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:RGB(255, 214, 224)];
    [self.navigationController setNavigationBarHidden:YES];
    
    _img1 = [[UIImageView alloc]init];
    [_img1 setImage:[UIImage imageNamed:@"s@2x"]];
    _img2 = [[UIImageView alloc]init];
    [_img2 setImage:[UIImage imageNamed:@"s@2x"]];
    _img1.contentMode = UIViewContentModeScaleAspectFit;
    _img2.contentMode = UIViewContentModeScaleAspectFit;
    
    _img1.hidden = YES;
    _img2.hidden = YES;
    
    
    /**
     关闭按钮
     */
    UIButton *closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 20, 40, 40)];
//    closeBtn.backgroundColor = [UIColor whiteColor];
    [closeBtn setImage:[UIImage imageNamed:@"icon_nav_fanhui_normal"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(clickCloseBtn) forControlEvents:UIControlEventTouchUpInside];
//    closeBtn.layer.cornerRadius = 20;
//    closeBtn.layer.masksToBounds = YES;
    [self.view addSubview:closeBtn];
    
    UIView *fieldView = [[UIView alloc]initWithFrame:CGRectMake(20, 130,280, 80)];
    [fieldView setBackgroundColor:[UIColor whiteColor]];
    [fieldView.layer setBorderWidth:0.5f];
    [fieldView.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.view addSubview:fieldView];
    
    _phoneField = [[UITextField alloc]initWithFrame:CGRectMake(20, 0, MainW - 40, CGRectGetHeight(fieldView.bounds)/2)];
    [_phoneField setPlaceholder:@"不少于两个字符的用户名"];
    [_phoneField setKeyboardType:UIKeyboardTypeEmailAddress];
    [_phoneField setDelegate:self];
    [_phoneField addTarget:self action:@selector(checkTextFieldInput:) forControlEvents:UIControlEventEditingChanged];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_phoneField.bounds), CGRectGetWidth(fieldView.bounds) - 20, 0.5f)];
    [lineView setBackgroundColor:[UIColor lightGrayColor]];
    
    _passWordField = [[UITextField alloc]initWithFrame:CGRectMake(20, CGRectGetHeight(fieldView.bounds)/2, MainW - 40, CGRectGetHeight(fieldView.bounds)/2)];
    [_passWordField setPlaceholder:@"不少于六个字符的密码"];
    [_passWordField setKeyboardType:UIKeyboardTypeDefault];
    [_passWordField setSecureTextEntry:YES];
    [_passWordField setDelegate:self];
    [_passWordField addTarget:self action:@selector(checkTextFieldInput:) forControlEvents:UIControlEventEditingChanged];
    
    [fieldView addSubview:_phoneField];
    [fieldView addSubview:lineView];
    [fieldView addSubview:_passWordField];
    
    _img1.frame = CGRectMake(fieldView.width - CGRectGetHeight(fieldView.bounds)/4 -5, 0, CGRectGetHeight(fieldView.bounds)/4, CGRectGetHeight(fieldView.bounds)/4);
    _img1.centerY = CGRectGetHeight(fieldView.bounds)/4;
    _img2.frame = CGRectMake(fieldView.width - CGRectGetHeight(fieldView.bounds)/4 -5, 0, CGRectGetHeight(fieldView.bounds)/4, CGRectGetHeight(fieldView.bounds)/4);
    _img2.centerY =CGRectGetHeight(fieldView.bounds)*3/4;
    
    [fieldView addSubview:_img1];
    [fieldView addSubview:_img2];
    
    _logInBtn= [[UIButton alloc]initWithFrame:CGRectMake(0 ,CGRectGetMaxY(fieldView.frame)+44, 80, 40)];
    _logInBtn.centerX = MainW/2;
    //    [_logInBtn setImage:[UIImage imageNamed:@"ec_login-btn-01"] forState:UIControlStateNormal];
    
    [_logInBtn setTitle:@"注册" forState:UIControlStateNormal];
    [_logInBtn setTitle:@"注册" forState:UIControlStateDisabled];
    _logInBtn.titleLabel.font = [UIFont systemFontOfSize:15 weight:10];
    [_logInBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [_logInBtn setTitleColor:mainColor forState:UIControlStateNormal];
    _logInBtn.backgroundColor = [UIColor whiteColor ];
    [_logInBtn addTarget:self action:@selector(clickedLogInBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_logInBtn];
    [_logInBtn setEnabled:NO];
    
    
//    UIButton *registBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_logInBtn.frame)+80, MainW, 24)];
//    [registBtn setTitle:@"౿(།﹏།)૭还没有账号,立刻点击注册吧~~" forState:UIControlStateNormal];
//    [registBtn setTitleColor:RGB(147, 120, 181) forState:UIControlStateNormal];
//    registBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
//    registBtn.titleLabel.font = [UIFont systemFontOfSize:12 weight:8];
//    [registBtn addTarget:self action:@selector(Tapregister) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:registBtn];
    
    
    
}

- (void)viewWillAppear:(BOOL)animated{
//    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
//    app.rootTabbarVc.tabBar.hidden = YES;
}


#pragma mark --action

- (void)clickCloseBtn{
//    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
//    app.rootTabbarVc.tabBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)clickedLogInBtn:(UIButton *)sender{
    UserModel *model = [[UserModel alloc]init];
    model.userName =_phoneField.text;
    model.userPsd  = _passWordField.text;
    [SVProgressHUD showWithStatus:@"请稍后..." maskType:SVProgressHUDMaskTypeBlack];
    
    __block  BOOL resut =  [DBHelper adduserInfo:model];
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        if(resut){
            [SVProgressHUD dismiss];
            UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"提示" message:@"恭喜你，注册成功~\(≧▽≦)/~啦啦啦！！" delegate:self cancelButtonTitle:@"立即登陆" otherButtonTitles:@"返回", nil];
            alter.tag = 1;
            [alter show];
            
        }else{
            [SVProgressHUD dismiss];
            UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"提示" message:@"亲，注册失败了呢。" delegate:self cancelButtonTitle:@"检查网络" otherButtonTitles:@"取消", nil];
            alter.tag =2;
            [alter show];
        }
    });
    
   
    
}

//- (void)Tapregister{
//    
//}

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
            if (textField == _phoneField) {
                if (textField.text.length > 1) {
                    _img1.hidden = NO;
                }else{
                    _img1.hidden = YES;
                }
            }
            else if (textField == _passWordField)
            {
                if (textField.text.length > 5) {
                    _img2.hidden = NO;
                }else{
                    _img2.hidden = YES;
                }
            }
    
    //当用户输入了电话和密码时候logIN按钮才能点击
    if (_passWordField.text.length > 5 && _phoneField.text.length > 1) {
        [_logInBtn setEnabled:YES];
    }else{
        [_logInBtn setEnabled:NO];
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 1) {
        if (buttonIndex == 0) {
            //TODO 登陆成功。
            [[AppDataSource sharedDataSource] setUserName:_phoneField.text];
            [[AppDataSource sharedDataSource] setIsLogin:YES];
            [self.navigationController popToRootViewControllerAnimated:YES];
            AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
            app.rootTabbarVc.tabBar.hidden = NO;
        }else{
            //
            [self.navigationController popToRootViewControllerAnimated:YES];
            AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
            app.rootTabbarVc.tabBar.hidden = NO;
        }
    }

}

@end
