//
//  MenuCell.m
//  Shopping
//
//  Created by 聂自强 on 15/12/11.
//  Copyright © 2015年 nieziqiang. All rights reserved.
//

#import "MenuCell.h"
#import "MBtnView.h"
#import "Common.h"

@interface MenuCell (){
    
    UIView *_contentView;
}



@end


@implementation MenuCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"menuData" ofType:@"plist"];
        NSArray *menuData = [NSArray arrayWithContentsOfFile:path];
        
        CGFloat btnW = MainW * 0.2;
        
        _contentView  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainW, 80)];
        [self addSubview:_contentView];
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 80, MainW, 10)];
        [imgView setImage:[UIImage  imageNamed:@"line_VIP_01"]];
        [self addSubview:imgView];
        for (int i = 0; i < menuData.count; i++) {
            
            CGRect frame = CGRectMake(i*btnW, 0, btnW, 80);
            NSString *title = [menuData[i] objectForKey:@"title"];
            NSString *imageStr = [menuData[i] objectForKey:@"image"];
            MBtnView *btnView = [[MBtnView alloc] initBtnViewWithFrame:frame andTitle:title imageName:imageStr];
            btnView.tag = 10+i;
            [_contentView addSubview:btnView];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
            [btnView addGestureRecognizer:tap];

        }
        
    }
    
    return self;
}

#pragma mark action 
- (void)OnTapBtnView:(UITapGestureRecognizer *)gesture{

    [self.delegate selectMenuWithIndex:(int)gesture.view.tag];

}




@end
