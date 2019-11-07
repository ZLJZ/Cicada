//
//  TakePhotoViewController.m
//  Cicada
//
//  Created by 张琦 on 2017/3/8.
//  Copyright © 2017年 com. All rights reserved.
//

#import "TakePhotoViewController.h"
#import "IJKMediaFramework.h"
@interface TakePhotoViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic ,assign) BOOL  isFront;

@end

@implementation TakePhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = COLOR_BACK;
    [self createUI];
}

- (void)createUI {
    NSArray *imageArr = @[@"IDzhengmian",@"IDbeimian"];
    for (NSInteger i = 0; i < 2; i ++ ) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - 493/2)/2, 64 + 20 + (307/2 + 50) * i, 493/2, 307/2)];
//        imageView.contentMode = UIViewContentModeCenter;
        imageView.contentMode = UIViewContentModeScaleAspectFit;

        [imageView setImage:[UIImage imageNamed:imageArr[i]]];
        imageView.tag = 200 + i;
        [self.view addSubview:imageView];
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(takePhoto:)];
        [imageView addGestureRecognizer:tap];
    }
}

#pragma mark -- 拍照 --
- (void)takePhoto:(UITapGestureRecognizer *)tap {
    UIAlertController *alertController;
    alertController = [[UIAlertController alloc]init];
    
//    alertController = [UIAlertController alertControllerWithTitle:@"选择" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
//    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:@"选择"];
//    [attributedString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} range:NSMakeRange(0, attributedString.length)];
//    [alertController setValue:attributedString forKey:@"attributedTitle"];
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.delegate = self;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imagePickerController animated:YES completion:nil];

        }];
        [alertController addAction:cameraAction];//添加相机action
        [cameraAction setValue:COLOR_YELLOW forKey:@"_titleTextColor"];//修改字体颜色
     }
    UIAlertAction *photoAlbumAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }];
     UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//         [alertController dismissViewControllerAnimated:YES completion:nil];
     }];
    [alertController addAction:photoAlbumAction];//添加相册action
    [alertController addAction:cancelAction];//添加取消action
    [photoAlbumAction setValue:COLOR_YELLOW forKey:@"_titleTextColor"];
    [cancelAction setValue:COLOR_YELLOW forKey:@"_titleTextColor"];

    [self presentViewController:alertController animated:YES completion:nil];
    
    
    
    UIImageView *imageView = (UIImageView *)tap.view;
    if (imageView.tag == 200) {
        _isFront = YES;
    } else if (imageView.tag == 201) {
        _isFront = NO;
    }
    
}


#pragma mark -- UIImagePickerControllerDelegate --
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    UIImageView *imageView;
    if (_isFront) {
        imageView = (UIImageView *)[self.view viewWithTag:200];
    } else {
        imageView = (UIImageView *)[self.view viewWithTag:201];
    }
    if (image.size.width < image.size.height) {
        //transform是作用在imageView上的
//        imageView.transform = CGAffineTransformMakeRotation(M_PI/2);
        image = [UIImage imageWithCGImage:image.CGImage scale:1 orientation:UIImageOrientationLeft];
        
    }
    
//    imageView.image = [TakePhotoViewController scaleImageWithOriginalImage:image scaleSize:CGSizeMake(493/2, 307/2)];
    imageView.image = image;

}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

+ (UIImage *)scaleImageWithOriginalImage:(UIImage *)image scaleSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaleImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaleImage;
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

/**
 
 UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"提示内容" preferredStyle:UIAlertControllerStyleAlert];

 //修改标题的内容，字号，颜色。使用的key值是“attributedTitle”
 NSMutableAttributedString *hogan = [[NSMutableAttributedString alloc] initWithString:@"heihei"];
 [hogan addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:50] range:NSMakeRange(0, [[hogan string] length])];
 [hogan addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, [[hogan string] length])];
 [alertController setValue:hogan forKey:@"attributedTitle"];
 
 //修改按钮的颜色，同上可以使用同样的方法修改内容，样式
 UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Default" style:UIAlertActionStyleDefault handler:nil];
 [defaultAction setValue:[UIColor blueColor] forKey:@"_titleTextColor"];
 
 UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
 
 [cancelAction setValue:[UIColor greenColor] forKey:@"_titleTextColor"];
 
 [alertController addAction:defaultAction];
 [alertController addAction:cancelAction];

 */



/**
 ********利用递归方法********
 //写一个递归找到message的ParentView;
 UIView *messageParentView = [self getParentViewOfTitleAndMessageFromView:alertController.view];
 if (messageParentView && messageParentView.subviews.count > 1) {
 UILabel *messageLb = messageParentView.subviews[1];
 messageLb.textAlignment = NSTextAlignmentLeft;
 }
 
 //递归方法
 - (UIView *)getParentViewOfTitleAndMessageFromView:(UIView *)view {
 for (UIView *subView in view.subviews) {
 if ([subView isKindOfClass:[UILabel class]]) {
 return view;
 }else{
 UIView *resultV = [self getParentViewOfTitleAndMessageFromView:subView];
 if (resultV) return resultV;
 }
 }
 return nil;
 }
 */

@end
