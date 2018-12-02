//
//  SecondaryMessageViewController.m
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/10/28.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import "SecondaryMessageViewController.h"

@interface SecondaryMessageViewController ()

@end

@implementation SecondaryMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //创建一个通知 在通知里面传值
//    _allLongCommentsInteger = 0;
    NSLog(@"_resaveIdString = %@",_resaveIdString);
    
    
    //现在已经求得id 的所有数组
    NSLog(@"_idRequestMutArray = %@",_idRequestMutArray);
    
//    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
//    _scrollView.contentSize = CGSizeMake(0, 750);
//    _scrollView.delegate = self;
//    _scrollView.bounces = YES;
//
//    [self fenethCommentsNumFromCommentManagerBlock];
//
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Dicttongzhi1:) name:@"Dicttongzhi1" object:nil];
//    _mainWebView = [[ZRBMainWKWebView alloc] init];
//
//
//
//    _requestModel = [[ZRBRequestJSONModel alloc] init];
//    NSInteger intEger = [_resaveIdString integerValue];
//    _requestModel.idRequestStr = [NSString stringWithFormat:@"%@",[NSNumber numberWithInteger:intEger]];
//    [_requestModel requestJSONModel];
//
//    _mainWebView.modelStr = [NSString stringWithFormat:@"%@",_requestModel.modelStr];
//    _mainWebView.shareUrlString = [NSString stringWithFormat:@"%@",_requestModel.shareUrlString];
//    [_mainWebView createAndGetJSONModelWKWebView];
//
//    [_mainWebView recieveNotification];
//
//
//
//    [self.view addSubview:_scrollView];
//    [_scrollView addSubview:_mainWebView];
//
//    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view);
//    }];
//
//    [_mainWebView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view);
//    }];
//    _refresh = YES;
    
    [self refreshController];
}

- (void)refreshController
{
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.contentSize = CGSizeMake(0, 750);
    _scrollView.delegate = self;
    _scrollView.bounces = YES;
    
    [self fenethCommentsNumFromCommentManagerBlock];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Dicttongzhi1:) name:@"Dicttongzhi1" object:nil];
    _mainWebView = [[ZRBMainWKWebView alloc] init];
    
    
    
    _requestModel = [[ZRBRequestJSONModel alloc] init];
    NSInteger intEger = [_resaveIdString integerValue];
    _requestModel.idRequestStr = [NSString stringWithFormat:@"%@",[NSNumber numberWithInteger:intEger]];
    [_requestModel requestJSONModel];
    
    _mainWebView.modelStr = [NSString stringWithFormat:@"%@",_requestModel.modelStr];
    _mainWebView.shareUrlString = [NSString stringWithFormat:@"%@",_requestModel.shareUrlString];
    [_mainWebView createAndGetJSONModelWKWebView];
    
    [_mainWebView recieveNotification];
    
    
    
    [self.view addSubview:_scrollView];
    [_scrollView addSubview:_mainWebView];
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [_mainWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    _refresh = YES;
}

- (void)fenethCommentsNumFromCommentManagerBlock
{
    
    //得先获得 所有id 数组 然后再获得 所有 日期数组 再通过这两者的key和value值组成字典
    [[ZRBCommentManager sharedManager] fetchCommentsNumDataFormNewsViewWithIdString:_resaveIdString Succeed:^(ZRBNewsAdditionalJSONModel *additionalJSONModel) {
        _allsApprovalInteger = additionalJSONModel.popularity;
        _allsCommentsInteger = additionalJSONModel.comments;
        _allLongCommentsInteger = additionalJSONModel.long_comments;
        _allShortCommentsInteger = additionalJSONModel.short_comments;
        //在上面创建ViewController 
        //如果长评论总数不为0 那么执行新闻对应长评论查看的网络请求
        if ( additionalJSONModel.long_comments != 0 ){
            //块请求后返回JOSNModel 然后
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            _tabBarView = [[ZRBTabBarView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) andAllapproval:_allsApprovalInteger andComments:_allsCommentsInteger];
            [_tabBarView.commentNewsButton addTarget:self action:@selector(pressCommentViewButton:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.view addSubview:_tabBarView];
            [_tabBarView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.view).offset(674);
                make.left.mas_equalTo(self.view);
                make.right.mas_equalTo(self.view);
                make.height.mas_equalTo(40);
                make.width.mas_equalTo(self.view.bounds.size.width);
                make.bottom.equalTo(self.view);
            }];
        });
        
    } error:^(NSError *error) {
        NSLog(@"网络请求错误");
    }];
}

- (void)pressCommentViewButton:(UIButton *)sender
{
    ZRBCommentViewController * commentViewController = [[ZRBCommentViewController alloc] init];
    commentViewController.secondResaveIdString = [NSString stringWithFormat:@"%@",_resaveIdString];
    commentViewController.allCommentsNumInteger = _allsCommentsInteger;
    commentViewController.realLongCommentsInteger = _allLongCommentsInteger;
    commentViewController.realShortCommentsInteger = _allShortCommentsInteger;
    [self.navigationController pushViewController:commentViewController animated:YES];
}

- (void)Dicttongzhi1:(NSNotification *)noti
{
    _mainWebView.modelStr = _requestModel.modelStr;
    _mainWebView.shareUrlString = [NSString stringWithFormat:@"%@",_requestModel.shareUrlString];
    NSLog(@"_mainWebView.modelStr === ----- -- -- - -- - - - - - -- - -- --- -- %@",_mainWebView.modelStr);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offSet = scrollView.contentOffset.y;
    //CGFloat alpha = (offSet - minAlphaOffset) / (maxAlphaOffect - minAlphaOffset);
    NSLog(@"scrollView.contentSize.height = %.2f",scrollView.contentSize.height);//实际内容高度
    NSLog(@"scrollView.frame.size.height = %.2f",scrollView.frame.size.height);//屏幕可见高度
    NSLog(@"scrollView.contentOffset.y = %.2f",scrollView.contentOffset.y);//内容偏移量
    if ( scrollView.frame.size.height + scrollView.contentOffset.y > scrollView.contentSize.height ){
        NSInteger i = 0;
        if ( _refresh ){
            NSLog(@"到底不拉");
            //得到此时的日期 然后再减一 通过-1的日期进行网络请求
            
             //得先获得 所有id 数组 然后再获得 所有 日期数组 再通过这两者的key和value值组成字典 通过与每次的idString进行对比
            //获得对应idString的日期
            
            //用方法二： 如果滚到底部
            //获得idString这个数组 先通过遍历这个数组找到与本次网页显示的id对应的在数组中的位置
            //然后再新创建一个NSString类型的变量 来存储该位置下一个单元的String
            //然后网络请求这个String
            NSString * getRealIdString = [[NSString alloc] init];
            for (int i = 0; i < _idRequestMutArray.count; i++) {
                if ( [[NSString stringWithFormat:@"%@",_idRequestMutArray[i]] isEqualToString:_resaveIdString] ){
                    if ( _idRequestMutArray.count > i+1){
                        getRealIdString = [NSString stringWithFormat:@"%@",_idRequestMutArray[i+1]];
                        _resaveIdString = getRealIdString;
                    }
                    break;
                }
            }
            NSMutableArray * lastIdArray = [NSMutableArray arrayWithArray:_idRequestMutArray];
            //问题二：是新创建一个WkwebView还是还是用ViewDidLoad里面初始化好的呢？
            //1.先重新创建一个ViewController;
            SecondaryMessageViewController * secondMessageViewController = [[SecondaryMessageViewController alloc] init];
            secondMessageViewController.resaveIdString = getRealIdString;
            secondMessageViewController.idRequestMutArray = [NSMutableArray arrayWithArray:lastIdArray];
            
//            _resaveIdString = getRealIdString;
//            _idRequestMutArray = [NSMutableArray arrayWithArray:lastIdArray];
            //[self refreshController];
#pragma mark //问题：   再次加载只能下拉加载一天的数据 再多就不行了 //因为 refresh = NO; 这个该怎么解决？   加个通知？？？
//            [self bring]
            NSArray * viewArray = [NSArray arrayWithObject:self.view.subviews];
            NSLog(@"viewArray.count = %li",viewArray.count);
            [self.navigationController pushViewController:secondMessageViewController animated:YES];
            [self removeFromParentViewController];
            
            //完毕 接下来就是什么 返回界面 ！！！
            //还有其他几个界面  还有返回上一层
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
//            [viewArray[0][0] removeFromSuperview];
//            [viewArray[0][1] removeFromSuperview];
            
            //2.再用初始化好的
            
            
            //如果是滚动到顶部
            //先判断该id在数组中的位置是否在首位 如果不在首位则执行以下操作：
            //获得idString这个数组 先通过遍历这个数组找到与本次网页显示的id对应的在数组中的位置
            //然后再新创建一个NSString类型的变量 来存储该位置上个单元的String
            //然后网络请求这个String
            _refresh = NO;
            NSLog(@"xxoo");
            //[self refreshController];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
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
