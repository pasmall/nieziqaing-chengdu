//
//  MHotCell.m
//  Shopping
//
//  Created by 聂自强 on 15/12/16.
//  Copyright © 2015年 nieziqiang. All rights reserved.
//

#import "MHotCell.h"
#import "GBTopLineView.h"
#import "GBTopLineViewModel.h"
#import "Common.h"

@interface MHotCell ()

@property(nonatomic,strong)NSMutableArray*dataArr;
@property (nonatomic,strong) GBTopLineView *TopLineView;

@end

@implementation MHotCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _dataArr=[[NSMutableArray alloc]init];
        [self createTopLineView];
        [self getData];
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 44, MainW, 10)];
        [imgView setImage:[UIImage  imageNamed:@"line_VIP_02"]];
        [self addSubview:imgView];
    }
    return self;
}



#pragma mark init
-(void)createTopLineView{
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
    [imgView setImage:[UIImage  imageNamed:@"hot"]];
    [self addSubview:imgView];
    
    _TopLineView = [[GBTopLineView alloc]initWithFrame:CGRectMake(80, 10, MainW, 24)];
    _TopLineView.backgroundColor = [UIColor whiteColor];
    __weak __typeof(self)weakSelf = self;
    _TopLineView.clickBlock = ^(NSInteger index){
        GBTopLineViewModel *model = weakSelf.dataArr[index];
        NSLog(@"%@,%@",model.type,model.title);
    };
    [self addSubview:_TopLineView];
    
}

- (void)getData
{
    NSArray *arr1 = @[@"[最新]",@"[最热]",@"[最热]",@"[最新]",@"[抽奖]"];
    NSArray *arr2 = @[@"美味的食品来一波",@"漂亮的衣服来一波",@"好看的动漫来一波",@"爱心要奉献很多很多",@"超市我反正不想去"];
    for (int i=0; i<arr2.count; i++) {
        GBTopLineViewModel *model = [[GBTopLineViewModel alloc]init];
        model.type = arr1[i];
        model.title = arr2[i];
        [_dataArr addObject:model];
    }
    [_TopLineView setVerticalShowDataArr:_dataArr];
}


@end
