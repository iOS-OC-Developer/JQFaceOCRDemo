# JQHttpRequest
前言
===
 JQHttpRequest:目前二次封装网络库支持四种请求：GET、POST、PUT、DELETE较常见的请求，HEAD/PATH/COPY/OPTIONS/LINK/LOCK等不常用的后续会根据需求调整,本库支持数据缓存、缓存超时设置、请求超时设置等;支持cer证书验证等;
 
## Installation

#### From CocoaPods

```
pod  "JQHttpRequest"
```

#### Manually 
- Drag all source files under floder `JQHttpRequest` to your project.

## Usage
```
///Test
    [[JQBaseRequest sharedManager].setRequest(COLLECTION_LIST).RequestType(JQRequestMethodGET).Cachetype(JQBaseRequestReloadIgnoringLocalCacheData).cerName(nil).timeoutInterval(30).CachTime(60).Parameters(nil) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        
    } progress:^(NSProgress *progress) {
        
    /* NSProgress 不能为nil，因为AFN的默认参数是 _Nonnull 修饰的！*/
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];

```
- 参数说明：

```
setRequest:  请求url
RequestType: 
             请求类型：
             JQRequestMethodGET = 0,
             JQRequestMethodPOST,
             JQRequestMethodPUT,
             JQRequestMethodDELETE 目前支持四种,会持续更新;
-------------------------------------------------------------------------
Cachetype: 缓存类型：
JQBaseRequestReturnCacheDataThenLoad = 0,  ///< 有缓存就先返回缓存，同步请求数据
JQBaseRequestReloadIgnoringLocalCacheData, ///< 忽略缓存，重新请求
JQBaseRequestReturnCacheDataElseLoad,      ///< 有缓存就用缓存，没有缓存就重新请求(用于数据不变时)
JQBaseRequestReturnCacheDataDontLoad,      ///< 有缓存就用缓存，没有缓存就不发请求，当做请求出错处理（用于离线模式）

cerName: cer证书名称,设置则开启验证,默认不开启,若设置请确保名称正确，否则导致crash;

timeoutInterval: 请求超时设置 默认20s
CachTime:        设置缓存时间 默认时间一天
Parameters:      参数设置 字典传输

          
```
- startRequestWithSuccess: 请求函数，提供三个,如下：

```
/**
 *  发送请求
 *
 *  @param Success  成功的回调
 *  @param Progress 进度的回调
 *  @param Fail     请求错误的回调
 */
- (void)startRequestWithSuccess:(JQResponseSuccess)Success progress:(JQProgress)Progress failure:(JQResponseFail)Fail;
/**
 *  上传文件
 *
 *  @param Success  成功的回调
 *  @param Progress 进度的回调
 *  @param Fail     请求错误的
 */
- (void)uploadfileWithSuccess:(JQResponseSuccess)Success progress:(JQProgress)Progress failure:(JQResponseFail)Fail;
/**
 *  下载文件
 *
 *  @param Success  成功的回调
 *  @param Progress 进度的回调
 *  @param Fail     请求错误的
 *  @return 返回NSURLSessionDownloadTask实例，可用于暂停继续，暂停调用suspend方法，重新开启下载调用resume方法
 */
- (NSURLSessionDownloadTask *)downloadWithSuccess:(JQFileSuccess)Success progress:(JQProgress)Progress failure:(JQResponseFail)Fail;
```
## Note

![](https://github.com/xiaohange/JQHttpRequest/blob/master/fail.png?raw=true)

`progress:^(NSProgress *progress)`不能为nil，因为AFN的默认参数是 _Nonnull 修饰的！

- 正确姿势：

![](https://github.com/xiaohange/JQHttpRequest/blob/master/success.png?raw=true)


## Other
[JQTumblrHud-高仿Tumblr App 加载指示器hud](https://github.com/xiaohange/JQTumblrHud)

[JQScrollNumberLabel：仿tumblr热度滚动数字条数](https://github.com/xiaohange/JQScrollNumberLabel)

[TumblrLikeAnimView-仿Tumblr点赞动画效果](https://github.com/xiaohange/TumblrLikeAnimView)

[JQMenuPopView-仿Tumblr弹出视图发音频、视频、图片、文字的视图](https://github.com/xiaohange/JQMenuPopView)

## Star

[CSDN博客](http://blog.csdn.net/qq_31810357)    [新浪微博](http://weibo.com/hanjunqiang) 

iOS开发者交流群：446310206 喜欢就❤️❤️❤️star一下吧！你的支持是我更新的动力！ Love is every every every star! Your support is my renewed motivation!


## License

This code is distributed under the terms and conditions of the [MIT license](LICENSE).