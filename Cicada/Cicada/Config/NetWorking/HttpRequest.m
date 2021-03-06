//
//  HttpRequest.m
//  NetWorking
//  网络请求代理
//  Created by 王玉 on 16/4/19.
//  Copyright © 2016年 王玉. All rights reserved.
//

#import "HttpRequest.h"
//#import "JX_GCDTimerManager.h"
//#import "NoNetworkWarning.h"
//#import "SiteSwitchModalViewController.h"
//#import "PanGuTabBarController.h"
//#import "MineSiteTestTableViewCell.h"

NSString *const PanGuHttpErrorDomain = @"PanGuHttpErrorDomain";

@interface HttpRequest ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@property (nonatomic, assign) BOOL isShow;// 无网络弹框是否已经显示, 如果显示就不再弹出

@property (nonatomic, assign) BOOL isShowChangeSite;// 是否已经弹出切换站点页面

@property (nonatomic, assign) BOOL isChecking;// 是否正在检查网络中, 如正在检查网络, 则不重复检查

@property (nonatomic, assign) BOOL isSuccessful;// 网络请求是否成功过

@property (nonatomic, assign) BOOL isCancel;//是否已取消网络请求

@end

@implementation HttpRequest

//创建单利
+ (instancetype)getInstance {
    
    static HttpRequest *managerRe;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        managerRe = [self new];
        
        managerRe.manager = [AFHTTPSessionManager manager];
        
        // 网络请求参数设置
        managerRe.manager.securityPolicy.allowInvalidCertificates = YES;
        // 判断requestSerializer, responseSerializer 请求和反馈类型
        
        managerRe.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        managerRe.manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",@"text/json",@"text/javascript",@"text/html",@"text/plain" ,@"application/octet-stream",@"multipart/form-data",@"application/x-www-form-urlencoded",@"text/json",@"text/xml",@"image/*"]];
        
        managerRe.manager.requestSerializer = [AFJSONRequestSerializer serializer];
//        [managerRe.manager.requestSerializer setValue:K_VERSION_SHORT forHTTPHeaderField:@"VersionNum"];
        [managerRe.manager.requestSerializer setValue:@"iOS" forHTTPHeaderField:@"AppType"];
        managerRe.manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
//        managerRe.manager.requestSerializer.timeoutInterval = PUBLIC_REQUEST_TIMEOUT;
        
        managerRe.manager.securityPolicy.allowInvalidCertificates = YES;
        managerRe.manager.securityPolicy.validatesDomainName = NO;
        
        managerRe.manager.operationQueue.maxConcurrentOperationCount = 5;
        
        //监控网络状态
        [managerRe netWorkChange];
    });
    
    return managerRe;

}

- (void)netWorkChange {
    Reachability *internetReachability = [Reachability reachabilityForInternetConnection];
    [internetReachability startNotifier];
    self.netStatus = [internetReachability currentReachabilityStatus];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netWorkDidChange:) name:kReachabilityChangedNotification object:nil];
}

- (void)netWorkDidChange:(NSNotification *)notice {
    self.netStatus = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
}

- (void)dealloc {
    [[Reachability reachabilityForInternetConnection] stopNotifier];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
}

#pragma mark -- GET请求 --
/**
 *  发送get请求
 *
 *  @param URLString  请求的网址字符串
 *  @param headers    设置请求头
 *  @param type       设置请求类型Http or JSON
 *  @param parameters 请求的参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return 返回请求任务对象
 
 */
- (NSURLSessionDataTask *)getWithURLString:(NSString *)URLString
                               headers:(NSDictionary *)headers
                            orbYunType:(OrbYuntSerializerType)type
                            parameters:(id)parameters
                               success:(void (^)(id, NSURLSessionDataTask *))success
                               failure:(void (^)(NSError *, NSURLSessionDataTask *))failure{
    
    NSURLSessionDataTask *sessionTask;
    @try {
        
        //设置请求头
        for (NSString * key in headers) {
            [_manager.requestSerializer setValue:headers[key] forHTTPHeaderField:key];
        }
        //发送Get请求
        sessionTask = [_manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //请求成功,返回数据
            
            
            if (success) {
                !success ? : success(responseObject,task);
            }
        }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];

    } @catch (NSException *exception) {
        
        
    } @finally {
        return sessionTask;
    }
}

#pragma mark -- POST请求 --
/**
 *  发送post请求
 *
 *  @param URLString  请求的网址字符串
 *  @param headers    设置请求头
 *  @param type       设置请求类型Http or JSON
 *  @param parameters 请求的参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return 返回请求任务对象
 */

- (NSURLSessionDataTask *)postWithURLString:(NSString *)URLString
                                headers:(NSDictionary *)headers
                             orbYunType:(OrbYuntSerializerType)type
                             parameters:(id)parameters
                                success:(void (^)(id, NSURLSessionDataTask *))success
                                failure:(void (^)(NSError *, NSURLSessionDataTask *))failure {
    NSURLSessionDataTask *sessionTask;
    @try{
        
        //设置请求头
        for (NSString * key in headers) {
            [_manager.requestSerializer setValue:headers[key] forHTTPHeaderField:key];
        }
        //发送Post请求
        sessionTask = [_manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            

            //请求成功,返回数据
            if (success) {
                success(responseObject,task);
            }
        }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            
        }];
    }@catch(NSException *exception){
    }
    @finally{
        return sessionTask;
    }
    
    
}



@end
