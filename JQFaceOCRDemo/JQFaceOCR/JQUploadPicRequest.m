//
//  JQUploadPicRequest.m
//  JQFaceOCRDemo
//
//  Created by 韩俊强 on 2017/7/4.
//  Copyright © 2017年 HaRi. All rights reserved.
//

#import "JQUploadPicRequest.h"

@implementation JQUploadPicRequest

+ (void)requestToUploadImage:(UIImage*)image parmete:(NSMutableDictionary *)parameteDic completion:(void(^)(NSDictionary * responDic,NSError*error))complete
{
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *imageFilePath = [documentsDirectory stringByAppendingPathComponent:@"selfPhoto.jpg"];
    success = [fileManager fileExistsAtPath:imageFilePath];
    if(success) {
        success = [fileManager removeItemAtPath:imageFilePath error:&error];
    }
    UIImage *smallImage = [self scaleFromImage:image toSize:CGSizeMake(800, 800)];
    [UIImageJPEGRepresentation(smallImage, 1.0f) writeToFile:imageFilePath atomically:YES];
    UIImage *selfPhoto = [UIImage imageWithContentsOfFile:imageFilePath];
    
    NSData * fileData = UIImageJPEGRepresentation(selfPhoto, 0.1);
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString * fileName = [NSString stringWithFormat:@"%@.png",[formatter stringFromDate:[NSDate date]]];
    
    [[JQBaseRequest sharedManager].setRequest(@"https://api-cn.faceplusplus.com/facepp/v3/detect").RequestType(JQRequestMethodGET).Cachetype(JQBaseRequestReloadIgnoringLocalCacheData).timeoutInterval(10).CachTime(60).Parameters(parameteDic).filedata(fileData).filename(fileName).name(@"image_file").mimeType(@"jpg") uploadfileWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        if (complete) {
            complete(responseObject,nil);
        }
    } progress:^(NSProgress *progress) {
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (complete) {
            complete(nil,error);
        }
    }];
}

+ (UIImage *)scaleFromImage: (UIImage *) image toSize: (CGSize) size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
