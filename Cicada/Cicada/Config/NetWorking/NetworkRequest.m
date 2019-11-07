//
//  NetworkRequest.m
//  PanGu
//
//  Created by 吴肖利 on 16/7/3.
//  Copyright © 2016年 Security Pacific Corporation. All rights reserved.
//

#import "NetworkRequest.h"
#import "ParamsRequest.h"
#import "HttpRequestHangQing.h"

@implementation NetworkRequest

// 行情 Get
+ (NSURLSessionDataTask *)getMarketRequestUrlString:(NSString *)url params:(NSDictionary *)params success:(successRequestBlock)successBlock failure:(failureRequestBlock)failureBlock {
    return [[HttpRequestHangQing getInstance]getWithURLString:url headers:nil parameters:params success:^(id responseObject, NSURLSessionTask *task) {
        
        successBlock(responseObject);
    } failure:^(NSError *error, NSURLSessionTask *task) {
        failureBlock(error);
    }];
}

//GET
+ (NSURLSessionDataTask *)getRequestUrlString:(NSString *)url params:(NSDictionary *)params success:(successRequestBlock)successBlock failure:(failureRequestBlock)failureBlock {
    return [[HttpRequest getInstance]getWithURLString:url headers:nil orbYunType:3 parameters:params success:^(id responseObject, NSURLSessionTask *task) {

        successBlock(responseObject);
    } failure:^(NSError *error, NSURLSessionTask *task) {
        failureBlock(error);
    }];
}

//POST
+ (NSURLSessionDataTask *)postRequestUrlString:(NSString *)url params:(NSDictionary *)params success:(successRequestBlock)successBlock failure:(failureRequestBlock)failureBlock {
    return [[HttpRequest getInstance]postWithURLString:url headers:nil orbYunType:3 parameters:params success:^(id responseObject, NSURLSessionTask *task) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
            successBlock(data);
        }
        successBlock(responseObject);
    } failure:^(NSError *error, NSURLSessionTask *task) {
        failureBlock(error);
    }];
}

+ (NSURLSessionDataTask *)postHeadersRequestUrlString:(NSString *)url params:(NSDictionary *)params andHeaders:(NSDictionary *)headers success:(successRequestBlock)successBlock failure:(failureRequestBlock)failureBlock {
    return [[HttpRequest getInstance]postWithURLString:url headers:headers orbYunType:3 parameters:params success:^(id responseObject, NSURLSessionTask *task) {
        successBlock(responseObject);
    } failure:^(NSError *error, NSURLSessionTask *task) {
        failureBlock(error);
    }];
}

//交易POST
+ (NSURLSessionDataTask *)postRequestUrlString:(NSString *)url params:(NSDictionary *)params interfaceID:(NSString *)interfaceID token:(NSString *)token success:(successRequestBlock)successBlock failure:(failureRequestBlock)failureBlock {
    return [[ParamsRequest getInstance] postWithURLString:url headers:nil orbYunType:3 interfaceID:interfaceID marker:token parameters:params success:^(id responseObject, NSURLSessionTask *task) {
        successBlock(responseObject);
    } failure:^(NSError *error, NSURLSessionTask *task) {
        failureBlock(error);
    }];
    
}

+ (NSURLSessionDataTask *)postRequestUrlString:(NSString *)url params:(NSDictionary *)params interfaceID:(NSString *)interfaceID token:(NSString *)token encryption:(BOOL)isEncryption success:(successRequestBlock)successBlock failure:(failureRequestBlock)failureBlock {
    
    return [[ParamsRequest getInstance] postWithURLString:url headers:nil orbYunType:3 interfaceID:interfaceID marker:token encryption:isEncryption parameters:params success:^(id responseObject, NSURLSessionTask *task) {
        successBlock(responseObject);
    } failure:^(NSError *error, NSURLSessionTask *task) {
        failureBlock(error);
    }];
    
}

//GzipPost
+ (NSURLSessionDataTask *)postGzipRequestUrlString:(NSString *)url params:(NSDictionary *)params success:(successRequestBlock)successBlock failure:(failureRequestBlock)failureBlock {
    return [[HttpRequest getInstance]postGzipWithURLString:url headers:nil orbYunType:3 parameters:params success:^(id responseObject, NSURLSessionTask *task) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
            successBlock(data);
        }
        successBlock(responseObject);
    } failure:^(NSError *error, NSURLSessionTask *task) {
        failureBlock(error);
    }];
}


@end
