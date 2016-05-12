//
//  GetMessageViewController.m
//  Shopping
//
//  Created by 聂自强 on 16/5/11.
//  Copyright © 2016年 nieziqiang. All rights reserved.
//

#import "GetMessageViewController.h"
#import "Common.h"
@implementation GetMessageViewController

@synthesize pageController,chathometile;

- (instancetype)init{
    self=[super init];
    if(self)
    {
        self.navigationController.navigationBarHidden=YES;
        
        self.view.backgroundColor=RGB(200, 200, 200);
        chathometile=[[ChatTileView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 65 )];
        chathometile.delegate=self;
        [self.view addSubview:chathometile];
        
        yourFriendchat=[[Test1ViewController alloc]init];
        yourShopchat=[[Test2ViewController alloc]init];
        conentControllers=[[NSArray alloc]initWithObjects:yourFriendchat,yourShopchat, nil];
        
        pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        [self addChildViewController:pageController];
        pageController.navigationController.navigationBarHidden=YES;
        pageController.view.frame=CGRectMake(0, 65 , self.view.frame.size.width, self.view.frame.size.height-65 -39 );
        pageController.view.backgroundColor=[UIColor clearColor];
        [self.view addSubview:pageController.view];
        pageController.delegate=self;
        pageController.dataSource=self;
        pageController.automaticallyAdjustsScrollViewInsets=NO;
        [pageController setViewControllers:@[[conentControllers objectAtIndex:0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
        }];
    
    }

    return self;
}


- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)complete
{
    if([[pageViewController.viewControllers objectAtIndex:0] isKindOfClass:[Test1ViewController class]])
    {
        [chathometile setMenuIndex:0];
//        [yourFriendchat dataLoad];
    }
    else{
        [chathometile setMenuIndex:1];
    }
}


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    if([viewController isKindOfClass:[Test1ViewController class]])
    {
        return [conentControllers objectAtIndex:1];
    }else{
        return [conentControllers objectAtIndex:0];
    }
    
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    if([viewController isKindOfClass:[Test1ViewController class]])
    {
        return [conentControllers objectAtIndex:1];
    }else{
        return [conentControllers objectAtIndex:0];
    }
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)MenuTouch:(NSInteger)index
{
    if(index==0)
    {
        
        [pageController setViewControllers:@[[conentControllers objectAtIndex:0]] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:^(BOOL finished) {
            
        }];
//        [yourFriendchat dataLoad];
        [chathometile setMenuIndex:0];
    }
    else{
        [pageController setViewControllers:@[[conentControllers objectAtIndex:1]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
            
        }];
        [chathometile setMenuIndex:1];
    }
}

@end
