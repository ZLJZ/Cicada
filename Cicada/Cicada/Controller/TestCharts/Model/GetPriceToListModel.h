//
//  GetPriceToListModel.h
//  PanGu
//  保留
//  Created by 吴肖利 on 16/7/6.
//  Copyright © 2016年 Security Pacific Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "MJExtension.h"

@class TimeDivisionModel;
@interface GetPriceToListModel : NSObject

// 凑合着用吧
@property (nonatomic, copy) NSString *message;

// 是否显示均线0显示，1隐藏   2017-12-22
@property (nonatomic, copy) NSString *jflag;

//自选股model
//搜索股票
//记录button点击情况
@property (nonatomic,assign)BOOL btnSelected;
//股票名字
@property (nonatomic, copy) NSString *name;
//股票代码
@property (nonatomic, copy) NSString *code;
//持仓 0 未持仓 1 持仓
@property (nonatomic, copy) NSString *hold;
//热搜 1 热  0 不热
@property (nonatomic, copy) NSString *hot;
//融标签 1 有融  0 没融
@property (nonatomic, copy) NSString *rong;
//位置
@property (nonatomic, copy) NSString *index;
//当前价格
@property (nonatomic, copy) NSString *currentPrice;
//前收盘价格
@property (nonatomic, copy) NSString *beforeClosePrice;
//涨跌幅
@property (nonatomic, copy) NSString *chg;
//涨跌值
@property (nonatomic, copy) NSString *chgValue;
//时间
@property (nonatomic, copy) NSString *time;
//日期
@property (nonatomic, copy) NSString *date;
//最高
@property (nonatomic, copy) NSString *high;
//最低
@property (nonatomic, copy) NSString *low;
//总成交量
@property (nonatomic, copy) NSString *totalVolume;
//总成交金额
@property (nonatomic, copy) NSString *totalPrice;
//内盘
@property (nonatomic, copy) NSString *buyOrder;
//外盘
@property (nonatomic, copy) NSString *sellOrder;
//现量
@property (nonatomic, copy) NSString *presentAmount;
//换手率
@property (nonatomic, copy) NSString *turnover;
//行业
@property (nonatomic, copy) NSString *trade;
//行业代码
@property (nonatomic, copy) NSString *tradeCode;
//市盈率
@property (nonatomic, copy) NSString *peg;
//流通股本
@property (nonatomic, copy) NSString *flowEquity;
//总股本
@property (nonatomic, copy) NSString *totalEquity;
//市净率
@property (nonatomic, copy) NSString *pbr;
//行业涨跌幅
@property (nonatomic, copy) NSString *industryUpAndDown;
//量比
@property (nonatomic, copy) NSString *equivalentRatio;
//成交量
@property (nonatomic, copy) NSString *okVolume;
//今开
@property (nonatomic, copy) NSString *priceToday;
//明细类型
@property (nonatomic, copy) NSString *detailType;
//交易阶段 产品所处交易阶段(0：集合竞价 1：连续竞价)
@property (nonatomic, copy) NSString *tradePhase;
//是否停盘 是否停盘(0：正常状态 1：临时停排 2：全天停牌)
@property (nonatomic, copy) NSString *suspension;
//指数代码
@property (nonatomic, copy) NSString *indexCode;
//指数名称
@property (nonatomic, copy) NSString *indexName;
//最新价
@property (nonatomic, copy) NSString *nineNewPrice;
//最新时间
@property (nonatomic, copy) NSString *nineNewTime;
//涨家数
@property (nonatomic, copy) NSString *riseAmount;
//跌家数
@property (nonatomic, copy) NSString *fallingAmount;
//不涨不跌
@property (nonatomic, copy) NSString *noRisefallingAmount;

//如果入参type为0有以下数据
//买1
@property (nonatomic, copy) NSString *buy1;
//买2
@property (nonatomic, copy) NSString *buy2;
//买3
@property (nonatomic, copy) NSString *buy3;
//买4
@property (nonatomic, copy) NSString *buy4;
//买5
@property (nonatomic, copy) NSString *buy5;
//卖1
@property (nonatomic, copy) NSString *sell1;
//卖2
@property (nonatomic, copy) NSString *sell2;
//卖3
@property (nonatomic, copy) NSString *sell3;
//卖4
@property (nonatomic, copy) NSString *sell4;
//卖5
@property (nonatomic, copy) NSString *sell5;
//买1数量
@property (nonatomic, copy) NSString *buy1Amount;
//买2数量
@property (nonatomic, copy) NSString *buy2Amount;
//买3数量
@property (nonatomic, copy) NSString *buy3Amount;
//买4数量
@property (nonatomic, copy) NSString *buy4Amount;
//买5数量
@property (nonatomic, copy) NSString *buy5Amount;
//卖1数量
@property (nonatomic, copy) NSString *sell1Amount;
//卖2数量
@property (nonatomic, copy) NSString *sell2Amount;
//卖3数量
@property (nonatomic, copy) NSString *sell3Amount;
//卖4数量
@property (nonatomic, copy) NSString *sell4Amount;
//卖5数量
@property (nonatomic, copy) NSString *sell5Amount;

@property (nonatomic, copy) NSString *harden;// 涨停
@property (nonatomic, copy) NSString *dropStop;// 跌停

@property (nonatomic, copy) NSString *financing;// 是否是融

//备用字段00
@property (nonatomic, copy) NSString *excolumn00;
//备用字段01
@property (nonatomic, copy) NSString *excolumn01;
//备用字段02
@property (nonatomic, copy) NSString *excolumn02;
//备用字段03
@property (nonatomic, copy) NSString *excolumn03;
//备用字段04
@property (nonatomic, copy) NSString *excolumn04;
//备用字段05
@property (nonatomic, copy) NSString *excolumn05;
//备用字段06
@property (nonatomic, copy) NSString *excolumn06;
//备用字段07
@property (nonatomic, copy) NSString *excolumn07;
//备用字段08
@property (nonatomic, copy) NSString *excolumn08;
//备用字段09
@property (nonatomic, copy) NSString *excolumn09;

// 2018-04-19 祁继宇 给333000接口新增字段
@property (nonatomic, copy) NSString *EXCHANGE_TYPE;

/***********************下面全部是给详情页使用，自选股不用**********************/
//分时数组
@property (nonatomic, strong) NSMutableArray <TimeDivisionModel *>*timeDivision;

@end

@interface TimeDivisionModel : NSObject

//股票代码
@property (nonatomic, copy) NSString *TDcode;
//时间
@property (nonatomic, copy) NSString *time;
//当前价格
@property (nonatomic, copy) NSString *price;
//平均价格
@property (nonatomic, copy) NSString *averagePrice;
//总成交量
@property (nonatomic, copy) NSString *amount;
//成交量
@property (nonatomic, copy) NSString *okVolume;

//备用字段00
@property (nonatomic, copy) NSString *excolumn00;
//备用字段01
@property (nonatomic, copy) NSString *excolumn01;
//备用字段02
@property (nonatomic, copy) NSString *excolumn02;
//备用字段03
@property (nonatomic, copy) NSString *excolumn03;
//备用字段04
@property (nonatomic, copy) NSString *excolumn04;
//备用字段05
@property (nonatomic, copy) NSString *excolumn05;
//备用字段06
@property (nonatomic, copy) NSString *excolumn06;
//备用字段07
@property (nonatomic, copy) NSString *excolumn07;
//备用字段08
@property (nonatomic, copy) NSString *excolumn08;
//备用字段09
@property (nonatomic, copy) NSString *excolumn09;

+ (TimeDivisionModel *)modelWithArray:(NSArray *)arr WithCode:(NSString *)code;

@end
