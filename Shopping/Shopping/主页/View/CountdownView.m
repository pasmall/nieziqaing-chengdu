//
//  CountdownView.m
//  Shopping
//
//  Created by 聂自强 on 15/12/17.
//  Copyright © 2015年 nieziqiang. All rights reserved.
//

#import "CountdownView.h"
// label数量
#define labelCount 4
#define separateLabelCount 3
#define padding 5
@interface CountdownView (){
    // 定时器
    NSTimer *timer;
    
    UILabel *lab1;
    UILabel *lab2;
    
    UIImageView *img;
}
@property (nonatomic,strong)NSMutableArray *timeLabelArrM;
@property (nonatomic,strong)NSMutableArray *separateLabelArrM;
// day
@property (nonatomic,strong)UILabel *dayLabel;
// hour
@property (nonatomic,strong)UILabel *hourLabel;
// minues
@property (nonatomic,strong)UILabel *minuesLabel;
// seconds
@property (nonatomic,strong)UILabel *secondsLabel;
@end

@implementation CountdownView
// 创建单例
+ (instancetype)cz_shareCountDown{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CountdownView alloc] init];
    });
    return instance;
}

+ (instancetype)cz_countDown{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.dayLabel];
        [self addSubview:self.hourLabel];
        [self addSubview:self.minuesLabel];
        [self addSubview:self.secondsLabel];
        
        UILabel *separateLabel = [[UILabel alloc] init];
        separateLabel.text = @":";
        separateLabel.backgroundColor = [UIColor whiteColor];
        separateLabel.textColor = [UIColor lightGrayColor];
        separateLabel.textAlignment = NSTextAlignmentCenter;
        lab1 = separateLabel;
        [self addSubview:separateLabel];
        
        UILabel *separate = [[UILabel alloc] init];
        separate.text = @":";
        separate.backgroundColor = [UIColor whiteColor];
        separate.textColor = [UIColor lightGrayColor];
        separate.textAlignment = NSTextAlignmentCenter;
        lab2 = separate;
        [self addSubview:separate];
        
        img = [[UIImageView alloc]init];
        [img setImage:[UIImage imageNamed:@"dianyingxuanzuo_40"]];
        img.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:img];
        


    }
    return self;
}

- (void)setBackgroundImageName:(NSString *)backgroundImageName{
    _backgroundImageName = backgroundImageName;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:backgroundImageName]];
    imageView.frame = self.bounds;
    [self addSubview:imageView];
    //    [self bringSubviewToFront:imageView];
}

// 拿到外界传来的时间戳
- (void)setTimestamp:(NSInteger)timestamp{
    _timestamp = timestamp;
    if (_timestamp != 0) {
        timer =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timer:) userInfo:nil repeats:YES];
    }
}

-(void)timer:(NSTimer*)timerr{
    _timestamp--;
    [self getDetailTimeWithTimestamp:_timestamp];
    if (_timestamp == 0) {
        [timer invalidate];
        timer = nil;
        // 执行block回调
        self.timerStopBlock();
    }
}

- (void)getDetailTimeWithTimestamp:(NSInteger)timestamp{
    NSInteger ms = timestamp;
    NSInteger ss = 1;
    NSInteger mi = ss * 60;
    NSInteger hh = mi * 60;
    NSInteger dd = hh * 24;
    
    // 剩余的
    NSInteger day = ms / dd;// 天
    NSInteger hour = (ms - day * dd) / hh;// 时
    NSInteger minute = (ms - day * dd - hour * hh) / mi;// 分
    NSInteger second = (ms - day * dd - hour * hh - minute * mi) / ss;// 秒
    //    NSLog(@"%zd日:%zd时:%zd分:%zd秒",day,hour,minute,second);
    
    self.hourLabel.text = [NSString stringWithFormat:@"%zd",hour];
    self.minuesLabel.text = [NSString stringWithFormat:@"%zd",minute];
    self.secondsLabel.text = [NSString stringWithFormat:@"%zd",second];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    // 获得view的宽、高
    CGFloat viewW = self.frame.size.width;
    CGFloat viewH = self.frame.size.height;
    // 单个label的宽高
    
    self.dayLabel.frame = CGRectMake(0, viewH*0.2, viewW *0.3, viewH);
    self.dayLabel.text = @"距开始:  ";
    self.dayLabel.backgroundColor = [UIColor whiteColor];
//    self.dayLabel.textColor = [UIColor lightGrayColor];
    self.dayLabel.textAlignment = NSTextAlignmentRight;
    
    self.hourLabel.frame = CGRectMake(viewW *0.3, viewH*0.2, viewW *0.15, viewH*0.8);
    self.minuesLabel.frame = CGRectMake(viewW *0.5 , viewH*0.2, viewW *0.15, viewH*0.8);
    self.secondsLabel.frame = CGRectMake(viewW *0.7, viewH*0.2, viewW *0.15, viewH*0.8);
    
    lab1.frame = CGRectMake(viewW *0.45, viewH*0.2, viewW *0.05, viewH * 0.8);
    lab2.frame = CGRectMake(viewW *0.65, viewH*0.2, viewW *0.05, viewH * 0.8);
    
    img.frame = CGRectMake(viewW*0.9, viewH*0.2, viewW*0.1, viewH * 0.8);
}


#pragma mark - setter & getter

- (NSMutableArray *)timeLabelArrM{
    if (_timeLabelArrM == nil) {
        _timeLabelArrM = [[NSMutableArray alloc] init];
    }
    return _timeLabelArrM;
}

- (NSMutableArray *)separateLabelArrM{
    if (_separateLabelArrM == nil) {
        _separateLabelArrM = [[NSMutableArray alloc] init];
    }
    return _separateLabelArrM;
}

- (UILabel *)dayLabel{
    if (_dayLabel == nil) {
        _dayLabel = [[UILabel alloc] init];
        _dayLabel.textAlignment = NSTextAlignmentRight;
        _dayLabel.font = [UIFont systemFontOfSize:10];
    }
    return _dayLabel;
}

- (UILabel *)hourLabel{
    if (_hourLabel == nil) {
        _hourLabel = [[UILabel alloc] init];
        _hourLabel.textAlignment = NSTextAlignmentCenter;
        _hourLabel.font = [UIFont systemFontOfSize:10 weight:12];
        _hourLabel.layer.cornerRadius = 2;
        _hourLabel.layer.masksToBounds = YES;
        _hourLabel.textColor = [UIColor whiteColor];
        _hourLabel.backgroundColor =  [UIColor lightGrayColor];
    }
    return _hourLabel;
}

- (UILabel *)minuesLabel{
    if (_minuesLabel == nil) {
        _minuesLabel = [[UILabel alloc] init];
        _minuesLabel.textAlignment = NSTextAlignmentCenter;
        _minuesLabel.layer.cornerRadius = 2;
        _minuesLabel.layer.masksToBounds = YES;
        _minuesLabel.font = [UIFont systemFontOfSize:10 weight:12];
        _minuesLabel.textColor = [UIColor whiteColor];
        _minuesLabel.backgroundColor =  [UIColor lightGrayColor];
    }
    return _minuesLabel;
}

- (UILabel *)secondsLabel{
    if (_secondsLabel == nil) {
        _secondsLabel = [[UILabel alloc] init];
        _secondsLabel.textAlignment = NSTextAlignmentCenter;
        _secondsLabel.layer.cornerRadius = 2;
        _secondsLabel.layer.masksToBounds = YES;
        _secondsLabel.font = [UIFont systemFontOfSize:10 weight:12];
        _secondsLabel.textColor = [UIColor whiteColor];
        _secondsLabel.backgroundColor =  [UIColor lightGrayColor];
    }
    return _secondsLabel;
}

@end
