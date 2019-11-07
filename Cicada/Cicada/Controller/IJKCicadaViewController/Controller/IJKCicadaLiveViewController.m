//
//  IJKCicadaLiveViewController.m
//  Cicada
//
//  Created by 张琦 on 2017/6/1.
//  Copyright © 2017年 com. All rights reserved.
//

#import "IJKCicadaLiveViewController.h"
#import "IJKCicadaLiveTableViewCell.h"
#import "IJKLiveModel.h"
#import "MJExtension.h"
#import "LiveDetailViewController.h"


@interface IJKCicadaLiveViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation IJKCicadaLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_BACK;
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"直播列表";
    _dataSource = [[NSMutableArray alloc]init];
    
    [self customUI];
    [self requestData];
}

- (void)requestData {
    // 映客数据url
    NSString *urlStr = @"http://116.211.167.106/api/live/aggregation?uid=133825214&interest=2";//1女 2男
    
    // 请求数据
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", nil];
    [mgr GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        
        _dataSource = [IJKLiveModel mj_objectArrayWithKeyValuesArray:responseObject[@"lives"]];
        
        [_tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
        
    }];

}

- (void)customUI {
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = COLOR_BACK;
    _tableView.separatorInset = UIEdgeInsetsMake(0, 20, 0, 0);
    [self.view addSubview:_tableView];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IJKCicadaLiveTableViewCell *cell = [IJKCicadaLiveTableViewCell cicadaLiveTableViewCellTableView:tableView];
//    cell.imageViewLive.backgroundColor = COLOR_LIGHTGRAY;
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LiveDetailViewController *liveDetailVC = [[LiveDetailViewController alloc]init];
    liveDetailVC.liveModel = _dataSource[indexPath.row];
    [self.navigationController pushViewController:liveDetailVC animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
