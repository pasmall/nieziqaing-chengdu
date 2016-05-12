//
//  MineViewController.m
//  Shopping
//
//  Created by 聂自强 on 16/1/5.
//  Copyright © 2016年 nieziqiang. All rights reserved.
//

#import "MineViewController.h"
#import "Common.h"
#import "LoginViewController.h"
#import "OderViewController.h"


@interface MineViewController ()<UIAlertViewDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    UIButton *loginbtn;
    
    UIButton *userIcon;
    
    UILabel *tipLab;
    
    UILabel *tip;
    
    UIButton *offBtn;
    
    UIButton *oderBtn;
    
    UIImagePickerController *pickerController;
}

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets  = NO;
    
    [self createData];
    
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, MainW , MainH - 44)];
    scroll.contentSize = CGSizeMake(MainW, 631);
    scroll.bounces = YES;
    scroll.backgroundColor = RGB(239, 244, 244);
    scroll.showsVerticalScrollIndicator = NO;
    scroll.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scroll];
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainW, 150)];
    topView.backgroundColor = RGB(232, 201, 87);
    
    userIcon = [UIButton buttonWithType:UIButtonTypeCustom];
    userIcon.frame = CGRectMake(20, 20, 54, 54);
    userIcon.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    //读取文件
    NSString *icomImage = @"icon";
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", icomImage]];
    
    BOOL blHave=[[NSFileManager defaultManager]fileExistsAtPath:filePath];
    if(blHave){
        NSLog(@"alreadyhave");
         NSData *imgData = [NSData dataWithContentsOfFile:filePath];
        UIImage *imge = [UIImage imageWithData:imgData];
        [userIcon setImage:imge forState:UIControlStateNormal];
    }else{
        [userIcon setImage:[UIImage imageNamed:@"icon_user_1"] forState:UIControlStateNormal];
    }
    
    
    
    
    userIcon.layer.cornerRadius = userIcon.width*0.5;
    userIcon.clipsToBounds = YES;
    [userIcon addTarget:self action:@selector(tapSelectIcon) forControlEvents:UIControlEventTouchDown];
    userIcon.hidden = YES;
    
    
    loginbtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 24)];
    loginbtn.centerX = MainW/2;
    loginbtn.centerY = 75 + 20;
    loginbtn.titleLabel.font = [UIFont systemFontOfSize:12 weight:10];
    loginbtn.backgroundColor = [UIColor whiteColor];
    [loginbtn setTitle:@"登陆" forState:UIControlStateNormal];
    [loginbtn setTitleColor:mainColor forState:UIControlStateNormal];
    loginbtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [loginbtn addTarget:self action:@selector(tapLogin) forControlEvents:UIControlEventTouchUpInside];
    
    tip = [[UILabel alloc]initWithFrame:CGRectMake(0, loginbtn.y + 34 , 200, 24)];
    tip.centerX = MainW/2;
    tip.font = [UIFont systemFontOfSize:10];
    tip.text = @"(´•༝• `)~~用shopping,方便快捷，省钱省心.";
    tip.textAlignment =NSTextAlignmentCenter;
    
    tipLab = [[UILabel alloc]initWithFrame:CGRectMake(84, 20, MainW - 64, 54)];
    tipLab.font = [UIFont systemFontOfSize:12];
    tipLab.textColor = RGB(131, 175, 155);
    tipLab.hidden = YES;
    
    [topView addSubview:tipLab];
    [topView addSubview:userIcon];
    [topView addSubview:tip];
    [topView addSubview:loginbtn];
    [scroll addSubview:topView];
    
    offBtn = [[UIButton alloc]initWithFrame:CGRectMake(MainW - 40, 20, 40, 20)];
    [offBtn setTitle:@"注销" forState:UIControlStateNormal];
    [offBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [offBtn addTarget:self action:@selector(clearing) forControlEvents:UIControlEventTouchUpInside];
    offBtn.titleLabel.font =[UIFont systemFontOfSize:12 weight:4];
    offBtn.hidden = YES;
    [topView addSubview:offBtn];
    
    UIImageView *imgView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 150, MainW, 261)];
    imgView1.contentMode = UIViewContentModeScaleAspectFit;
    [imgView1 setImage:[UIImage imageNamed:@"me.jpeg"]];
    imgView1.backgroundColor = [UIColor redColor];
    [scroll addSubview:imgView1];
    
    UIImageView *imgView2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 150 +261, MainW, 220)];
    imgView2.contentMode = UIViewContentModeScaleAspectFit;
    [imgView2 setImage:[UIImage imageNamed:@"me2.jpeg"]];
    imgView2.backgroundColor = [UIColor redColor];
    [scroll addSubview:imgView2];
    
    oderBtn = [[UIButton alloc]initWithFrame:CGRectMake(MainW- 80, 160, 80, 20)];
    [oderBtn addTarget:self action:@selector(tapOder) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:oderBtn];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    if ([AppDataSource sharedDataSource].isLogin) {
        loginbtn.hidden = YES;
        userIcon.hidden = NO;
        tipLab.text = [NSString stringWithFormat:@"欢迎%@",[AppDataSource sharedDataSource].userName];
        tipLab.hidden = NO;
        tip.y = loginbtn.y ;
        offBtn.hidden = NO;
        
    }else{
        loginbtn.hidden = NO;
        userIcon.hidden = YES;
        tipLab.hidden = YES;
        tip.y = loginbtn.y + 34;
        offBtn.hidden = YES;
    }
    

}


- (void)createData
{
    //初始化pickerController
    pickerController = [[UIImagePickerController alloc]init];
    pickerController.view.backgroundColor = [UIColor whiteColor];
    pickerController.delegate = self;
    pickerController.allowsEditing = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma  mark --action

- (void)tapLogin{
    
    [self.navigationController pushViewController:[[LoginViewController alloc]init] animated:YES];

}

- (void)clearing{
    
    UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确定要退出登录吗？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    alter.tag = 66;
    [alter show];
    
    
   
    
}

- (void)tapSelectIcon{
    
    UIAlertAction  *action1 = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self makePhoto];
    }];
    UIAlertAction  *action2 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self choosePicture];

    }];
    
    UIAlertAction  *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
    }];
    
    UIAlertController *alter = [[UIAlertController alloc]init];
    [alter addAction:action1];
    [alter addAction:action2];
    
    [alter addAction:action3];
    
    [self presentViewController:alter animated:YES completion:^{
        
    }];

}

//跳转到imagePicker里
- (void)makePhoto
{
    pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:pickerController animated:YES completion:nil];
}
//跳转到相册
- (void)choosePicture
{
    pickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentViewController:pickerController animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    NSLog(@"%s,info == %@",__func__,info);
    
    UIImage *userImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    
    userImage = [self scaleImage:userImage toScale:0.3];
    
    //保存图片
        [self saveImage:userImage name:@"icon"];
    
    [pickerController dismissViewControllerAnimated:YES completion:^{
        
        
    }];
    [userIcon setImage:userImage forState:UIControlStateNormal];
    [userIcon setImage:userImage forState:UIControlStateHighlighted];
    userIcon.contentMode = UIViewContentModeScaleAspectFill;
   

}
//保存照片到沙盒路径(保存)
- (void)saveImage:(UIImage *)image name:(NSString *)iconName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    //写入文件
    NSString *icomImage = iconName;
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", icomImage]];
    
    
    
    BOOL blHave=[[NSFileManager defaultManager]fileExistsAtPath:filePath];
    if(blHave){
        NSLog(@"alreadyhave");
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
        return;
    }
    // 保存文件的名称
    //    [[self getDataByImage:image] writeToFile:filePath atomically:YES];
    [UIImagePNGRepresentation(image)writeToFile: filePath  atomically:YES];
}

//缩放图片
- (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width*scaleSize,image.size.height*scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height *scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSLog(@"%@",NSStringFromCGSize(scaledImage.size));
    return scaledImage;
}

- (void)tapOder{
    [self.navigationController pushViewController:[[OderViewController alloc]init] animated:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 66) {
        if (buttonIndex == 0) {
            [[AppDataSource sharedDataSource] clearDatas];
            loginbtn.hidden = NO;
            userIcon.hidden = YES;
            tipLab.hidden = YES;
            tip.y = loginbtn.y + 34;
            offBtn.hidden = YES;
        }
    }
}

//修正照片方向(手机转90度方向拍照)
- (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

@end
