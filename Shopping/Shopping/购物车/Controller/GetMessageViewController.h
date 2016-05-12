//
//  GetMessageViewController.h
//  Shopping
//
//  Created by 聂自强 on 16/5/11.
//  Copyright © 2016年 nieziqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Test1ViewController.h"
#import "Test2ViewController.h"
#import "ChatTileView.h"


@interface GetMessageViewController : UIViewController<ChatMenuDelegate,UIPageViewControllerDelegate,UIPageViewControllerDataSource,UIScrollViewDelegate>{
    Test1ViewController *yourFriendchat;
    Test2ViewController *yourShopchat;
    NSArray *conentControllers;
}

@property (nonatomic,strong)UIPageViewController *pageController;
@property (nonatomic,strong)ChatTileView *chathometile;

@end
