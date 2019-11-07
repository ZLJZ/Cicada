//
//  GCDUseViewController.m
//  Cicada
//
//  Created by 张琦 on 2017/4/1.
//  Copyright © 2017年 com. All rights reserved.
//

#import "GCDUseViewController.h"

@interface GCDUseViewController ()

@end

@implementation GCDUseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self testGCD];
    
    //DISPATCH_QUEUE_PRIORITY_DEFAULT  指定队列优先级
    //0  作为保留字段备用
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        dispatch_async(dispatch_get_main_queue(), ^{
//            //
//        });
//    });
    
    
    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"work1----%@",[NSThread currentThread]);
        sleep(5);
    });

  
    //dispatch barrier 会确保队列中先于 barrier提交的任务执行完后在执行barrier，barrier执行完之后再执行其他任务
    //dispatch barrier 会确保队列中先于 barrier提交的任务执行完后在执行barrier，barrier执行完之后再执行其他任务
    //但是如果我们将 barrier block 提交到一个 global queue，barrier block 执行效果与 dispatch async 效果一样，只有将barrier block 提交到使用DISPATCH_QUEUE_CONCURRENT创建的并行队列时他才是该执行效果
    dispatch_barrier_async(queue, ^{
        NSLog(@"work2----%@",[NSThread currentThread]);
        sleep(5);
    });

    dispatch_async(queue, ^{
        NSLog(@"work3----%@",[NSThread currentThread]);
    });
    
    
//    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        sleep(5);
//        NSLog(@"work1----%@",[NSThread currentThread]);
//    });
//
//
//    dispatch_barrier_async(dispatch_get_global_queue(0, 0), ^{
//        sleep(5);
//        NSLog(@"work2----%@",[NSThread currentThread]);
//    });
//
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        NSLog(@"work3----%@",[NSThread currentThread]);
//    });
    
    
    
    
    /*
    [self createSingleInstance];
    [self createQueue];
    [self createDelay];
     */
}


- (void)testGCD {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"2333");
        NSLog(@"%@",[NSThread currentThread]);
        dispatch_async(dispatch_get_main_queue(), ^{
            //回到主线程执行更新界面等操作
            NSLog(@"%@",[NSThread currentThread]);
        });
    });
    NSLog(@"111");
//    NSLock *lock;
//    [lock lock];
//    [lock unlock];
}


#pragma mark  创建单例
- (void)createSingleInstance {
    //dispatch_once_t必须是全局或静态变量
    //静态变量，保证只有一份实例，才能确保只被执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //单例代码
    });
    
}

#pragma mark  创建队列
- (void)createQueue {
    //第二个参数尝传的是NULL
    //串行队列
    dispatch_queue_t cicadaQueueSerial = dispatch_queue_create("CicadaQueueSerial", DISPATCH_QUEUE_SERIAL);
    
    //并行队列
    dispatch_queue_t cicadaQueueConcurrent = dispatch_queue_create("CicadaQueueConcurrent",DISPATCH_QUEUE_CONCURRENT);
}

- (void)createDelay {
    //dispatch_after是延迟提交，不是延迟运行
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(<#delayInSeconds#> * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        <#code to be executed after a specified delay#>
//    });
    //创建串行队列
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_SERIAL);
    NSLog(@"begin....");
//    dispatch_async(queue, ^{
//        //sleep 10秒
//        NSLog(@"dispatch_async 10 front");
//        [NSThread sleepForTimeInterval:10];
//        NSLog(@"dispatch_async 10 after");
//        
//    });
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        <#code to be executed after a specified delay#>
//    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), queue, ^{
        NSLog(@"dispatch_after 5 after");
    });
    
    /*
    2017-04-01 13:56:21.448 Cicada[40822:438475] begin....
    2017-04-01 13:56:21.448 Cicada[40822:438540] dispatch_async 10 front
    2017-04-01 13:56:31.520 Cicada[40822:438540] dispatch_async 10 after
    2017-04-01 13:56:31.520 Cicada[40822:438540] dispatch_after 5 after
     */
    
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
