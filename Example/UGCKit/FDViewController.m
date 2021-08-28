//
//  FDViewController.m
//  UGCKit
//
//  Created by fandongtongxue on 08/28/2021.
//  Copyright (c) 2021 fandongtongxue. All rights reserved.
//

#import "FDViewController.h"
#import <UGCKit/UGCKit.h>

@interface FDViewController ()

@end

@implementation FDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    UGCKitTheme *theme = [[UGCKitTheme alloc] init];
    
    UGCKitRecordConfig *config = [[UGCKitRecordConfig alloc] init];
    UGCKitWatermark *watermark = [[UGCKitWatermark alloc] init];
    watermark.image = [UIImage imageNamed:@"watermark"];
    watermark.frame = CGRectMake(0.01, 0.01, 0.1, 0.3);
    config.watermark = watermark;
    
    UGCKitRecordViewController *videoRecord = [[UGCKitRecordViewController alloc] initWithConfig:config theme:theme];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:videoRecord];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    __weak UINavigationController *weakNav = nav;
    __weak __typeof(self) wself = self;
    videoRecord.completion = ^(UGCKitResult *result) {
        if (result.code == 0 && !result.cancelled) {
            UGCKitMedia *media = result.media;
            UGCKitEditConfig *config = [[UGCKitEditConfig alloc] init];
//            config.rotation = (TCEditRotation)(rotation / 90);

//            UIImage *tailWatermarkImage = [UIImage imageNamed:@"tcloud_logo"];
//            TXVideoInfo *info = [TXVideoInfoReader getVideoInfoWithAsset:media.videoAsset];
//            float w = 0.15;
//            float x = (1.0 - w) / 2.0;
//            float width = w * info.width;
//            float height = width * tailWatermarkImage.size.height / tailWatermarkImage.size.width;
//            float y = (info.height - height) / 2 / info.height;
//            config.tailWatermark = [UGCKitWatermark watermarkWithImage:tailWatermarkImage
//                                                             frame:CGRectMake(x, y, w, 0)
//                                                          duration:2];
            __weak __typeof(self) wself = self;
            UGCKitEditViewController *vc = [[UGCKitEditViewController alloc] initWithMedia:media
                                                                                    config:config
                                                                                     theme:theme];
            __weak UGCKitEditViewController *weakEditController = vc;
            __weak UINavigationController *weakNavigation = nav;
            vc.onTapNextButton = ^(void (^finish)(BOOL)) {
                __weak __typeof(self) wself = self;
                UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil
                                                                                    message:nil
                                                                             preferredStyle:UIAlertControllerStyleActionSheet];
                [controller addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Common.Save", nil)
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * _Nonnull action) {
                    __strong __typeof(wself) self = wself; if (!self) return;
                    NSLog(@"点击了保存");
                }]];
                [controller addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Common.Release", nil)
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * _Nonnull action) {
                    __strong __typeof(wself) self = wself; if (!self) return;
                    NSLog(@"点击了发布");
                }]];
                [controller addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Common.Cancel", nil)
                                                               style:UIAlertActionStyleCancel
                                                             handler:^(UIAlertAction * _Nonnull action) {
                    finish(NO);
                }]];
                [weakEditController presentViewController:controller animated:YES completion:nil];
            };

            vc.completion = ^(UGCKitResult *result) {
                __strong __typeof(wself) self = wself; if (self == nil) { return; }
                if (result.cancelled) {
                    NSLog(@"点击了取消");
                } else {
                    NSLog(@"已完成");
                }
                [[NSUserDefaults standardUserDefaults] setObject:nil forKey:CACHE_PATH_LIST];
        //        [self dismissViewControllerAnimated:YES completion:nil];
            };
            [nav pushViewController:vc animated:YES];
        } else {
            [weakNav dismissViewControllerAnimated:YES completion:nil];
        }
    };
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
