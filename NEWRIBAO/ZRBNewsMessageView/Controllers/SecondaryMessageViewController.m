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
    [self.view addSubview:_mainWebView];
    
    [_mainWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)fenethCommentsNumFromCommentManagerBlock
{
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
