//
//  JQUploadPicRequest.h
//  JQFaceOCRDemo
//
//  Created by 韩俊强 on 2017/7/4.
//  Copyright © 2017年 HaRi. All rights reserved.
//

#import <JQBaseRequest.h>

@interface JQUploadPicRequest : JQBaseRequest

+ (void)requestToUploadImage:(UIImage*)image parmete:(NSMutableDictionary *)parameteDic completion:(void(^)(NSDictionary * responDic,NSError*error))complete;

@end
