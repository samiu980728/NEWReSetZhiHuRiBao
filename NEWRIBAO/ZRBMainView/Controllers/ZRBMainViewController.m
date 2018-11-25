//
//  ZRBMainViewController.m
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/10/28.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import "ZRBMainViewController.h"
#import "ZRBNewsTableViewCell.h"
#import "ZRBContinerViewController.h"
#import <UIImageView+WebCache.h>
@interface ZRBMainViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView * scrollView;

@end

@implementation ZRBMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _refreshNumInteger = 0;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadDataTongZhiController:) name:@"reloadDataTongZhiController" object:nil];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"今日新闻";
    
    _refresh = YES;
    _urlImageMutArray = [[NSMutableArray alloc] init];
    _idSelfMutArray = [[NSMutableArray alloc] init];
    _mainAnalyisMutArray = [[NSMutableArray alloc] init];
    _allDateMutArray = [[NSMutableArray alloc] init];
    _mainCellJSONModel = [[ZRBCellModel alloc] init];
    [_mainCellJSONModel giveCellJSONModel];
    _mainCellJSONModel.delegateCell = self;

    //开启滑动返回功能代码
    if ( [self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)] ){
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }

    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.contentSize = CGSizeMake(0, 900);
    _scrollView.delegate = self;
    _messageView = [[ZRBMessageVView alloc] init];
    [_messageView initTableView];
    _MainView = [[ZRBMainVIew alloc] init];
    [_MainView initMainTableView];
    
    self.title = @"今天新闻";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.view.layer.shadowColor = [UIColor blackColor].CGColor;
    self.navigationController.view.layer.shadowOffset = CGSizeMake(-10, 0);
    self.navigationController.view.layer.shadowOpacity = 0.15;
    self.navigationController.view.layer.shadowRadius = 10;
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"2.png"]];
    
    UIBarButtonItem * menuItemm = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"1.png"] style:UIBarButtonItemStylePlain target:self action:@selector(openCloseMenu:)];
    self.navigationItem.leftBarButtonItem = menuItemm;
    
    [_MainView.mainMessageTableView registerClass:[ZRBNewsTableViewCell class] forCellReuseIdentifier:@"messageCell"];
    [_MainView.mainMessageTableView registerClass:[ZRBDetailsTableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"detailHeaderView"];
    _MainView.delegate = self;
    [_scrollView addSubview:_MainView];
    _MainView.mainMessageTableView.delegate = self;
    _MainView.mainMessageTableView.dataSource = self;
    [self.view addSubview:_scrollView];
    [self fenethMessageFromManagerBlock:NO];
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [_MainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    _barImageView = [[UIImageView alloc] init];
    _barImageView = self.navigationController.navigationBar.subviews.firstObject;
}

//侧边框栏的展开和关闭
- (void)openCloseMenu:(UIBarButtonItem *)sender
{
    [self.navigationController.parentViewController performSelector:@selector(openCloseMenu)];
}

//manager类网络请求

//给这加个参数 BOOL 类型 判断是否上拉 传参数进行以下两种判断即可
- (void)fenethMessageFromManagerBlock:(BOOL)isRefresh
{
    _mainImageMutArray1 = [[NSMutableArray alloc] init];
    _mainTitleMutArray1 = [[NSMutableArray alloc] init];
    _titleMutArray1 = [[NSMutableArray alloc] init];
    _imageMutArray1 = [[NSMutableArray alloc] init];
    
    NSMutableArray * mainImageMutArray = [[NSMutableArray alloc] init];
    NSMutableArray * mainTitleMutArray = [[NSMutableArray alloc] init];
    //测试
    NSString * mainTestStr = [[NSString alloc] init];
    if ( isRefresh == NO ){
        [[ZRBCoordinateMananger sharedManager] fetchDataFromNetisReferesh:NO Succeed:^(NSArray *array) {
            NSLog(@"array = %@",array);
            
            TotalJSONModel * totalJSONModel = array[0];
            [_allDateMutArray addObject:totalJSONModel.date];
            NSArray * data = totalJSONModel.stories;
            for (int i = 0; i < data.count; i++) {
                NSMutableArray * titleMutArray = [[NSMutableArray alloc] init];
                NSMutableArray * imageMutArray = [[NSMutableArray alloc] init];
                NSMutableArray * idMutArray = [[NSMutableArray alloc] init];
                StoriesJSONModel * storJSONModel = data[i];
                [titleMutArray addObject:storJSONModel.title];
                [idMutArray addObject:[NSNumber numberWithInteger:storJSONModel.id]];
                NSURL * JSONUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",storJSONModel.images[0]]];
                NSData * imageData = [NSData dataWithContentsOfURL:JSONUrl];
                UIImage * image = [UIImage imageWithData:imageData];
                if ( image ){
                    [imageMutArray addObject:image];
                }
                [_titleMutArray1 addObject:titleMutArray];
                [_imageMutArray1 addObject:imageMutArray];
                [_idSelfMutArray addObject:[NSNumber numberWithInteger:storJSONModel.id]];
                [_urlImageMutArray addObject:[NSURL URLWithString:[NSString stringWithFormat:@"%@",storJSONModel.images[0]]]];
            }
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [_MainView.mainMessageTableView reloadData];
                        });
            
        } error:^(NSError *error) {
            NSLog(@"网络请求错误");
        }];
    
    }else{
        [[ZRBCoordinateMananger sharedManager] fetchDataFromNetisReferesh:YES Succeed:^(NSArray *array) {
            NSLog(@"多次之后的 array = %@",array);
            if ( _titleMutArray1.count > 0 ){
                [_titleMutArray1 removeAllObjects];
                [_imageMutArray1 removeAllObjects];
                [_urlImageMutArray removeAllObjects];
            }
            [_idSelfMutArray removeAllObjects];
            [_allDateMutArray removeAllObjects];
            
            for (int i = 0; i < array.count; i++) {
                TotalJSONModel * totalJSONModel = array[i];
                //现在这里面有一天的数据
                NSLog(@"totalJSONModel.stories = %@",totalJSONModel.stories);
                //一天的数据
                NSMutableArray * titleMutArray = [[NSMutableArray alloc] init];
                NSMutableArray * imageMutArray = [[NSMutableArray alloc] init];
                NSMutableArray * idMutArray = [[NSMutableArray alloc] init];
                NSMutableArray * urlMutArray = [[NSMutableArray alloc] init];
                [_allDateMutArray addObject:totalJSONModel.date];
               
                NSArray * data = totalJSONModel.stories;
                NSLog(@"data.count = %li - -- - - - - - -- - - ",data.count);
                    for (int i = 0; i < data.count; i++) {
                        StoriesJSONModel * storJSONMOdel = data[i];
                        [titleMutArray addObject:storJSONMOdel.title];
                        [idMutArray addObject:[NSNumber numberWithInteger:storJSONMOdel.id]];
                        NSURL * JSONUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",storJSONMOdel.images[0]]];
                        [urlMutArray addObject:JSONUrl];
                        NSData * imageData = [NSData dataWithContentsOfURL:JSONUrl];
                        UIImage * image = [UIImage imageWithData:imageData];
                        if ( image ){
                            [imageMutArray addObject:image];
                        }
                        
                    }
                [_titleMutArray1 addObject:titleMutArray];
                [_imageMutArray1 addObject:imageMutArray];
                [_idSelfMutArray addObject:idMutArray];
                [_urlImageMutArray addObject:urlMutArray];
            }
            
            NSLog(@"_titleMutArray1 = %@",_titleMutArray1);
            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [_MainView.mainMessageTableView reloadData];
//            });
            
            NSNotification * reloadDateNotification = [NSNotification notificationWithName:@"reloadDataTongZhiController" object:nil];
            [[NSNotificationCenter defaultCenter] postNotification:reloadDateNotification];
        } error:^(NSError *error) {
            NSLog(@"网络请求错误");
        }];
        
    }
    

}

- (void)reloadDataTongZhiController:(NSNotification *)noti
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [_MainView.mainMessageTableView reloadData];
    });
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"_allDateMutArray.count = %li",_allDateMutArray.count);
    return _allDateMutArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZRBNewsTableViewCell * cell1 = nil;
    cell1 = [tableView dequeueReusableCellWithIdentifier:@"messageCell"];
    
    if ( cell1 == nil ){
        cell1 = [[ZRBNewsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"messageCell"];
    }
        if ( _allDateMutArray.count == 1 ){
        if ( _titleMutArray1.count > 0 ){
            NSLog(@"indexPath.row = %li",indexPath.row);
        //cell1.newsLabel.text = _titleMutArray1[indexPath.row];
            
        cell1.newsLabel.text = _titleMutArray1[indexPath.row][0];
//        [_titleMutArray1 removeObjectAtIndex:0];
            
            NSString * urlStr = [NSString stringWithFormat:@"%@",_urlImageMutArray[indexPath.row]];
            NSLog(@"urlStr = %@",urlStr);
        [cell1.newsImageView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
        //[_urlImageMutArray removeObjectAtIndex:0];
        }
    }else{
        if ( _allDateMutArray.count != 0 ){
    cell1.newsLabel.text = _titleMutArray1[indexPath.section][indexPath.row];
    cell1.newsImageView.image = _imageMutArray1[indexPath.section][indexPath.row];
        }
    }
    
    return cell1;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    _headerFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"detailHeaderView"];
    if ( _headerFooterView == nil ){
        _headerFooterView = [[ZRBDetailsTableViewHeaderFooterView alloc] initWithReuseIdentifier:@"detailHeaderView"];
    }
    
    if ( section != 0 ){
    _headerFooterView.dateLabel.text = _allDateMutArray[section];
    }
    return _headerFooterView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ( section != 0 ){
    return 44;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ( _allDateMutArray.count == 1 ){
        return _imageMutArray1.count;
    }
    NSLog(@"section = %li",section);
    NSArray * array = [NSArray arrayWithObject:_imageMutArray1[section]];
    NSInteger i = 0;
    for (NSString * images in array[0]) {
        i++;
    }
    return i;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat minAlphaOffset = -64;
    CGFloat maxAlphaOffect = 200;
    CGFloat offSet = scrollView.contentOffset.y;
    CGFloat alpha = (offSet - minAlphaOffset) / (maxAlphaOffect - minAlphaOffset);
    _barImageView.alpha = alpha;
    NSLog(@"alpla = %.2f",alpha);
    NSLog(@"offSet = %.2f",offSet);
    NSLog(@"_MainView.mainMessageTableView.tableHeaderView.frame.size.height = %.2f",_headerFooterView.frame.size.height);
    if ( alpha > 1 ){
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.14f green:0.51f blue:0.85f alpha:1.00f];
        if ( offSet > _headerFooterView.frame.size.height ){
            self.navigationController.navigationBar.hidden = YES;
        }else{
            self.navigationController.navigationBar.hidden = NO;
        }
    }else{
        self.navigationController.navigationBar.hidden = NO;
    }
    
    
    //弄SDWebImage 试用
    if (scrollView.bounds.size.height + scrollView.contentOffset.y >scrollView.contentSize.height) {
        
        [UIView animateWithDuration:1.0 animations:^{
            
            scrollView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
            
        } completion:^(BOOL finished) {
            
           // NSLog(@"发起上拉加载");
            if ( _refresh ){
                //self.navigationController.navigationBar.hidden = YES;
                //NSLog(@"发起上拉加载assdasdasdsa");
            _MainView.testStr = @"你好,我是中国人";
                ZRBCoordinateMananger * manager = [ZRBCoordinateMananger sharedManager];
                manager.ifAdoultRefreshStr = @"用户已经刷新过一次";
                NSLog(@"manager.ifAdoultRefreshStr = == == = = %@",manager.ifAdoultRefreshStr);
                [self fenethMessageFromManagerBlock:YES];
                _refresh = NO;
            }
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [UIView animateWithDuration:1.0 animations:^{
                    
                    scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
                    
                }];
            });
        }];
        
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"reloadDataTongZhiController" object:nil];
}

- (void)giveCellJSONModelToMainView:(NSMutableArray *)imaMutArray andTitle:(NSMutableArray *)titMutArray
{

    NSLog(@"****************    imaMutArray = == = = =%@",imaMutArray);
    NSLog(@"****************Controlller代理协议里的  _imageMutArray = == = = = = == = %@",_mainImageMutArray1);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    [self pushToWKWebView];
}

- (void)pushToWKWebView
{
    SecondaryMessageViewController * secondMessageViewController = [[SecondaryMessageViewController alloc] init];
    
    ZRBRequestJSONModel * requestJSONModel = [[ZRBRequestJSONModel alloc] init];
    [requestJSONModel setStr];
    if (_allDateMutArray.count == 1) {
        requestJSONModel.idRequestStr = [NSString stringWithFormat:@"%@",_idSelfMutArray[_indexPath.section+_indexPath.row]];
        secondMessageViewController.resaveIdString = [NSString stringWithFormat:@"%@",_idSelfMutArray[_indexPath.section+_indexPath.row]];
        NSInteger intEger = [secondMessageViewController.resaveIdString integerValue];
        NSLog(@"intEger = %li",intEger);
    }else{
        secondMessageViewController.resaveIdString = [NSString stringWithFormat:@"%@",_idSelfMutArray[_indexPath.section][_indexPath.row]];
        requestJSONModel.idRequestStr = [NSString stringWithFormat:@"%@",_idSelfMutArray[_indexPath.section][_indexPath.row]];
    }
    
    NSLog(@"resaveIdString = %@",secondMessageViewController.resaveIdString);
    NSLog(@"requestJSONModel.idRequestStr = %@",requestJSONModel.idRequestStr);
    [self.navigationController pushViewController:secondMessageViewController animated:YES];
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.translucent = NO;
//    self.navigationItem.title = @"每日新闻";
//
//    UIBarButtonItem * leftBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"1.png"] style:UIBarButtonItemStyleDone target:self action:@selector(pressLeftBarButton:)];
//    self.navigationItem.leftBarButtonItem = leftBarButton;
//}

- (void)pressLeftBarButton:(UIBarButtonItem *)leftBtn
{
    NSLog(@"666666");
    if ( _iNum == 0 ){
        [_MainView mas_remakeConstraints:^(MASConstraintMaker *make) {
            //        make.height.mas_equalTo(self.view.bounds.size.height);
            //        make.width.mas_equalTo(
            make.left.equalTo(self.view).offset(250);
            make.top.equalTo(self.view).offset(0);
            make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width-250);
            make.height.mas_equalTo([UIScreen mainScreen].bounds.size.height);
            
            //创建另一个controller
            
            
            
            [_messageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.view);
                make.top.equalTo(self.view).offset(50);
                make.bottom.equalTo(self.view).offset(-50);
                make.width.mas_equalTo(250);
                make.height.mas_equalTo([UIScreen mainScreen].bounds.size.height-100);
            }];
            
            //make.edges.equalTo(self.view);
        }];
        //在这里new 一个新的视图！
        
        //[_aView initScrollView];
        _iNum++;
    }
    
    
    else{
        [_MainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        //在这里new出来的新视图 坐标改变！
        _iNum--;
    }
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
