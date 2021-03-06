//
//  HttpRequest.m
//  NetWorking
//  网络请求代理
//  Created by 王玉 on 16/4/19.
//  Copyright © 2016年 王玉. All rights reserved.
//

#import "ParamsRequest.h"
//#import "Unikey.h"
//#import "OpenUDID.h"

static float num;
@interface ParamsRequest ()
@end

@implementation ParamsRequest

+ (instancetype)getInstance {
    static ParamsRequest * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [self new];
    });
    
    return manager;
}

#pragma mark -- GET请求 --
/**
 *  发送get请求
 *
 *  @param URLString         请求的网址字符串
 *  @param headers           设置请求头
 *  @param type              设置请求类型Http or JSON
 *  @param interfaceID       设置请求的功能接口
 *  @param marker            设置请求Token等
 *  @param parameters        请求的参数
 *  @param success           请求成功的回调
 *  @param failure           请求失败的回调
 *
 *  @return 返回请求任务对象
 
 */
- (NSURLSessionDataTask *)getWithURLString:(NSString *)URLString
                               headers:(NSDictionary *)headers
                            orbYunType:(OrbYuntSerializerType)type
                           interfaceID:(NSString *)interfaceID
                                marker:(NSString *)marker
                            parameters:(id)parameters
                               success:(void (^)(id, NSURLSessionTask *))success
                               failure:(void (^)(NSError *, NSURLSessionTask *))failure{
    
    NSURLSessionDataTask *sessionTask;
    @try{

        NSMutableDictionary *paraDic = [[NSMutableDictionary alloc]init];
        if (parameters) {
            [paraDic setValue:parameters forKey:@"parms"];
        }
        if (interfaceID) {
            [paraDic setValue:interfaceID forKey:@"funcID"];
        }
        if (marker) {
            [paraDic setValue:marker forKey:@"token"];
        }

        //发送Get请求
        sessionTask = [[HttpRequest getInstance] getWithURLString:URLString headers:headers orbYunType:type parameters:paraDic success:^(id responseObject, NSURLSessionTask *task) {
            //请求成功,返回数据
            if (success) {
                success(responseObject,task);
                
            }
        } failure:^(NSError *error, NSURLSessionTask *task) {
            //请求失败,返回错误信息
            if (failure) {
                failure(error,task);
            }
        }];
        
    }@catch(NSException *exception){
//        P_Log(@"NSURLSessionTask: 下载数据失败%@",[exception reason]);
        
    }
    @finally{
        return sessionTask;
    }
}

#pragma mark -- POST请求 --
/**
 *  发送post请求
 *
 *  @param URLString         请求的网址字符串
 *  @param headers           设置请求头
 *  @param type              设置请求类型Http or JSON
 *  @param interfaceID       设置请求的功能接口
 *  @param marker            设置请求Token等
 *  @param parameters        请求的参数
 *  @param success           请求成功的回调
 *  @param failure           请求失败的回调
 *
 *  @return 返回请求任务对象
 */

- (NSURLSessionDataTask *)postWithURLString:(NSString *)URLString
                                headers:(NSDictionary *)headers
                             orbYunType:(OrbYuntSerializerType)type
                            interfaceID:(NSString *)interfaceID
                                 marker:(NSString *)marker
                             parameters:(id)parameters
                                success:(void (^)(id, NSURLSessionTask *))success
                                failure:(void (^)(NSError *, NSURLSessionTask *))failure {
    NSURLSessionDataTask *sessionTask;
    @try{
        //发送Post请求
        NSMutableDictionary *paraDic = [[NSMutableDictionary alloc]init];
        if (parameters) {
            [paraDic setValue:parameters forKey:@"parms"];
        }
        if (interfaceID) {
            [paraDic setValue:interfaceID forKey:@"funcid"];
        }
        if (marker) {
            [paraDic setValue:marker forKey:@"token"];
        }
        
        sessionTask = [[HttpRequest getInstance] postWithURLString:URLString headers:headers orbYunType:type parameters:paraDic success:^(id responseObject, NSURLSessionTask *task) {
            if (success) {
                success(responseObject,task);
                
            }
        } failure:^(NSError *error, NSURLSessionTask *task) {
            if (failure) {
                failure(error,task);
            }
        }];
        
    }@catch(NSException *exception){
//        P_Log(@"NSURLSessionTask: 下载数据失败%@",[exception reason]);
        
    }
    @finally{
        return sessionTask;
    }

}

/**
 *  发送post请求
 *
 *  @param URLString         请求的网址字符串
 *  @param headers           设置请求头
 *  @param type              设置请求类型Http or JSON
 *  @param interfaceID       设置请求的功能接口
 *  @param marker            设置请求Token等
 *  @param parameters        请求的参数
 *  @param success           请求成功的回调
 *  @param failure           请求失败的回调
 *
 *  @return 返回请求任务对象
 */

- (NSURLSessionDataTask *)postWithURLString:(NSString *)URLString
                                headers:(NSDictionary *)headers
                             orbYunType:(OrbYuntSerializerType)type
                            interfaceID:(NSString *)interfaceID
                                 marker:(NSString *)marker
                             encryption:(BOOL)isEncryption
                             parameters:(id)parameters
                                success:(void (^)(id, NSURLSessionTask *))success
                                failure:(void (^)(NSError *, NSURLSessionTask *))failure {
    NSURLSessionDataTask *sessionTask;
    @try{
        //发送Post请求
        NSMutableDictionary *paraDic = [[NSMutableDictionary alloc]init];
        
        if (interfaceID) {
            [paraDic setValue:interfaceID forKey:@"funcid"];
        }
        if (marker) {
            [paraDic setValue:marker forKey:@"token"];
        }

//        isEncryption = NO;
//        [paraDic setValue:kString_Format(@"%d", isEncryption) forKey:@"secret"];
        
        if (parameters) {
            [paraDic setValue:parameters forKey:@"parms"];

//            if (isEncryption && [TradeScnoManage isPassWord]) {
//                NSArray *arr = [parameters allKeys];
//                NSMutableDictionary *cipherDic = @{}.mutableCopy;
//                for (NSString *obj in arr) {
//                    NSString *str = [[Unikey getInstance] encryptBySesstionKey:parameters[obj]];
//                    if (str && str.length > 0) {
//                        [cipherDic setObject:str forKey:obj];
//                    }else {
//                        [cipherDic setObject:@"" forKey:obj];
//                    }
//                }
//                [paraDic setValue:cipherDic forKey:@"parms"];
//            }else {
//                [paraDic setValue:parameters forKey:@"parms"];
//            }
        }
        
        sessionTask = [[HttpRequest getInstance] postWithURLString:URLString headers:headers orbYunType:type parameters:paraDic success:^(id responseObject, NSURLSessionTask *task) {
            if (success) {
                success(responseObject,task);
                
            }
        } failure:^(NSError *error, NSURLSessionTask *task) {
            if (failure) {
                failure(error,task);
            }
        }];
        
    }@catch(NSException *exception){
//        P_Log(@"NSURLSessionTask: 下载数据失败%@",[exception reason]);
        
        NSError *error = [[NSError alloc] initWithDomain:NSUnderlyingErrorKey code:-5692 userInfo:nil];
        failure(error, nil);
        
    }
    @finally{
        return sessionTask;
    }
    
}

#pragma mark -- 上传文件 --
/**
 *  上传文件
 *
 *  @param URLString          上传文件的网址字符串
 *  @param headers            设置请求头
 *  @param type               设置请求类型Http or JSON
 *  @param interfaceID        设置请求的功能接口
 *  @param marker             设置请求Token等
 *  @param parameters         上传文件的参数
 *  @param uploadParam        上传文件的信息
 *  @param success            上传成功的回调
 *  @param failure            上传失败的回调
 *
 *  @return 返回请求任务对象
 */
- (NSURLSessionDataTask *)uploadWithURLString:(NSString *)URLString
                                  headers:(NSDictionary *)headers
                               orbYunType:(OrbYuntSerializerType)type
                              interfaceID:(NSString *)interfaceID
                                   marker:(NSString *)marker
                               parameters:(id)parameters
                            blockprogress:(void (^)(NSProgress *))prograss
                              filePathUrl:(NSString *)pathUrl
                                  success:(void (^)(id, NSURLSessionTask *))success
                                  failure:(void (^)(NSError *, NSURLSessionTask *))failure{
    NSURLSessionDataTask *sessionTask;
    @try{
        NSMutableDictionary *paraDic = [[NSMutableDictionary alloc]init];
        if (parameters) {
            [paraDic setValue:parameters forKey:@"parms"];
        }
        if (interfaceID) {
            [paraDic setValue:interfaceID forKey:@"funcID"];
        }
        if (marker) {
            [paraDic setValue:marker forKey:@"token"];
        }
        
        //进行上传文件请求
        sessionTask = [[HttpRequest getInstance] uploadWithURLString:URLString headers:headers orbYunType:type parameters:paraDic blockprogress:^(NSProgress *uploadProgress) {
            if (prograss) {
                prograss(uploadProgress);
            }
        } filePathUrl:pathUrl success:^(id responseObject, NSURLSessionTask *task) {
            //请求成功,返回数据
            if (success) {
                success(responseObject,task);
            }
        } failure:^(NSError *error, NSURLSessionTask *task) {
            //请求失败,返回错误信息
            if (failure) {
                failure(error,task);
            }
        }];
        
        
    }@catch(NSException *exception){
//        P_Log(@"NSURLSessionTask: 下载数据失败%@",[exception reason]);
        
    }
    @finally{
        return sessionTask;
    }
}
#pragma mark -- 下载文件 --
/**
 *  下载文件
 *
 *  @param URLString         请求的网址字符串
 *  @param headers           设置请求头
 *  @param type              设置请求类型Http or JSON
 *  @param interfaceID       设置请求的功能接口
 *  @param marker            设置请求Token等
 *  @param parameters        请求的参数
 *  @param success           请求成功的回调
 *  @param failure           请求失败的回调
 *
 *  @return                  返回请求任务对象
 */
-(NSURLSessionDataTask *)downLoadWithURLString:(NSString *)URLString
                                   headers:(NSDictionary *)headers
                                orbYunType:(OrbYuntSerializerType)type
                               interfaceID:(NSString *)interfaceID
                                    marker:(NSString *)marker
                                parameters:(id)parameters
                             blockprogress:(void (^)(NSProgress *))prograss
                                   success:(void (^)(id, NSURLSessionTask *))success
                                   failure:(void (^)(NSError *, NSURLSessionTask *))failure{
    NSURLSessionDataTask *sessionTask;
    @try{
        NSMutableDictionary *paraDic = [[NSMutableDictionary alloc]init];
        if (parameters) {
            [paraDic setValue:parameters forKey:@"parms"];
        }
        if (interfaceID) {
            [paraDic setValue:interfaceID forKey:@"funcID"];
        }
        if (marker) {
            [paraDic setValue:marker forKey:@"token"];
        }
        
        //进行下载Post请求
        
        sessionTask = [[HttpRequest getInstance] downLoadWithURLString:URLString headers:headers orbYunType:type parameters:paraDic blockprogress:^(NSProgress *uploadProgress) {
            //下载进度
            if (prograss) {
                prograss(uploadProgress);
            }
        } success:^(id responseObject, NSURLSessionTask *task) {
            //请求成功,返回数据
            if (success) {
                success(responseObject,task);
            }
        } failure:^(NSError *error, NSURLSessionTask *task) {
            //请求失败,返回错误信息
            if (failure) {
                failure(error,task);
            }
        }];
               
        
    }@catch(NSException *exception){
//        P_Log(@"NSURLSessionTask: 下载数据失败%@",[exception reason]);
        
    }
    @finally{
        return sessionTask;
    }
}
- (NSString *)flowCountTotal{
    return [NSString stringWithFormat:@"%d",(int)num];
}
-(void)dealloc{
}
@end
