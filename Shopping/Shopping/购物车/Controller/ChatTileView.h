//
//  ChatTileView.h
//  kanatalk
//
//  Created by nieziqiang on 2015/06/06.
//  Copyright (c) 2015年 kanae.ne.jp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@protocol  ChatMenuDelegate;
@interface ChatTileView : UIView
{
    UILabel * friendtitle;
    UILabel * shoptitle;
    UIView *tabshop_on;
    UIView *tabfriend_on;
//    UILabel * chatHometitle;
//    UIButton *btn_topright;
    
}
@property (nonatomic,assign)id<ChatMenuDelegate> delegate;

-(void)setTouchEnable:(BOOL)isenable;
-(void)setMenuIndex:(NSInteger)index;

@end
@protocol ChatMenuDelegate
@required
-(void)MenuTouch:(NSInteger)index;
//-(void)gotoSearch;
//-(void)gotoFriend;
@end