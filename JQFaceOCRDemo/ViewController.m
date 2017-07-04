//
//  ViewController.m
//  JQFaceOCRDemo
//
//  Created by 韩俊强 on 2017/7/4.
//  Copyright © 2017年 HaRi. All rights reserved.
//

#import "ViewController.h"
#import <JQHttpRequest/JQBaseRequest.h>
#import "UIImage+GCAdd.h"
#import "JQUploadPicRequest.h"
#import "JQResulltViewController.h"
#import <SVProgressHUD.h>

@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>

@property (strong, nonatomic) UIImagePickerController * picker1;
@property (strong , nonatomic) NSDictionary * infomation;
@property (nonatomic, strong) NSMutableDictionary *parDic;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"JQFaceOCR";
    
    _parDic = [NSMutableDictionary dictionary];
    [_parDic setObject:@"mYiEK5EzegjJP1VNg-4FoTHqFhvaZExQ" forKey:@"api_key"];
    [_parDic setObject:@"ld2rYGcpwRZdrvX-bsJoz_Fow-KKnCz5" forKey:@"api_secret"];
//    [_parDic setObject:@"http://avatar.csdn.net/5/7/E/1_qq_31810357.jpg" forKey:@"image_url"];
    [_parDic setObject:@"0" forKey:@"return_landmark"]; // 检测 83个点返回结果,1检测, 0不检测
    //根据人脸特征判断出的年龄，性别，微笑、人脸质量等属性
    [_parDic setObject:@"gender,age,smiling,headpose,facequality,blur,eyestatus,emotion,ethnicity" forKey:@"return_attributes"]; // 检测属性

}

- (IBAction)starOCRAction:(id)sender
{
    UIImagePickerController * ipc = [[UIImagePickerController alloc]init];
    if ([ipc.navigationBar respondsToSelector:@selector(setBarTintColor:)]) {
        
        [ipc.navigationBar setTranslucent:NO];
        
        [ipc.navigationBar setTintColor:[UIColor blackColor]];
        
    }
    ipc.delegate = self;
    UIAlertController *aVC = [UIAlertController alertControllerWithTitle:nil message:@"请选择图片" preferredStyle:UIAlertControllerStyleActionSheet];

    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            return;
        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
        ipc.allowsEditing = YES;
        [self presentViewController:ipc animated:YES completion:nil];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
            return;
        ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        ipc.allowsEditing = YES;
        ipc.allowsEditing = YES;
        [self presentViewController:ipc animated:YES completion:nil];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [aVC addAction:action1];
    [aVC addAction:action2];
    [aVC addAction:action3];
    [self presentViewController:aVC animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [SVProgressHUD showWithStatus:@"正在识别"];
    _picker1 = picker;
    _picker1.allowsEditing = YES;
    _infomation = info;
    if ((_picker1.sourceType == 1)) { // 相机
        
        [_picker1 dismissViewControllerAnimated:YES completion:nil];
        self.pickImage = _infomation[UIImagePickerControllerEditedImage];
        UIImage * customImage = [self.pickImage imageByResizeToSize:CGSizeMake(400, 400)];
        [JQUploadPicRequest requestToUploadImage:customImage parmete:_parDic completion:^(NSDictionary * responDic, NSError *error) {
            NSLog(@"%@",responDic);
            if ([responDic[@"faces"] count] != 0) {
                [SVProgressHUD showSuccessWithStatus:@"识别成功"];
                JQResulltViewController *rVC = [[JQResulltViewController alloc]init];
                rVC.resultDic = responDic;
                [self.navigationController pushViewController:rVC animated:YES];
            }else{
                [SVProgressHUD showSuccessWithStatus:@"不是面部"];
            }
        }];
    }else if (_picker1.sourceType == 0){ // 相册
        [_picker1 dismissViewControllerAnimated:YES completion:nil];
        self.pickImage = _infomation[UIImagePickerControllerEditedImage];
        UIImage * customImage = (UIImage*)[self.pickImage imageByResizeToSize:CGSizeMake(400, 400)];
        [JQUploadPicRequest requestToUploadImage:customImage parmete:_parDic completion:^(NSDictionary * responDic, NSError *error) {
            NSLog(@"%@",responDic);
            if ([responDic[@"faces"] count] != 0) {
                [SVProgressHUD showSuccessWithStatus:@"识别成功"];
                JQResulltViewController *rVC = [[JQResulltViewController alloc]init];
                rVC.resultDic = responDic;
                [self.navigationController pushViewController:rVC animated:YES];
            }else{
                [SVProgressHUD showSuccessWithStatus:@"不是面部"];
            }
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
