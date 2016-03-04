//
//  MImageCell.m
//  Shopping
//
//  Created by 聂自强 on 15/12/15.
//  Copyright © 2015年 nieziqiang. All rights reserved.
//

#import "MImageCell.h"
#import "ZYBannerView.h"
#import "Common.h"
#import "WebViewController.h"

@interface MImageCell ()<ZYBannerViewDataSource , ZYBannerViewDelegate>{
    ZYBannerView *_banner;
    NSArray *_imageArray;
    UIPageControl *_page;
}


@end

@implementation MImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier menuArray:(NSMutableArray *)imageArray{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        ZYBannerView  *banner = [[ZYBannerView alloc]initWithFrame:CGRectMake(0, 0, MainW, 100)];
        banner.dataSource = self;
        banner.delegate = self;
        banner.shouldLoop = YES;
        banner.autoScroll = YES;
        
        _page = [[UIPageControl alloc]init];
        _page.numberOfPages = 3;
        _page.currentPageIndicatorTintColor = mainColor;
        _page.pageIndicatorTintColor = [UIColor whiteColor];
        
        _banner = banner;
        _imageArray= imageArray;
        [self addSubview:banner];
        [self addSubview:_page];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    _banner.frame = self.frame;
    _page.frame =CGRectMake(0, 0, 200,  0);
    _page.centerY = self.height - 10;
    _page.centerX = self.width /2;
}


#pragma mark ZYBannerViewDataSource
- (NSInteger)numberOfItemsInBanner:(ZYBannerView *)banner{
    return  _imageArray.count;
}
- (UIView *)banner:(ZYBannerView *)banner viewForItemAtIndex:(NSInteger)index{
    // 取出数据
    NSString *imageName = _imageArray[index];
    
    // 创建将要显示控件
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:imageName];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    return imageView;
}

#pragma mark ZYBannerViewDelegate
- (void)banner:(ZYBannerView *)banner didSelectItemAtIndex:(NSInteger)index{
    WebViewController *web = [[WebViewController alloc]init];
    [web setUrlString:@"https://m.taobao.com/#index"];
    web.titleString = @"活动展示";
    [self.homeVc.navigationController pushViewController:web animated:YES];
}

- (void)bannerCurrentPage:(NSInteger)index{
    
    _page.currentPage = index;
}

@end
