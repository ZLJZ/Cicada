//
//  IJKCaptureViewController.m
//  Cicada
//
//  Created by 张琦 on 2017/6/2.
//  Copyright © 2017年 com. All rights reserved.
//

#import "IJKCaptureViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface IJKCaptureViewController ()<AVCaptureVideoDataOutputSampleBufferDelegate,AVCaptureAudioDataOutputSampleBufferDelegate>

@property (nonatomic, strong) AVCaptureSession *captureSession;

@property (nonatomic, strong) AVCaptureDeviceInput *currentVideoDeviceInput;

@property (nonatomic, weak) AVCaptureConnection *videoConnection;
@property (nonatomic, weak) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic, weak) UIImageView *focusCursorImageView;

@property (nonatomic, strong) UIButton *cameraButton;

@end

@implementation IJKCaptureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"采集";
    [self captureVideo];
    [self cameraButton];
}

- (UIImageView *)focusCursorImageView {
    if (!_focusCursorImageView) {
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"focus"]];
        _focusCursorImageView = imageView;
        [self.view addSubview:_focusCursorImageView];
    }
    return _focusCursorImageView;
    
}

- (UIButton *)cameraButton {
    if (!_cameraButton) {
        _cameraButton = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth - 120 - 20 , 60, 120, 40)];
        [_cameraButton setTitle:@"切换摄像头" forState:UIControlStateNormal];
        [_cameraButton setTitleColor:COLOR_DARKGRAY forState:UIControlStateNormal];
        [_cameraButton addTarget:self action:@selector(clickCameraButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view insertSubview:_cameraButton atIndex:10000];
    }
    return _cameraButton;
}

- (void)clickCameraButton:(UIButton *)sender {
    AVCaptureDevicePosition currentPosition = _currentVideoDeviceInput.device.position;
    AVCaptureDevicePosition togglePosition = currentPosition == AVCaptureDevicePositionFront ? AVCaptureDevicePositionBack : AVCaptureDevicePositionFront;
    AVCaptureDevice *toggleDevice = [self getVideoDevice:togglePosition];
    AVCaptureDeviceInput *toggleDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:toggleDevice error:nil];
    [_captureSession removeInput:_currentVideoDeviceInput];
    [_captureSession addInput:toggleDeviceInput];
    _currentVideoDeviceInput = toggleDeviceInput;
}

- (void)captureVideo {
    //1.创建捕获会话，必须要强引用，否则会被释放
    AVCaptureSession *captureSession = [[AVCaptureSession alloc]init];
    _captureSession = captureSession;
    //获取摄像头设备
    AVCaptureDevice *videoDevice = [self getVideoDevice:AVCaptureDevicePositionFront];
    //获取声音设备
    AVCaptureDevice *audioDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    //创建对应视频设备输入对象
    AVCaptureDeviceInput *videoDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:nil];
    _currentVideoDeviceInput = videoDeviceInput;
    //创建对应音频设备输入对象
    AVCaptureDeviceInput *audioDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:audioDevice error:nil];
    //添加到会话中（最好判断一下是否能添加输入，会话不能添加空的）
    //添加视频
    if ([captureSession canAddInput:videoDeviceInput]) {
        [captureSession addInput:videoDeviceInput];
    }
    //添加音频
    if ([captureSession canAddInput:audioDeviceInput]) {
        [captureSession addInput:audioDeviceInput];
    }
    
    AVCaptureVideoDataOutput *videoOutput = [[AVCaptureVideoDataOutput alloc]init];
    //队列必须是串行队列，才能获取到数据
    dispatch_queue_t videoQueue = dispatch_queue_create("video capture queue", DISPATCH_QUEUE_SERIAL);
    [videoOutput setSampleBufferDelegate:self queue:videoQueue];
    if ([captureSession canAddOutput:videoOutput]) {
        [captureSession addOutput:videoOutput];
    }
    
    AVCaptureAudioDataOutput *audioOutput = [[AVCaptureAudioDataOutput alloc]init];
    dispatch_queue_t audioQueue = dispatch_queue_create("audio capture queue", DISPATCH_QUEUE_SERIAL);
    [audioOutput setSampleBufferDelegate:self queue:audioQueue];
    if ([captureSession canAddOutput:audioOutput]) {
        [captureSession addOutput:audioOutput];
    }
    
    _videoConnection = [videoOutput connectionWithMediaType:AVMediaTypeVideo];
    
    AVCaptureVideoPreviewLayer *previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:captureSession];
    previewLayer.frame = [UIScreen mainScreen].bounds;
    [self.view.layer addSublayer:previewLayer];
    _previewLayer = previewLayer;
    
    [captureSession startRunning];
    
    
    
    
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    if (connection == _videoConnection) {
        NSLog(@"获取到视频数据");
    } else {
        NSLog(@"获取到音频数据");
    }
}

-(AVCaptureDevice *)getVideoDevice:(AVCaptureDevicePosition)position {
    
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for( AVCaptureDevice *device in devices) {
        if (device .position == position) {
            return device;
        }
    }
    return nil;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    CGPoint cameraPoint = [_previewLayer captureDevicePointOfInterestForPoint:point];
    [self setFocusCursorPoint:point];
    [self focusMode:AVCaptureFocusModeAutoFocus exposureMode:AVCaptureExposureModeAutoExpose atPoint:cameraPoint];
}

- (void)setFocusCursorPoint:(CGPoint)point {
    self.focusCursorImageView.center = point;
    self.focusCursorImageView.transform = CGAffineTransformMakeScale(1.5, 1.5);
    self.focusCursorImageView.alpha = 1.0;
    [UIView animateWithDuration:1.0 animations:^{
        self.focusCursorImageView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        self.focusCursorImageView.alpha = 0;
    }];
}

- (void)focusMode:(AVCaptureFocusMode)focusMode exposureMode:(AVCaptureExposureMode)exposureMode atPoint:(CGPoint)point {
    AVCaptureDevice *device = _currentVideoDeviceInput.device;
    //锁定配置
    [device lockForConfiguration:nil];
    //设置聚焦
    if ([device isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
        [device setFocusMode:AVCaptureFocusModeAutoFocus];
    }
    
    if ([device isFocusPointOfInterestSupported]) {
        [device setFocusPointOfInterest:point];
    }
    
    //设置曝光
    if ([device isExposureModeSupported:AVCaptureExposureModeAutoExpose]) {
        [device
         setExposureMode:AVCaptureExposureModeAutoExpose];
    }
    
    if ([device isExposurePointOfInterestSupported]) {
        [device setExposurePointOfInterest:point];
    }
    
    //解锁配置
    [device unlockForConfiguration];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
