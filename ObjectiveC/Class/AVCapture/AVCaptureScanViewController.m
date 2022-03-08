//
//  AVCaptureScanViewController.m
//  ObjectiveC
//
//  Created by zhangchunpeng1 on 2021/7/8.
//  Copyright © 2021 张春鹏. All rights reserved.
//

#import "AVCaptureScanViewController.h"

#import <AVFoundation/AVFoundation.h>

#import "ImageShowViewController.h"


#define SelfWidth CGRectGetWidth(UIScreen.mainScreen.bounds)
#define SelfHeight CGRectGetHeight(UIScreen.mainScreen.bounds)

@interface AVCaptureScanViewController ()<AVCapturePhotoCaptureDelegate>
// <AVCaptureMetadataOutputObjectsDelegate, AVCaptureVideoDataOutputSampleBufferDelegate>

@property (nonatomic, strong) UIButton *takePhotoButton;           ///< takePhoto

@property (nonatomic, strong) AVCaptureSession* session;
@property (nonatomic, strong) AVCaptureDeviceInput* videoInput;
@property (nonatomic, strong) AVCapturePhotoOutput* stillImageOutput;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer* previewLayer;
@property (nonatomic, strong) UIView *backView;

@property (nonatomic, assign) CGRect showBounds;           ///< rect

@end

@implementation AVCaptureScanViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if(self.session){
        [self.session startRunning];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if(self.session){
        [self.session stopRunning];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:true animated:false];
    
    _showBounds = CGRectMake(50, 150, SelfWidth - 100, (SelfWidth - 100 ) * 0.75);
    
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusAuthorized || status == AVAuthorizationStatusRestricted) {
        [self initView];
    } else if (status == AVAuthorizationStatusNotDetermined) {
        // 请求使用相机权限
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self initView];
                });
            } else {
//                [[XIAlertView alertWithTitle:@"无权限访问相机" message:@"无权限访问相机" cancelButtonTitle:@"OK"] show];
            }
        }];
    } else {
//        [[XIAlertView alertWithTitle:@"无权限访问相机" message:@"无权限访问相机" cancelButtonTitle:@"OK"] show];
    }
    
}

- (void)takePhotoAction {
    AVCapturePhotoSettings *set = [AVCapturePhotoSettings photoSettings];
    [self.stillImageOutput capturePhotoWithSettings:set delegate:self];
}

- (void)initView {
    self.view.backgroundColor = [UIColor blackColor];
    
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SelfWidth, SelfHeight)];
    [self.view addSubview:self.backView];
    
    CALayer *Mylayer=[CALayer layer];
    Mylayer.frame = self.showBounds;
    Mylayer.masksToBounds=YES;
    Mylayer.borderWidth=1;
    Mylayer.borderColor=[UIColor whiteColor].CGColor;
    [self.view.layer addSublayer:Mylayer];
    
    [self initAVCaptureSession]; //设置相机属性
    
    _takePhotoButton = [[UIButton alloc] initWithFrame:CGRectMake(100, UIScreen.mainScreen.bounds.size.height - 150, CGRectGetWidth(UIScreen.mainScreen.bounds) - 200, 50)];
    [_takePhotoButton setTitle:@"拍照" forState:UIControlStateNormal];
    [_takePhotoButton addTarget:self action:@selector(takePhotoAction) forControlEvents:UIControlEventTouchUpInside];
    [_takePhotoButton setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:_takePhotoButton];
}

- (void)initAVCaptureSession {
    
    self.session = [[AVCaptureSession alloc] init];
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    
    NSError *error;
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    self.videoInput = [[AVCaptureDeviceInput alloc] initWithDevice:device error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
    AVCaptureVideoDataOutput *captureOutput = [[AVCaptureVideoDataOutput alloc] init];
    
    self.stillImageOutput = [[AVCapturePhotoOutput alloc] init];
    
    if ([self.session canAddInput:self.videoInput]) {
        [self.session addInput:self.videoInput];
    }
    if ([self.session canAddOutput:captureOutput]) {
        [self.session addOutput:captureOutput];
    }
    if ([self.session canAddOutput:self.stillImageOutput]) {
        [self.session addOutput:self.stillImageOutput];
    }
    
    //初始化预览图层
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    [self.previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    self.previewLayer.frame = self.view.bounds;
    self.backView.layer.masksToBounds = YES;
    [self.backView.layer addSublayer:self.previewLayer];
}

- (void)captureOutput:(AVCapturePhotoOutput *)output didFinishProcessingPhoto:(AVCapturePhoto *)photo error:(NSError *)error  API_AVAILABLE(ios(11.0)) {
    if (!error) {
        // 使用该方式获取图片，可能图片会存在旋转问题，在使用的时候调整图片即可
        NSData *data = [photo fileDataRepresentation];
        UIImage *image = [UIImage imageWithData:data];
        
        [self saveImage:image];
    }
}

- (void)captureOutput:(AVCapturePhotoOutput *)output didFinishProcessingPhotoSampleBuffer:(nullable CMSampleBufferRef)photoSampleBuffer previewPhotoSampleBuffer:(nullable CMSampleBufferRef)previewPhotoSampleBuffer resolvedSettings:(AVCaptureResolvedPhotoSettings *)resolvedSettings bracketSettings:(nullable AVCaptureBracketedStillImageSettings *)bracketSettings error:(nullable NSError *)error {
    
    NSData *data = [AVCapturePhotoOutput JPEGPhotoDataRepresentationForJPEGSampleBuffer:photoSampleBuffer previewPhotoSampleBuffer:previewPhotoSampleBuffer];
    UIImage *image = [[UIImage alloc] initWithData:data];
    
    
    [self saveImage:image];
    
//    ImageShowViewController *vc = [[ImageShowViewController alloc] init];
//    vc.image = image;
//    [self.navigationController pushViewController:vc animated:true];
}


- (void)saveImage: (UIImage *)image {
    CGRect fullRect = CGRectMake(0, 0, CGRectGetWidth(UIScreen.mainScreen.bounds), rint(CGRectGetWidth(UIScreen.mainScreen.bounds) * 16 / 9));
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:fullRect];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = image;
    UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, 0);
    [imageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    // 确保图片比例与显示时一致
    UIImage *scaleImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGFloat scale = UIScreen.mainScreen.scale;

    // 确保位置准确，需要乘以屏幕倍数
    CGFloat y = rint(CGRectGetMinY(_showBounds) * CGRectGetHeight(fullRect) /  CGRectGetHeight(UIScreen.mainScreen.bounds));
    CGRect rect = CGRectMake(CGRectGetMinX(_showBounds) * scale, y * scale, CGRectGetWidth(_showBounds) * scale, CGRectGetHeight(_showBounds) * scale);
    
    
    CGImageRef cgResule = CGImageCreateWithImageInRect(scaleImage.CGImage, rect);
    UIImage *result = [UIImage imageWithCGImage:cgResule];
    CGImageRelease(cgResule);
    
    ImageShowViewController *vc = [[ImageShowViewController alloc] init];
    vc.showBounds = _showBounds;
//    vc.image = result;
    vc.image = image;
    [self.navigationController pushViewController:vc animated:true];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        UIImageWriteToSavedPhotosAlbum(result, nil, nil, nil);
        
        
        ImageShowViewController *vc = [[ImageShowViewController alloc] init];
        vc.showBounds = self.showBounds;
        vc.image = result;
        [self.navigationController pushViewController:vc animated:true];
        
    });
    
}



@end
