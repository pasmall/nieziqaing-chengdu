//
//  ChatTileView.m
//  kanatalk
//
//  Created by nieziqiang on 2015/06/06.
//  Copyright (c) 2015年 kanae.ne.jp. All rights reserved.
//

#import "ChatTileView.h"
#import "Common.h"

@implementation ChatTileView
@synthesize delegate;
-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor= RGB(232, 201, 87);
        
//        chatHometitle=[[UILabel alloc]initWithFrame:CGRectMake(0,10, CGRectGetWidth(self.bounds), 16)];
//        chatHometitle.textAlignment=NSTextAlignmentCenter;
//        chatHometitle.textColor=[UIColor whiteColor];
//        chatHometitle.text=@"コミュニティ";
//        chatHometitle.font=W6FONT(14);
//        chatHometitle.backgroundColor=[UIColor yellowColor];
//        [self addSubview:chatHometitle];
        
        
        tabfriend_on=[[UIView alloc]initWithFrame:CGRectMake(32 ,42 , 112 , 16 )];
        tabfriend_on.backgroundColor=[UIColor whiteColor];
        tabfriend_on.alpha=1;
        tabfriend_on.layer.cornerRadius=3;
        tabfriend_on.clipsToBounds=YES;
        [self addSubview:tabfriend_on];
        
        friendtitle=[[UILabel alloc]initWithFrame:CGRectMake(32 ,42 , 112 , 16 )];
//        friendtitle.backgroundColor=[UIColor yellowColor];
        friendtitle.textAlignment=NSTextAlignmentCenter;
        friendtitle.textColor=mainColor;
        friendtitle.text=@"店铺";
        friendtitle.font=[UIFont systemFontOfSize:12];
        [self addSubview:friendtitle];
        
        tabshop_on=[[UIView alloc]initWithFrame:CGRectMake(176 ,42 , 112 , 16 )];
        tabshop_on.backgroundColor=[UIColor whiteColor];
        tabshop_on.alpha=0;
//        friendtitle.backgroundColor=[UIColor redColor];
        tabshop_on.layer.cornerRadius=3;
        tabshop_on.clipsToBounds=YES;
        [self addSubview:tabshop_on];
        
        shoptitle=[[UILabel alloc]initWithFrame:CGRectMake(176 ,42 , 112 , 16 )];
        shoptitle.textAlignment=NSTextAlignmentCenter;
        shoptitle.textColor=[UIColor whiteColor];
        shoptitle.text=@"系统";
        shoptitle.font=[UIFont systemFontOfSize:12];
        [self addSubview:shoptitle];
        
//        btn_topright=[UIButton buttonWithType:UIButtonTypeCustom];
//        btn_topright.frame=CGRectMake(self.frame.size.width-32 , 0, 32 , 32 );
//        btn_topright.backgroundColor=[UIColor redColor];
//        [btn_topright setImage:[UIImage imageNamed:@"talk_list_friend_plus_icon.png"] forState:UIControlStateNormal];
//        [btn_topright addTarget:self action:@selector(gotoSearchORplus) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:btn_topright];
        
//        UIView *sss=[[UIView alloc]initWithFrame:CGRectMake(friendtitle.frame.origin.x, friendtitle.frame.origin.y-10 , friendtitle.frame.size.width, friendtitle.frame.size.height+10 )];
//        sss.backgroundColor=[UIColor grayColor];
//        [self addSubview:sss];
//        
//        UIView *sss1=[[UIView alloc]initWithFrame:CGRectMake(shoptitle.frame.origin.x, shoptitle.frame.origin.y-10 , shoptitle.frame.size.width, shoptitle.frame.size.height+10 )];
//        sss1.backgroundColor=[UIColor redColor];
//        [self addSubview:sss1];
        
        self.multipleTouchEnabled=NO;
        
    }
    return self;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSSet *allTouches = [event allTouches];
    UITouch *touch = [allTouches anyObject];
    
    CGPoint point = [touch locationInView:self];
    if(CGRectContainsPoint(CGRectMake(friendtitle.frame.origin.x, friendtitle.frame.origin.y-10 , friendtitle.frame.size.width, friendtitle.frame.size.height+10 ), point))
    {
        [delegate MenuTouch:0];
        [self setMenuIndex:0];
    }
    if(CGRectContainsPoint(CGRectMake(shoptitle.frame.origin.x, shoptitle.frame.origin.y-10 , shoptitle.frame.size.width, shoptitle.frame.size.height+10 ), point))
    {
        [delegate MenuTouch:1];
        [self setMenuIndex:1];
    }
}

-(void)setTouchEnable:(BOOL)isenable
{
    self.userInteractionEnabled=isenable;
}

-(void)setMenuIndex:(NSInteger)index
{
    if(index==0)
    {
//        chatHometitle.text=@"コミュニティ";
    [UIView animateWithDuration:0.5 animations:^{
        friendtitle.textColor=mainColor;
        shoptitle.textColor=[UIColor whiteColor];
        tabshop_on.alpha=0;
        tabfriend_on.alpha=1;
//        [btn_topright setImage:[UIImage imageNamed:@"talk_list_friend_plus_icon.png"] forState:UIControlStateNormal];
    } completion:^(BOOL finished) {
        
    }];
    }
    else
    {
//        chatHometitle.text=@"コミュニティ";
        [UIView animateWithDuration:0.5 animations:^{
            friendtitle.textColor=[UIColor whiteColor];
            shoptitle.textColor=mainColor;
            tabshop_on.alpha=1;
            tabfriend_on.alpha=0;
//            [btn_topright setImage:[UIImage imageNamed:@"talk_list_group_search_icon.png"] forState:UIControlStateNormal];
        } completion:^(BOOL finished) {
            
        }];
    }
}

-(void)back
{
    
}

//-(void)gotoSearchORplus
//{
//    if(tabfriend_on.alpha==1)
//    {
////        -(void)gotoSearch;
////        -(void)gotoFriend;
//        [delegate gotoFriend];
//    }
//    else{
//        [delegate gotoSearch];
//    }
//}
@end
