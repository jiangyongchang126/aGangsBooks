//
//  BaseViewController.m
//  aGangBooks
//
//  Created by 蒋永昌 on 16/6/6.
//  Copyright © 2016年 蒋永昌. All rights reserved.
//

#import "BaseViewController.h"
#import <AudioToolbox/AudioToolbox.h>


SystemSoundID sound;

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self addSubviews];
    
    [self updateAL];
    
    
    [self performSelector:@selector(loadData) withObject:nil afterDelay:.1];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([NSStringFromClass([self class]) isEqualToString:@"MainViewController"] ||
        [NSStringFromClass([self class]) isEqualToString:@"MineViewController"]
        ) {
        
        self.navigationController.navigationBarHidden = YES;
    }
    else
        self.navigationController.navigationBarHidden = NO;
}

- (void)addSubviews
{
    UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
    [self.view addSubview:bgView];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view);
    }];
}

- (void)updateAL
{
    
}

- (void)loadData
{
    
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

// 截屏
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    //    if (![[LSUserTool read].motion_on boolValue]) return;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(k_width, k_height), YES, 0);
    [[self.view layer] renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRef imageRef = image.CGImage;
    CGRect rect = CGRectMake(0, 0, k_width*2, k_height*2);
    CGImageRef imageRefRect = CGImageCreateWithImageInRect(imageRef, rect);
    UIImage *sendImage = [[UIImage alloc] initWithCGImage:imageRefRect];
    UIImageWriteToSavedPhotosAlbum(sendImage, nil, nil, nil);
    
    NSString *path = [NSString stringWithFormat:@"/System/Library/Audio/UISounds/photoShutter.caf"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &sound);
    AudioServicesPlaySystemSound(sound);
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, k_width, 2)];
    view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:view];
    UIView *view_button = [[UIView alloc] initWithFrame:CGRectMake(0, k_height - 2, k_width, 2)];
    view_button.backgroundColor =[UIColor whiteColor];
    
    [self.view addSubview:view_button];
    [UIView animateWithDuration:0.3 animations:^{
        view.height = k_height/2;
        view_button.height = k_height/2;
        view_button.originY = k_height/2+2;
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [view_button removeFromSuperview];
        [view removeFromSuperview];
    });
    //    NSData *imageViewData = UIImagePNGRepresentation(sendImage);
    //
    //    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //    NSString *documentsDirectory = [paths objectAtIndex:0];
    //    NSString *pictureName= [NSString stringWithFormat:@"screenShow_%d.png",1];
    //    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:pictureName];
    //    [imageViewData writeToFile:savedImagePath atomically:YES];
    //    NSLog(@"截屏路径打印: %@", savedImagePath);
    NSLog(@"---begin");
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

@end
