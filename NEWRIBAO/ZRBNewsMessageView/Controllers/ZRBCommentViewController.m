//
//  ZRBCommentViewController.m
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/11/19.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import "ZRBCommentViewController.h"
#import <Masonry.h>
#import "ZRBCommentsTableViewCell.h"
@interface ZRBCommentViewController ()

@property (nonatomic, strong) ZRBCommentsTableViewCell * tempCell;

@property (nonatomic, strong) ZRBCommentsTableViewCell * shortTempCell;

@property (nonatomic, strong) ZRBLongCommentsJSONModel * allcommentsJSONModel;

@end

@implementation ZRBCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _realRideInteger = 0;
    
    _authorMutArray = [[NSMutableArray alloc] init];
    _contentMMutArray = [[NSMutableArray alloc] init];
    _avatorMutArray = [[NSMutableArray alloc] init];
    _timeMutArray = [[NSMutableArray alloc] init];
    _reply_toMutArray = [[NSMutableArray alloc] init];
    _onlyIdMutArray = [[NSMutableArray alloc] init];
    _likesMutArray = [[NSMutableArray alloc] init];
    _allDataMutArray = [[NSMutableArray alloc] init];
    
    _allShortDataMutArray = [[NSMutableArray alloc] init];
    _shortTimeMutArray = [[NSMutableArray alloc] init];
    _shortLikesMutArray = [[NSMutableArray alloc] init];
    _shortAuthorMutArray = [[NSMutableArray alloc] init];
    _shortAvatorMutArray = [[NSMutableArray alloc] init];
    _shortOnlyIdMutArray = [[NSMutableArray alloc] init];
    _shortContentMMutArray = [[NSMutableArray alloc] init];
    _shortReplyMutArray = [[NSMutableArray alloc] init];
//    _realLongCommentsInteger = 0;
//    _realShortCommentsInteger = 0;
    self.allcommentsJSONModel = [[ZRBLongCommentsJSONModel alloc] init];
    _longCommentsNumInteger = 0;
    _shortCommentsNumInteger = 0;
    
    self.title = [NSString stringWithFormat:@"%@ comments",[NSNumber numberWithInteger:_allCommentsNumInteger]];
    [self fenethLongCommentsFromJSONModel];
    self.commentView = [[ZRBCommentView alloc] init];
    [self.commentView.tableView registerClass:[ZRBCommentsTableViewCell class] forCellReuseIdentifier:@"commentCell"];
    [self.commentView.tableView registerClass:[ZRBCommentsTableViewCell class] forCellReuseIdentifier:@"shortCommentCell"];
    [self.commentView.tableView registerClass:[ZRBCommentsTableViewHeaderView class] forHeaderFooterViewReuseIdentifier:@"commentsHeaderView"];
    
    
    _commentView.tableView.delegate = self;
    _commentView.tableView.dataSource = self;
    _commentView.tableView.estimatedRowHeight = 100;
    _commentView.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:_commentView];
    [self.commentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.tempCell = [[ZRBCommentsTableViewCell alloc] initWithStyle:0 reuseIdentifier:@"commentCell"];
    self.shortTempCell = [[ZRBCommentsTableViewCell alloc] initWithStyle:0 reuseIdentifier:@"shortCommentCell"];
    
    _nowSection = 0;
    _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_selectButton setImage:[UIImage imageNamed:@"9.png"] forState:UIControlStateNormal];
    [_selectButton addTarget:self action:@selector(spreadCellSection:) forControlEvents:UIControlEventTouchUpInside];
    _flag = 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"_realShortCommentsInteger = %li",_realShortCommentsInteger);
    if ( section == 0 && _longCommentsNumInteger == 0 ){
        return 1;
    }
    if ( section == 0 && _longCommentsNumInteger != 0 ){
        return _longCommentsNumInteger;
    }
    //第一组存在 第二组数量总是1 Row 第一组那种存在 第一组数量为1；
    if ( section == 1 ){
        if ( _realShortCommentsInteger > 20 ){
            _realShortCommentsInteger = 19;
            return 19;
        }
        return _realShortCommentsInteger;
    }
        return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSLog(@"_realShortCommentsInteger = %li",_realShortCommentsInteger);
    _commentsHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"commentCell"];
    if ( _commentsHeaderView == nil ){
        _commentsHeaderView = [[ZRBCommentsTableViewHeaderView alloc] initWithReuseIdentifier:@"commentCell"];
    }
    if ( section == 0 && _longCommentsNumInteger != 0 ){
        _commentsHeaderView.commentsNumLabel.text = [NSString stringWithFormat:@"%li longComments",_realLongCommentsInteger];
    }
    else if (section == 0 && _longCommentsNumInteger == 0 ){
        _commentsHeaderView.commentsNumLabel.text = @" ";
    }
    else if (section == 1){
        _commentsHeaderView.commentsNumLabel.text = [NSString stringWithFormat:@"%li shortComments",_realShortCommentsInteger];
//        UIButton * _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_selectButton setImage:[UIImage imageNamed:@"9.png"] forState:UIControlStateNormal];
//        [_selectButton addTarget:self action:@selector(spreadCellSection:) forControlEvents:UIControlEventTouchUpInside];
        [_commentsHeaderView addSubview:_selectButton];
        [_selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_commentsHeaderView.mas_right).offset(-80);
            make.right.equalTo(_commentsHeaderView.mas_right);
            make.height.mas_equalTo(_commentsHeaderView.mas_height);
        }];
        _nowSection = section;
    }
    return _commentsHeaderView;
}

- (void)spreadCellSection:(UIButton *)btn
{
    btn.selected = !btn.selected;
    
    NSIndexSet * indexSet = [[NSIndexSet alloc] initWithIndex:_nowSection];
    if ( btn.selected ){
        _flag++;
    }else{
        _flag--;
    }
    [_commentView.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
    
//    通过协议传值把头视图弄到顶部
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ( section == 0 && _longCommentsNumInteger != 0 ){
        return 50;
    }
    else if (section == 0 && _longCommentsNumInteger == 0){
        return 0.1;
    }
    else if(section == 1){
        return 50;
    }
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( indexPath.section == 0 && _longCommentsNumInteger != 0 ){
        if ( [self.allDataMutArray isKindOfClass:[NSArray class]] && self.allDataMutArray.count > 0 ){
    CGFloat cellHeight = [self.tempCell heightForModel:_allDataMutArray[0][indexPath.row]];
    return cellHeight;
        }else{
            return 300;
        }
    }
    else if (indexPath.section == 1 && _shortCommentsNumInteger != 0 ){
        if ( [self.allShortDataMutArray isKindOfClass:[NSArray class]] && self.allShortDataMutArray.count > 0 ){
            CGFloat cellHeight = [self.shortTempCell heightForModel:_allShortDataMutArray[0][indexPath.row]];
            return cellHeight;
        }
    }
        return 300;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZRBCommentsTableViewCell * cell = nil;
    ZRBCommentsTableViewCell * shortCell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"commentCell"];
    shortCell = [tableView dequeueReusableCellWithIdentifier:@"shortCommentCell"];
    if ( cell == nil ){
        cell = [[ZRBCommentsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"commentCell"];
    }
    if ( shortCell == nil ){
        shortCell = [[ZRBCommentsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"shortCommentCell"];
    }
    
    if ( indexPath.section == 0 && _longCommentsNumInteger != 0 ){
        if ( [self.allDataMutArray isKindOfClass:[NSArray class]] && self.allDataMutArray.count > 0 ){
    [cell setMessage:self.allDataMutArray[0][indexPath.row]];
        }
        return cell;
    }
    
    if ( indexPath.section == 0 && _longCommentsNumInteger == 0 && _realRideInteger == 1 ){
        UIImageView * imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"10.jpg"];
        [cell.contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView);
        }];
        return cell;
    }
    
    if ( indexPath.section == 1 && _shortCommentsNumInteger != 0 ){
        if ( [self.allShortDataMutArray isKindOfClass:[NSArray class]] && self.allShortDataMutArray.count > 0 ){
            NSArray * array = [NSArray arrayWithObject:_allShortDataMutArray[0]];
            NSLog(@"array.count = %li",array.count);
            
            //这里出问题 打印  _allShortDataMutArray
            [shortCell setMessage:_allShortDataMutArray[0][indexPath.row]];
        }
        NSInteger j = 0;
        if ( _flag == 0 ){
            shortCell.hidden = YES;
        }else{
            shortCell.hidden = NO;
            
        }
    }
    return shortCell;
}



- (void)fenethLongCommentsFromJSONModel
{
    [[ZRBCommentManager sharedManager] fetchCommentsNumDataFormNewsViewWithIdString:_secondResaveIdString Succeed:^(ZRBNewsAdditionalJSONModel *additionalJSONModel) {
        _realRideInteger = 1;
        _longCommentsNumInteger = 0;
        if ( additionalJSONModel.long_comments != 0 ){
            //执行长评论网络请求
            [[ZRBCommentManager sharedManager] fetchLongLongCommentsDataFromNewsViewWith:_secondResaveIdString Succeed:^(ZRBLongCommentsJSONModel *longCommentsJSONModel) {
                self.allcommentsJSONModel = longCommentsJSONModel;
                NSMutableArray * dataArray = [[NSMutableArray alloc] init];
                [dataArray addObject:longCommentsJSONModel.comments];
                [_allDataMutArray addObject:longCommentsJSONModel.comments];
                NSLog(@"dataArray[0][0] = %@",dataArray[0][0]);
                //接收所有数据
                _longCommentsNumInteger = additionalJSONModel.long_comments;
                //1.创建一个数组接收 author
                [_authorMutArray addObject:[longCommentsJSONModel.comments valueForKey:@"author"]];
                [_contentMMutArray addObject:[longCommentsJSONModel.comments valueForKey:@"content"]];
                [_avatorMutArray addObject:[longCommentsJSONModel.comments valueForKey:@"avatar"]];
                [_onlyIdMutArray addObject:[longCommentsJSONModel.comments valueForKey:@"id"]];
                [_likesMutArray addObject:[longCommentsJSONModel.comments valueForKey:@"likes"]];
                [_timeMutArray addObject:[longCommentsJSONModel.comments valueForKey:@"time"]];
                ZRBReplyToJSONModel * replyJSONModel = [[ZRBReplyToJSONModel alloc] init];
                replyJSONModel = [longCommentsJSONModel.comments valueForKey:@"reply_to"];
                NSString * replyStr = [NSString stringWithFormat:@"%@",replyJSONModel];
                NSLog(@"replyStr = %@",replyStr);
                if ( ![replyStr isEqualToString:@"(\n    \"<null>\",\n    \"<null>\",\n    \"<null>\"\n)"]){
                [_reply_toMutArray addObject:[longCommentsJSONModel.comments valueForKey:@"reply_to"]];
                }
                
                //不知道这里需不需要更新视图 可以尝试一下
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.commentView.tableView reloadData];
                });
            } error:^(NSError *error) {
                NSLog(@"网络请求出错： %@",error);
            }];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self.commentView.tableView reloadData];
//            });
            
        }
        if ( additionalJSONModel.short_comments != 0 ){
            [[ZRBCommentManager sharedManager] fetchShortShortCommentsDataFromNewsWith:_secondResaveIdString Succeed:^(ZRBLongCommentsJSONModel *longCommentsJSONModel) {
                self.allcommentsJSONModel = longCommentsJSONModel;
                _shortCommentsNumInteger = additionalJSONModel.short_comments;
                NSMutableArray * dataArray = [[NSMutableArray alloc] init];
                [dataArray addObject:longCommentsJSONModel.comments];
                [_allShortDataMutArray addObject:longCommentsJSONModel.comments];
                //1.创建一个数组接收 author
                [_shortAuthorMutArray addObject:[longCommentsJSONModel.comments valueForKey:@"author"]];
                [_shortContentMMutArray addObject:[longCommentsJSONModel.comments valueForKey:@"content"]];
                [_shortAvatorMutArray addObject:[longCommentsJSONModel.comments valueForKey:@"avatar"]];
                [_shortOnlyIdMutArray addObject:[longCommentsJSONModel.comments valueForKey:@"id"]];
                [_shortLikesMutArray addObject:[longCommentsJSONModel.comments valueForKey:@"likes"]];
                [_shortTimeMutArray addObject:[longCommentsJSONModel.comments valueForKey:@"time"]];
                
                ZRBReplyToJSONModel * replyJSONModel = [[ZRBReplyToJSONModel alloc] init];
                replyJSONModel = [self.allcommentsJSONModel.comments valueForKey:@"reply_to"];
                NSString * replyStr = [NSString stringWithFormat:@"%@",replyJSONModel];
                NSLog(@"replyStr = %@",replyStr);
               // if ( ![replyStr isEqualToString:@"(\n    \"<null>\",\n    \"<null>\",\n    \"<null>\"\n)"]){
                    [_shortReplyMutArray addObject:[self.allcommentsJSONModel.comments valueForKey:@"reply_to"]];
                //}
                NSInteger i = 0;
                for (i = 0; i < 10; i++) {
                    //if ( [[NSString stringWithFormat:@"%@",_shortReplyMutArray[i]] isEqualToString:@"<null>"] ){
                        NSLog(@"str = %@",_shortReplyMutArray[0][i]);
                   // }
                    
                    //这个管用
                    
                    if ( [[NSString stringWithFormat:@"%@",_shortReplyMutArray[0][i]] isEqualToString:@"<null>"] ){
                    NSLog(@"123str = %@",_shortReplyMutArray[0][i]);
                     }
                }
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.commentView.tableView reloadData];
                });
            } error:^(NSError *error) {
                NSLog(@"网络请求出错： %@",error);
            }];
        }
        
        else{
            _longCommentsNumInteger = 0;
            _shortCommentsNumInteger = 0;
        }
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.commentView.tableView reloadData];
//        });
    } error:^(NSError *error) {
        NSLog(@"网络请求失败：原因  %@",error);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
//    self.navigationController.navigationItem.leftBarButtonItem = nil;
}

//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    self.navigationController.navigationBar.hidden = NO;
//}

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
