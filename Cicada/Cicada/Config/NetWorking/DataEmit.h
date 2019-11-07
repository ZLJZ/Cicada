//
//  DataEmit.h
//  PanGu
//
//  Created by 吴肖利 on 16/6/29.
//  Copyright © 2016年 Security Pacific Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^successBlock)(NSMutableArray * modelArray);
typedef void(^successBlock_Extension)(NSMutableArray * modelArray, NSInteger distanceTime);
typedef void(^failureBlock)(NSError *error);

@interface DataEmit : NSObject

//获取最新价格
+ (void)requestGetPriceParams:(NSDictionary *)params url:(NSString *)url successCompletionBlock:(successBlock)success failueCompletionBlock:(failureBlock)failure;

//获取板块/行业/地域列表
+ (void)requestGetCategoryListParams:(NSDictionary *)params url:(NSString *)url successCompletionBlock:(successBlock)success failueCompletionBlock:(failureBlock)failure;

//获取今日成交明细数据
+ (void)requestGetTodayParams:(NSDictionary *)params url:(NSString *)url successCompletionBlock:(successBlock)success failueCompletionBlock:(failureBlock)failure;

//获取最新价格（*该方法主要为自选股行情用）
+ (void)requestGetPriceListParams:(NSDictionary *)params url:(NSString *)url successCompletionBlock:(successBlock)success failueCompletionBlock:(failureBlock)failure;

//搜索股票
+ (void)requestQueryStockParams:(NSDictionary *)params url:(NSString *)url successCompletionBlock:(successBlock)success failueCompletionBlock:(failureBlock)failure;

//获取历史K线
+ (void)requestGetHistoryParams:(NSDictionary *)params url:(NSString *)url successCompletionBlock:(successBlock)success failueCompletionBlock:(failureBlock)failure;

//获取指定股票日K线收盘价的序列（用作多股比对）
+ (void)requestGetKSerialParams:(NSDictionary *)params url:(NSString *)url successCompletionBlock:(successBlock)success failueCompletionBlock:(failureBlock)failure;

//获取股票名称
+ (void)requestGetStockByCodeParams:(NSDictionary *)params url:(NSString *)url successCompletionBlock:(successBlock)success failueCompletionBlock:(failureBlock)failure;

//获取指定股票分类分页的行情列表
+ (void)requestGetStockListPageParams:(NSDictionary *)params url:(NSString *)url successCompletionBlock:(successBlock)success failueCompletionBlock:(failureBlock)failure;

//获得指定板块、指定排序、指定分页的行情列表
+ (void)requestGetPriceListPageParams:(NSDictionary *)params url:(NSString *)url successCompletionBlock:(successBlock)success failueCompletionBlock:(failureBlock)failure;

//获取板块/行业/地域按照涨跌排序列表
+ (void)requestGetCategoryPriceListParams:(NSDictionary *)params url:(NSString *)url successCompletionBlock:(successBlock)success failueCompletionBlock:(failureBlock)failure;

//获取股票列表
+ (void)requestGetStockListParams:(NSDictionary *)params url:(NSString *)url successCompletionBlock:(successBlock)success failueCompletionBlock:(failureBlock)failure;

//获取最新价格（增加是否获取买1-买5）
+ (NSURLSessionDataTask *)requestGetPriceToListParams:(NSDictionary *)params url:(NSString *)url successCompletionBlock:(successBlock_Extension)success failueCompletionBlock:(failureBlock)failure;

//获取五日内日成交明细数据
+ (void)requestGetTodayListParams:(NSDictionary *)params url:(NSString *)url successCompletionBlock:(void(^)(NSMutableArray *, NSInteger, BOOL))success failueCompletionBlock:(failureBlock)failure;


//查询今日发行新股
+ (void)requestTodayIssueNewShareParams:(NSDictionary *)params url:(NSString *)url successCompletionBlock:(void(^)(NSMutableArray *, BOOL))success failueCompletionBlock:(failureBlock)failure;

//查询今日上市新股
+ (void)requestTodayListedSharesParams:(NSDictionary *)params url:(NSString *)url successCompletionBlock:(successBlock)success failueCompletionBlock:(failureBlock)failure;

//查询待上市新股
+ (void)requestNewSharesToBeListedParams:(NSDictionary *)params url:(NSString *)url successCompletionBlock:(void(^)(NSMutableArray *, BOOL))success failueCompletionBlock:(failureBlock)failure;



//获取指定时间的现手量，时间，价格
+ (void)requestgetCurAmountParams:(NSDictionary *)params url:(NSString *)url successCompletionBlock:(successBlock)success failueCompletionBlock:(failureBlock)failure;

//获取资金流入/流出总额
+ (void)requestGetTeadingCFParams:(NSDictionary *)params url:(NSString *)url successCompletionBlock:(successBlock)success failueCompletionBlock:(failureBlock)failure;

//查询新股信息
+ (void)requestQueryNewSharesInformationModelParams:(NSDictionary *)params url:(NSString *)url successCompletionBlock:(void(^)(NSMutableArray *modelArr,NSString *code))success failueCompletionBlock:(failureBlock)failure;

//
+ (void)requestNewSharesQuotesParams:(NSDictionary *)params url:(NSString *)url successCompletionBlock:(successBlock)success failueCompletionBlock:(failureBlock)failure;



//请求成分股内容
+ (void)requestIndexStockParams:(NSDictionary *)params url:(NSString *)url successCompletionBlock:(successBlock)success failueCompletionBlock:(failureBlock)failure;
@end
