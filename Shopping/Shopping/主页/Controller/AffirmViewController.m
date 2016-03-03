//
//  AffirmViewController.m
//  Shopping
//
//  Created by 聂自强 on 16/2/29.
//  Copyright © 2016年 nieziqiang. All rights reserved.
//

#import "AffirmViewController.h"
#import "Common.h"
#import "AffirmModel.h"
#import "PayViewController.h"

@interface AffirmViewController ()<UITableViewDataSource , UITableViewDelegate >{
    UIView *_navView;
    UIButton *_backBtn;
    UILabel *_title;
    UIButton *_rightBtn;
    
    UIView *_downView;
    UIButton *_selectBtn;
    UILabel *_sumPrice;
    UIButton *_clearingBtn;
    
    UILabel *lab;
    UITableView *_tableView;
}

@end

@implementation AffirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(244, 244, 244);
    
    
    UITableView *tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, MainW, MainH-64 - 44)];
    tabelView.backgroundColor = RGB(244, 244, 244);
    tabelView.dataSource = self;
    tabelView.delegate =self;
    tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tabelView.showsVerticalScrollIndicator = NO;
    _tableView = tabelView;
//    UIView *foot = [[UIView alloc]init];
//    _tableView.tableFooterView = foot;
//    _tableView.tableFooterView.backgroundColor = RGB(250, 250, 250);
    [self.view addSubview:tabelView];
    
    [self initNav];
    [self initDownView];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
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
    _title.text = @"确认订单";
    _title.textAlignment = NSTextAlignmentCenter;
    _title.textColor = [UIColor blackColor];
    [_navView addSubview:_title];
    
//    _rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(MainW- 5-44, 20, 44, 44)];
//    _rightBtn.titleLabel.textAlignment  = NSTextAlignmentRight;
//    [_rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
//    _rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//    [_rightBtn setTitleColor:mainColor forState:UIControlStateNormal];
//    [_rightBtn addTarget:self action:@selector(tapEdit) forControlEvents:UIControlEventTouchUpInside];
//    [_navView addSubview:_rightBtn];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 63, MainW, 0.5)];
    line.backgroundColor  = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    [_navView addSubview:line];
    
    
}

- (void)initDownView{
    _downView = [[UIView alloc]initWithFrame:CGRectMake(0, MainH - 43.5, MainW, 43.5)];
    _downView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_downView];
    
//    _selectBtn = [[UIButton alloc]init];
//    _selectBtn.contentMode = UIViewContentModeScaleAspectFit;
//    [_selectBtn setImage:[UIImage imageNamed:@"icon_check_01@2x"] forState:UIControlStateNormal];
//    [_selectBtn addTarget:self action:@selector(TapSelectBtn) forControlEvents:UIControlEventTouchUpInside];
//    _selectBtn.frame = CGRectMake(10, 0, 20, 20);
//    
//    _selectBtn.centerY = _downView.height*0.5;
//    
//    [_downView addSubview:_selectBtn];
    
    
    lab = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 60, 20)];
    lab.text = @"还需支付:";
    lab.centerY =_downView.height*0.5;
    lab.font = [UIFont systemFontOfSize:12];
    lab.textColor = [UIColor blackColor];
    [_downView addSubview:lab];
    
    _sumPrice = [[UILabel alloc]initWithFrame:CGRectMake(85, 0, 100, 20)];
    _sumPrice.font =[UIFont systemFontOfSize:12];
    _sumPrice.textColor = mainColor;
    _sumPrice.centerY =_downView.height*0.5;
    _sumPrice.text = self.allPrice;
    [_downView addSubview:_sumPrice];
    
    _clearingBtn = [[UIButton alloc]initWithFrame:CGRectMake(MainW*2/3, 0, MainW/3, 43.5)];
    //    _clearingBtn.backgroundColor = RGB(255, 214, 224);
    _clearingBtn.backgroundColor = mainColor;
    _clearingBtn.titleLabel.font = [UIFont systemFontOfSize:13 weight:5];
    [_clearingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_clearingBtn setTitle:@"确认" forState:UIControlStateNormal];
    [_clearingBtn addTarget:self action:@selector(TapClearingBtn) forControlEvents:UIControlEventTouchUpInside];
    [_downView addSubview:_clearingBtn];
    
    
}
#pragma  mark -- UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.dealsArray.count + 1 ;
    }
    
    return 2;

}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"66"];
        if (indexPath.row != self.dealsArray.count) {
            AffirmModel *data = self.dealsArray[indexPath.row];
            
            UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 2, MainW/2, 20)];
            lab1.font = [UIFont systemFontOfSize:10];
            lab1.text = data.dealName;
            [cell addSubview:lab1];
            
            UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 22, MainW/2, 20)];
            lab2.font = [UIFont systemFontOfSize:10];
            lab2.text = data.onePrice;
            [cell addSubview:lab2];
            
            UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(MainW/2, 22, MainW/2- 20, 20)];
            lab3.font = [UIFont systemFontOfSize:10];
            
            NSString *str = [NSString stringWithFormat:@"×%d" , data.coount];
            lab3.text = str;
            lab3.textAlignment = NSTextAlignmentRight;
            [cell addSubview:lab3];
            
            cell.backgroundColor = [UIColor whiteColor];
            
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10, cell.height -1, MainW - 20, 1)];
            line.alpha = 0.4;
            line.backgroundColor =RGB(200, 200, 200);
            [cell addSubview:line];
            
            if (indexPath.row == 0) {
                UIView *heard = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainW, 1)];
                heard.backgroundColor = RGB(200, 200, 200);
                heard.alpha = 0.4;
                [cell addSubview:heard];
            }
            
//            if ((_dealsArray.count -1) == indexPath.row) {
//                line.frame =CGRectMake(0, cell.width -0.5f, MainW, 0.5f);
//            }
            
            return cell;
        }else{
            UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 1, MainW/2, 26)];
            lab1.font = [UIFont systemFontOfSize:10];
            lab1.text = @"总价";
            [cell addSubview:lab1];
            
            UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(MainW/2+10, 1, MainW/2-20, 26)];
            lab2.font = [UIFont systemFontOfSize:10];
            lab2.textAlignment = NSTextAlignmentRight;
            lab2.text = self.allPrice;
            [cell addSubview:lab2];
            
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 27, MainW , 1)];
            line.alpha = 0.4;
            line.backgroundColor =RGB(200, 200, 200);
            [cell addSubview:line];
            
            return cell;
        
        }
        
       
        
        
        
    }else{
        if (indexPath.row == 0) {
            UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"88"];
            
            UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 1, MainW/2, 26)];
            lab1.font = [UIFont systemFontOfSize:10];
            lab1.text = @"优惠和抵用券";
            [cell addSubview:lab1];
            
            UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(MainW/2+10, 1, MainW/2-20, 26)];
            lab2.font = [UIFont systemFontOfSize:10];
            lab2.textAlignment = NSTextAlignmentRight;
            
            lab2.text = @"- ￥0";
            [cell addSubview:lab2];
            
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainW , 1)];
            line.alpha = 0.4;
            line.backgroundColor =RGB(200, 200, 200);
            [cell addSubview:line];
            
            UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(10, 27, MainW-20 , 1)];
            line2.alpha = 0.4;
            line2.backgroundColor =RGB(200, 200, 200);
            [cell addSubview:line2];
            
            return cell;
        }else{
            UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"88"];
            
            UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 1, MainW/2, 26)];
            lab1.font = [UIFont systemFontOfSize:10];
            lab1.text = @"账户余额";
            [cell addSubview:lab1];
            
            UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(MainW/2+10, 1, MainW/2-20, 26)];
            lab2.font = [UIFont systemFontOfSize:10];
            lab2.textAlignment = NSTextAlignmentRight;
            lab2.text = @"￥0";
            [cell addSubview:lab2];
            
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 27, MainW , 1)];
            line.alpha = 0.4;
            line.backgroundColor =RGB(200, 200, 200);
            [cell addSubview:line];
            return cell;
        }
        
        
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row != self.dealsArray.count) {
            return 44;
        }else{
            return 28;
        }
    }else{
    
        return 28;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = RGB(244, 244, 244);
    return view;
}

#pragma  mark -Action 
- (void)backToLast{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)TapClearingBtn{
    PayViewController *pay = [[PayViewController alloc]init];
    pay.price = self.allPrice;
    
    [self.navigationController pushViewController:pay animated:YES];

}

@end
