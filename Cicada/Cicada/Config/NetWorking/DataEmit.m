//
//  DataEmit.m
//  PanGu
//
//  Created by 吴肖利 on 16/6/29.
//  Copyright © 2016年 Security Pacific Corporation. All rights reserved.
//

#import "DataEmit.h"
#import "ParamsRequest.h"
#import "NetworkRequest.h"
#import "GetPriceToListModel.h"
//#import "ByteBuffer.h"


@implementation DataEmit

//获取最新价格
+ (NSURLSessionDataTask *)requestGetPriceToListParams:(NSDictionary *)params url:(NSString *)url successCompletionBlock:(successBlock_Extension)success failueCompletionBlock:(failureBlock)failure {
    return [NetworkRequest getMarketRequestUrlString:url params:params success:^(id responseObject) {
        id mie = [NSJSONSerialization JSONObjectWithData:responseObject options:3 error:nil];
        
        NSString *codeStr;
        if ([mie isKindOfClass:[NSDictionary class]]) {
            codeStr = mie[@"code"];
        } else {
            codeStr = mie[0][@"code"];
        }
        
        NSMutableArray *modelArr = [[NSMutableArray alloc] initWithCapacity:10];
        int pauseTime = -5;
        //返回的数值异常直接结束任务
        if (![codeStr isKindOfClass:[NSString class]]) {
            success(modelArr, pauseTime);
            return ;
        }
        //返回的数值异常
        if (![codeStr isEqualToString:@"0"]) {
            success(modelArr, pauseTime);
            return ;
        }
        
        NSDictionary *dic = mie[0];
        NSArray *arr = dic[@"data"];
        if (arr.count == 0) {
            success(modelArr, pauseTime);
            return ;
        }
        
        GetPriceToListModel *model = [[GetPriceToListModel alloc]init];
        NSMutableArray *timeDivisionArr = [[NSMutableArray alloc]init];
        for (NSArray *subArr in arr[0]) {
            TimeDivisionModel *tdModel = [[TimeDivisionModel alloc]init];
            tdModel.time = subArr[0];
            tdModel.price = kString_Format(@"%.3f",[subArr[1] floatValue]);
            tdModel.amount = subArr[2];
            tdModel.averagePrice = subArr[3];
            [timeDivisionArr addObject:tdModel];
        }
        
        model.jflag = dic[@"jflag"];
        
//        model.message = str;
        
        model.timeDivision = timeDivisionArr;
        model.code = [arr objectAtIndex:1];
        model.beforeClosePrice = [arr objectAtIndex:2];
        model.high = [arr objectAtIndex:3];
        model.low = [arr objectAtIndex:4];
        model.totalPrice = [arr objectAtIndex:5];
        model.buyOrder = [arr objectAtIndex:6];
        model.sellOrder = [arr objectAtIndex:7];
        model.presentAmount = [arr objectAtIndex:8];
        model.turnover = [arr objectAtIndex:9];
        model.trade = [arr objectAtIndex:10];
        model.tradeCode = [arr objectAtIndex:11];
        model.peg = [arr objectAtIndex:12];
        model.flowEquity = [arr objectAtIndex:13];
        model.totalEquity = [arr objectAtIndex:14];
        model.pbr = [arr objectAtIndex:15];
        model.priceToday = [arr objectAtIndex:40];
        model.detailType = [arr objectAtIndex:41];
        model.tradePhase = [arr objectAtIndex:42];
        model.suspension = [arr objectAtIndex:43];
        model.indexCode = [arr objectAtIndex:44];
        model.indexName = [arr objectAtIndex:45];
        model.nineNewPrice = [arr objectAtIndex:46];
        model.nineNewTime = [arr objectAtIndex:47];
        model.riseAmount = [arr objectAtIndex:48];
        model.fallingAmount = [arr objectAtIndex:49];
        model.noRisefallingAmount = [arr objectAtIndex:50];
        model.excolumn00 = @"";
        model.excolumn01 = @"";
        model.excolumn02 = @"";
        model.excolumn03 = @"";
        model.excolumn04 = @"";
        model.excolumn05 = @"";
        model.excolumn06 = @"";
        model.excolumn07 = @"";
        model.excolumn08 = @"";
        model.excolumn09 = @"";
        if (arr.count>16) {
                           
            model.buy1 = kString_Format(@"%f", [[arr objectAtIndex:20] floatValue]);
            model.buy2 = kString_Format(@"%f", [[arr objectAtIndex:21] floatValue]);
            model.buy3 = kString_Format(@"%f", [[arr objectAtIndex:22] floatValue]);
            model.buy4 = kString_Format(@"%f", [[arr objectAtIndex:23] floatValue]);
            model.buy5 = kString_Format(@"%f", [[arr objectAtIndex:24] floatValue]);
            model.sell1 = kString_Format(@"%f", [[arr objectAtIndex:25] floatValue]);
            model.sell2 = kString_Format(@"%f", [[arr objectAtIndex:26] floatValue]);
            model.sell3 = kString_Format(@"%f", [[arr objectAtIndex:27] floatValue]);
            model.sell4 = kString_Format(@"%f", [[arr objectAtIndex:28] floatValue]);
            model.sell5 = kString_Format(@"%f", [[arr objectAtIndex:29] floatValue]);
            model.buy1Amount = [arr objectAtIndex:30];
            model.buy2Amount = [arr objectAtIndex:31];
            model.buy3Amount = [arr objectAtIndex:32];
            model.buy4Amount = [arr objectAtIndex:33];
            model.buy5Amount = [arr objectAtIndex:34];
            model.sell1Amount = [arr objectAtIndex:35];
            model.sell2Amount = [arr objectAtIndex:36];
            model.sell3Amount = [arr objectAtIndex:37];
            model.sell4Amount = [arr objectAtIndex:38];
            model.sell5Amount = [arr objectAtIndex:39];
            model.industryUpAndDown = [arr objectAtIndex:16];
            model.equivalentRatio = [arr objectAtIndex:17];
            model.okVolume = [arr objectAtIndex:18];
            model.name = [arr objectAtIndex:19];
            model.harden = [arr objectAtIndex:52];
            model.dropStop = [arr objectAtIndex:53];
            model.financing = [arr objectAtIndex:54];
            [modelArr addObject:model];
        }
        success(modelArr,[mie[0][@"time"] integerValue]);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
    
}

//获取五日内日成交明细数据
+ (void)requestGetTodayListParams:(NSDictionary *)params url:(NSString *)url successCompletionBlock:(void(^)(NSMutableArray *, NSInteger, BOOL))success failueCompletionBlock:(failureBlock)failure {
    [NetworkRequest getRequestUrlString:url params:params success:^(id responseObject) {
        NSArray *tempArr;
        NSString *code;
        
        tempArr = [NSJSONSerialization JSONObjectWithData:responseObject options:3 error:nil];
        if (![tempArr isKindOfClass:[NSArray class]] || tempArr.count == 0) {
            if (success) {
                success(nil, -5, YES);
            }
            return;
        }
        code = tempArr[0][@"code"];
        if ([code isEqualToString:@"0"]) {
            
            NSArray *dataArr;
            NSMutableArray *arr;
            
            arr = [[NSMutableArray alloc] init];
            dataArr = tempArr[0][@"data"];
            
            __block GetPriceToListModel *getTodayListModel;
            
            [dataArr enumerateObjectsUsingBlock:^(NSArray *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                getTodayListModel = [[GetPriceToListModel alloc] init];
                
                getTodayListModel.date = [obj objectAtIndex:0];
                getTodayListModel.time = [obj objectAtIndex:1];
                getTodayListModel.currentPrice = [obj objectAtIndex:2];
                getTodayListModel.totalVolume = [obj objectAtIndex:3];
                getTodayListModel.excolumn02 = [obj objectAtIndex:4];
                getTodayListModel.excolumn03 = [obj objectAtIndex:5];
                
                [arr addObject:getTodayListModel];
            }];
            
            NSDictionary *dic = tempArr[0];
            BOOL showEMA = YES;
            if (dic && [dic isKindOfClass:[NSDictionary class]]) {
                showEMA = [dic[@"jflag"] intValue] == 0 ? YES : NO;
            }
            
            if (success) {
                success(arr, 0, showEMA);
            }
            
        }else{
            
            if (success) {
                success(nil, -5, YES);
            }
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
        
        if (success) {
            success(nil, -5, YES);
        }
    }];
}


@end
