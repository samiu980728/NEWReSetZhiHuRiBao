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
    
    self.navigationController.delegate = self;
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
            [_tabBarView.goNextNewsViewButton addTarget:self action:@selector(pressGoNextViewsButton:) forControlEvents:UIControlEventTouchUpInside];
            [_tabBarView.returnMainViewButton addTarget:self action:@selector(pressReturnMainViewButton:) forControlEvents:UIControlEventTouchUpInside];
            [_tabBarView.giveApproveButton addTarget:self action:@selector(pressGiveApproveButton:) forControlEvents:UIControlEventTouchUpInside];
            _tabBarView.giveApproveButton.adjustsImageWhenHighlighted = NO;
            _tabBarView.giveApproveButton.selected = NO;
            
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

- (void)pressGiveApproveButton:(UIButton *)idSender
{
    //还要创建一个UIView  里面也是一个点赞图片 把那个_allsApprovalInteger 也加进去 然后
    //做一个动画
    
    
    //关键帧动画
    //用动画完成放大的效果
    CAKeyframeAnimation *animation=[CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    //需要给他设置一个关键帧的值,这个值就是变化过程
    //values是一个数组
    animation.values=@[@(0.5),@(1.0),@(1.5)];
    //设置动画的时长
    animation.duration=0.2;
    //加到button上
    [_tabBarView.giveApproveButton.layer addAnimation:animation forKey:@"animation"];
    if ( _tabBarView.giveApproveButton.selected == NO ){
        [_tabBarView.giveApproveButton setBackgroundImage:[UIImage imageNamed:@"11.png"] forState:UIControlStateNormal];
        _allsApprovalInteger++;
        _tabBarView.allCommentsLabel.text = [NSString stringWithFormat:@"%li",_allsApprovalInteger];
    }else{
        [_tabBarView.giveApproveButton setBackgroundImage:[UIImage imageNamed:@"5.png"] forState:UIControlStateNormal];
        _allsApprovalInteger--;
        _tabBarView.allCommentsLabel.text = [NSString stringWithFormat:@"%li",_allsApprovalInteger];
    }
    _tabBarView.giveApproveButton.selected = !_tabBarView.giveApproveButton.selected;
    
    //出现UIView
    //然后 前一个数字得消失  还有一个弹跳/弹动的效果实现
    //那么也就意味着label 的原来的那个数字也得需要一个动画来让它弹跳着消失
    //在什么时候让原来的数字消失？？？
    //我认为应该在dispatch_after 0.7之后 让label上的文字消失即可
#pragma mark  看CALayer
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    CAKeyframeAnimation * pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.duration = 0.7;
    pathAnimation.repeatCount = 0;
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    CGPathMoveToPoint(curvedPath, NULL, 300, 660);
    CGPathAddQuadCurveToPoint(curvedPath, NULL, 300, 650, 300, 640);
    pathAnimation.path = curvedPath;
    CGPathRelease(curvedPath);
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(130, 620, 200, 40)];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"2.png"]];
    label.font = [UIFont systemFontOfSize:15];
    label.text = @"156";
   // [label sizeToFit];
    [self.view addSubview:label];
    
    UILabel * numLabel = [[UILabel alloc] initWithFrame:CGRectMake(300, 576, 200, 40)];
    //numLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"2.png"]];
    numLabel.font = [UIFont systemFontOfSize:15];
    numLabel.text = @"157";
    [self.view addSubview:numLabel];
    [numLabel.layer addAnimation:pathAnimation forKey:@"moveTheSquare"];

    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (ino64_t)(2 * NSEC_PER_SEC));
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [label removeFromSuperview];
        [numLabel removeFromSuperview];
    });
    
}

- (void)pressReturnMainViewButton:(UIButton *)idSender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)pressGoNextViewsButton:(UIButton *)idSender
{
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
    SecondaryMessageViewController * secondMessageViewController = [[SecondaryMessageViewController alloc] init];
    secondMessageViewController.resaveIdString = getRealIdString;
    secondMessageViewController.idRequestMutArray = [NSMutableArray arrayWithArray:lastIdArray];
    NSArray * viewArray = [NSArray arrayWithObject:self.view.subviews];
    NSLog(@"viewArray.count = %li",viewArray.count);
    CATransition * transition = [CATransition animation];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController pushViewController:secondMessageViewController animated:NO];
    [self removeFromParentViewController];
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
            SecondaryMessageViewController * secondMessageViewController = [[SecondaryMessageViewController alloc] init];
            secondMessageViewController.resaveIdString = getRealIdString;
            secondMessageViewController.idRequestMutArray = [NSMutableArray arrayWithArray:lastIdArray];
            NSArray * viewArray = [NSArray arrayWithObject:self.view.subviews];
            NSLog(@"viewArray.count = %li",viewArray.count);
            
            CATransition * transition = [CATransition animation];
            transition.type = kCATransitionPush;
            transition.subtype = kCATransitionFromTop;
            [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
            [self.navigationController pushViewController:secondMessageViewController animated:NO];
            [self removeFromParentViewController];
            _refresh = NO;
            NSLog(@"xxoo");
        }
    }
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    //指定特殊ViewController之间的跳转动画
    if (operation == UINavigationControllerOperationPush && [toVC isKindOfClass:[SecondaryMessageViewController class]]) {
        return [[ZRBTransitionVerticalPush alloc]init];
    }else if(operation == UINavigationControllerOperationPop && [fromVC isKindOfClass:[SecondaryMessageViewController class]]){
        return [[ZRBTransitionVerticalPop alloc]init];
    }else{
        return nil;
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
