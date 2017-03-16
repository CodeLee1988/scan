//
//  ViewController.m
//  扫描二维码
//
//  Created by 蔡强 on 2017/3/16.
//  Copyright © 2017年 kuaijiankang. All rights reserved.
//

#import "ViewController.h"
#import <QRCodeReaderViewController.h>
#import <SVProgressHUD.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 扫描button
    UIButton *scanButton = [[UIButton alloc]initWithFrame:CGRectMake(90, 190, 200, 30)];
    [self.view addSubview:scanButton];
    [scanButton setTitle:@"扫描二维码" forState:UIControlStateNormal];
    [scanButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [scanButton addTarget:self action:@selector(scan) forControlEvents:UIControlEventTouchDown];
}

#pragma mark - 扫描二维码
/** 扫描二维码 */
- (void)scan{
    // Create the reader object
    QRCodeReader *reader = [QRCodeReader readerWithMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    
    // Instantiate the view controller
    QRCodeReaderViewController *vc = [QRCodeReaderViewController readerWithCancelButtonTitle:@"取消" codeReader:reader startScanningAtLoad:YES showSwitchCameraButton:YES showTorchButton:YES];
    
    // Set the presentation style
    vc.modalPresentationStyle = UIModalPresentationPopover;
    
    // Define the delegate receiver
    vc.delegate = (id)self;
    
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - 二维码扫描相关代理方法
// 扫描成功
- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result
{
    [reader stopScanning]; // 停止扫描
    [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"扫描结果：%@",result]];
}

// 取消扫描
- (void)readerDidCancel:(QRCodeReaderViewController *)reader
{
    [reader dismissViewControllerAnimated:YES completion:^{
        [SVProgressHUD showInfoWithStatus:@"取消扫描"];
    }];
}


@end
