//
//  STNetUtil.m
//  framework
//
//  Created by 黄成实 on 2018/4/18.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "STNetUtil.h"
#import "RespondModel.h"
#import <MJExtension/MJExtension.h>
#import "AccountManager.h"
#import "STConvertUtil.h"
#import "STObserverManager.h"

@implementation STNetUtil

static AFNetworkReachabilityStatus mStatus = AFNetworkReachabilityStatusUnknown;

#pragma mark get传参
+(void)get:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(RespondModel *))success failure:(void (^)(int))failure{

    if(mStatus == AFNetworkReachabilityStatusNotReachable){
        [STToastUtil showFailureAlertSheet:MSG_NET_ERROR];
        failure(STATU_NONET);
        return;
    }
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 20.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    //header
    UserModel *model =[[AccountManager sharedAccountManager]getUserModel];
    if(!IS_NS_STRING_EMPTY(model.token) && !IS_NS_STRING_EMPTY(model.userUid)){
        [manager.requestSerializer setValue:model.token forHTTPHeaderField:@"token"];
        [manager.requestSerializer setValue:model.userUid forHTTPHeaderField:@"uid"];
    }
    
    //content-type
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/xml",@"text/html", nil ];
   
    //get
    [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleSuccess:responseObject success:success url:url];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handleFail:task.response failure:failure url:url];
    }];
}


#pragma mark post传参
+ (void)post:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(RespondModel *))success failure:(void (^)(int))failure{
    if(mStatus == AFNetworkReachabilityStatusNotReachable){
        [STToastUtil showFailureAlertSheet:MSG_NET_ERROR];
        failure(STATU_NONET);
        return;
    }
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 20.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];

    //header
    UserModel *model =[[AccountManager sharedAccountManager]getUserModel];
    if(!IS_NS_STRING_EMPTY(model.token) && !IS_NS_STRING_EMPTY(model.userUid)){
        [manager.requestSerializer setValue:model.token forHTTPHeaderField:@"token"];
        [manager.requestSerializer setValue:model.userUid forHTTPHeaderField:@"uid"];
    }
    
    //content-type
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/xml",@"text/html", nil ];
    
    //post
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleSuccess:responseObject success:success url:url];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handleFail:task.response failure:failure url:url];
    }];
}

+(void)post:(NSString *)url content:(NSString *)content success:(void (^)(RespondModel *))success failure:(void (^)(int))failure{
    if(mStatus == AFNetworkReachabilityStatusNotReachable){
        [STToastUtil showFailureAlertSheet:MSG_NET_ERROR];
        failure(STATU_NONET);
        return;
    }
    [self post:url content:content success:success failure:failure progress:nil];
}


#pragma mark post传递body
+(void)post:(NSString *)url content:(NSString *)content success:(void (^)(RespondModel *))success failure:(void (^)(int))failure progress:(void (^)(double))progress{
    if(mStatus == AFNetworkReachabilityStatusNotReachable){
        [STToastUtil showFailureAlertSheet:MSG_NET_ERROR];
        failure(STATU_NONET);
        return;
    }
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 20.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    //header
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:nil error:nil];
    UserModel *model =[[AccountManager sharedAccountManager]getUserModel];
    if(!IS_NS_STRING_EMPTY(model.token) && !IS_NS_STRING_EMPTY(model.userUid)){
        [request addValue:model.token forHTTPHeaderField:@"token"];
        [request addValue:model.userUid forHTTPHeaderField:@"uid"];
    }
    
    //content-type
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    //body
    NSData *body  =[content dataUsingEncoding:NSUTF8StringEncoding];
    
    
    [[manager uploadTaskWithRequest:request fromData:body progress:^(NSProgress * _Nonnull uploadProgress) {
        if(progress){
            progress(1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        }
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if(error){
            [self handleFail:response failure:failure url:url];
        }else{
            [self handleSuccess:responseObject success:success url:url];
        }
    }] resume];
}


#pragma mark 上传
//+(void)upload:(UIImage *)image url:(NSString *)url success:(void (^)(RespondModel *))success failure:(void (^)(int))errorCode{
//    if(mStatus == AFNetworkReachabilityStatusNotReachable){
//        [STToastUtil showFailureAlertSheet:MSG_NET_ERROR];
//        failure(STATU_NONET);
//        return;
//    }
//    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
//
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
//    NSData *data = UIImageJPEGRepresentation(image,1.0);
//    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        [formData appendPartWithFileData:data name:@"file" fileName:@"upload.png" mimeType:@"image/png"];
//    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [self handleSuccess:responseObject success:success url:url];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [self handleFail:task.response failure:errorCode url:url];
//  }];
//
//
//}
#pragma mark 下载
//+(void)download : (NSString *)url callback : (ByDownloadCallback) callback{
//    if(mStatus == AFNetworkReachabilityStatusNotReachable){
//        [STToastUtil showFailureAlertSheet:MSG_NET_ERROR];
//        failure(STATU_NONET);
//        return;
//    }
//
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
//
//    NSURL *URL = [NSURL URLWithString:url];
//    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
//
//    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
//        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
//        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
//    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
//        NSLog(@"File downloaded to: %@", filePath);
//    }];
//    [downloadTask resume];
//}


#pragma mark 成功处理
+(void)handleSuccess:(id)responseObject success:(void (^)(RespondModel *))success url:(NSString *)url{
    RespondModel *model = [RespondModel mj_objectWithKeyValues:responseObject];
    model.requestUrl = url;
    dispatch_main_async_safe((^{
        if([model.status isEqualToString:STATU_SUCCESS]){
            if([responseObject isKindOfClass:[NSDictionary class]]){
                NSDictionary *dic = responseObject;
                NSString *jsonStr = [NSString stringWithFormat:@"\n------------------------------------\n***请求成功:%@\n%@\n------------------------------------",url,[dic mj_JSONString]];
                [STLog print:jsonStr];
            }else{
                NSString *jsonStr = [NSString stringWithFormat:@"\n------------------------------------\n***请求成功:%@\n%@\n------------------------------------",url,[STConvertUtil dataToString:responseObject]];
                [STLog print:jsonStr];
            }
            
        }else{
            if([model.status isEqualToString:STATU_INVAILDTOKEN]){
                [[STObserverManager sharedSTObserverManager]sendMessage:Notify_AUTHFAIL msg:nil];
            }
            [self printErrorInfo:model url:url];
        }
        success(model);
    }));
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
}


#pragma mark 失败处理
+(void)handleFail : (NSURLResponse *)response failure:(void (^)(int))failure url:(NSString *)url{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
    NSInteger errorCode = httpResponse.statusCode;
    NSString *errorInfo = @"";
    if(httpResponse == nil){
        errorInfo = @"请在hi1008-5G环境下访问！";
        errorCode = STATU_ERRORURL;
        [STToastUtil showFailureAlertSheet:errorInfo];
    }else{
        errorInfo = [NSString stringWithFormat:@"\n------------------------------------\n***url:%@\n***网络错误码:%ld\n------------------------------------",url,errorCode];
        if(errorCode == STATU_USERAUTH_FAIL || errorCode == STATU_SERVER_FAIL){
            [[STObserverManager sharedSTObserverManager]sendMessage:Notify_AUTHFAIL msg:nil];
        }
    }
    [STLog print:errorInfo];
    dispatch_main_async_safe(^{
        failure((int)errorCode);
    });
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
}


#pragma mark 打印请求错误信息
+(void)printErrorInfo:(RespondModel *)model url:(NSString *)url{
    NSString *body = @"";
    if([model.data isKindOfClass:[NSData class]]){
        body = [STConvertUtil dataToString:model.data];
    }
    if([model.data isKindOfClass:[NSDictionary class]]){
        body = [model.data mj_JSONString];
    }
    NSString *errorInfo = [NSString stringWithFormat:@"\n------------------------------------\n***url:%@ \n***请求错误码:%@ \n***错误信息:%@\n------------------------------------\n%@",url,model.status,model.msg,body];
    
    [STLog print:errorInfo];
}



#pragma mark 监听网络状态
+(void)startListenNetWork:(void (^)(AFNetworkReachabilityStatus))result{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        mStatus = status;
        result(status);
        if (status == AFNetworkReachabilityStatusUnknown) {
            NSLog(@"当前网络：未知网络");
        } else if (status == AFNetworkReachabilityStatusNotReachable) {
            NSLog(@"当前网络：没有网络");
        } else if (status == AFNetworkReachabilityStatusReachableViaWWAN) {
            NSLog(@"当前网络：手机流量");
        } else if (status == AFNetworkReachabilityStatusReachableViaWiFi) {
            NSLog(@"当前网络：WiFi");
        }
    }];
    [manager startMonitoring];
}

//过滤后台返回字符串中的标签
+ (NSString *)flattenHTML:(NSString *)html {
    
    NSScanner *theScanner;
    NSString *text = nil;
    
    theScanner = [NSScanner scannerWithString:html];
    
    while ([theScanner isAtEnd] == NO) {
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:
                [NSString stringWithFormat:@"%@>", text]
                                               withString:@""];
    }
    return html;
}

+(Boolean)isNetAvailable{
    // 1.将网址初始化成一个OC字符串对象
    NSString *urlStr = @"http://captive.apple.com";
    // 如果网址中存在中文,进行URLEncode
    NSString *newUrlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    // 2.构建网络URL对象, NSURL
    NSURL *url = [NSURL URLWithString:newUrlStr];
    // 3.创建网络请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:3];
    // 创建同步链接
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSString* result1 = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    //解析html页面
    NSString *str = [self flattenHTML:result1];
    //除掉换行符
    NSString *nstr = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    if ([nstr isEqualToString:@"SuccessSuccess"])
    {
        // NSLog(@"可以上网了");
        //   [PronetwayGeneralHandle shareHandle].NetworkCanUse = YES;
        return YES;
    }else {
        // NSLog(@"未联网");
        //[self showNetworkStatus:@"未联网"];
        //   [PronetwayGeneralHandle shareHandle].NetworkCanUse = NO;
        return NO;
    }
}



#pragma mark post传递body
+(void)postImage:(NSString *)url content:(NSString *)content success:(void (^)(id))success failure:(void (^)(id))failure{
    
    if(mStatus == AFNetworkReachabilityStatusNotReachable){
        [STToastUtil showFailureAlertSheet:MSG_NET_ERROR];
        failure([NSString stringWithFormat:@"%d",STATU_NONET]);
        return;
    }
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 20.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    //header
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:nil error:nil];
    
    //content-type
//    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    [request addValue:@"aapplication/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];

    //body
    NSData *body  =[content dataUsingEncoding:NSUTF8StringEncoding];
    
    
    [[manager uploadTaskWithRequest:request fromData:body progress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if(error){
            failure(MSG_FACEDETECT_FAIL);
        }else{
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingMutableLeaves) error:nil];
            long error_code = [[dic objectForKey:@"error_code"] longValue];
            if(error_code == 0){
                id result = [dic objectForKey:@"result"];
                success(result);
            }else{
                failure(MSG_FACEDETECT_FAIL);
            }
        }
    }] resume];
}

@end
