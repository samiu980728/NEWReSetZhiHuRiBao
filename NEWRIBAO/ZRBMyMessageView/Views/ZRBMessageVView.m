//
//  ZRBMessageVView.m
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/10/28.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import "ZRBMessageVView.h"
#import <Masonry.h>
@implementation ZRBMessageVView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if ( self ){
        self.presonImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.presonImageButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(30);
            make.top.mas_equalTo(self.mas_top).offset(30);
            make.height.mas_equalTo(50);
            make.width.mas_equalTo(self.mas_width);
        }];
        [self addSubview:self.presonImageButton];
        
        self.collectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.collectionButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(10);
            //明天继续先弄自定义的这个Button的 Masonry布局
            
            
            
            
            
            
            
            
            
        }];
        
        
        [self addSubview:self.collectionButton];
        
        self.newsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [self addSubview:self.newsButton];
        
        self.setButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [self addSubview:self.setButton];
        
        self.mainNewsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        
        [self addSubview:self.mainNewsButton];
        
    }
    return self;
}





- (void)initView
{
    _mainView = [[UIView alloc] init];
    _mainView.backgroundColor = [UIColor yellowColor];
    _guideButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_guideButton setImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
    //_guideButton.frame = CGRectMake(30, 30, 30, 30);
    
    self.backgroundColor = [UIColor yellowColor];
    //[_mainView addSubview:_guideButton];
    //[self addSubview:_guideButton];
    //[self.view addSubview:_guideButton];
    
    //[self addSubview:_mainView];
    
    [self addSubview:_guideButton];
    
    //    [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.edges.mas_equalTo(self);
    //    }];
    
    [_guideButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.top.equalTo(self).offset(20);
        //        make.left.mas_offset(20);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
}

- (void)initScrollView
{
    
    _messageScrollew = [[UIScrollView alloc] init];
    _messageScrollew.backgroundColor = [UIColor darkGrayColor];
    //[_mainView addSubview:_messageScrollew];
    
    [self addSubview:_messageScrollew];
    
    [_messageScrollew mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(self).offset(0);
        
        make.top.equalTo(self).offset(0);
        
        make.width.mas_equalTo(250);
        make.height.mas_equalTo([UIScreen mainScreen].bounds.size.height);
    }];
}

- (void)initMainTableView
{
    
}

//接收通知后调用的方法
- (void)changJSONModel:(NSNotification *)noti
{
    if ( [_analyJSONModel.JSONModelMut isKindOfClass:[NSArray class]] && _analyJSONModel.JSONModelMut.count > 0 ){
        _analyJSONMutArray = [NSMutableArray arrayWithArray:_analyJSONModel.JSONModelMut];
    }
    NSLog(@"_analyJSONMutArray = %@",_analyJSONMutArray);
    _mainMessageTableView = [[UITableView alloc] init];
    
    _mainMessageTableView.delegate = self;
    _mainMessageTableView.dataSource = self;
    [self addSubview:_mainMessageTableView];
    
    [_mainMessageTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self).offset(100);
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width);
        make.height.mas_equalTo([UIScreen mainScreen].bounds.size.height);
    }];
}

- (void)initTableView
{
    _messageTableView = [[UITableView alloc] init];
    
    [_messageTableView registerClass:[ZRBMessageTableViewCell class] forCellReuseIdentifier:@"messageCell"];
    
    _messageTableView.delegate = self;
    _messageTableView.dataSource = self;
    
    [self addSubview:_messageTableView];
    
    //给tableView 的高度 记得在下面留下50  因为还有 完成 和 夜间两个按钮
    [_messageTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.left.equalTo(self);
        //        make.top.equalTo(self);
        //        make.bottom.equalTo(self).offset(-50);
        //        make.width.mas_equalTo(250);
        //        make.height.mas_equalTo([UIScreen mainScreen].bounds.size.height-50);
        
        make.edges.equalTo(self);
    }];
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZRBMessageTableViewCell * cell = nil;
    
    cell = [_messageTableView dequeueReusableCellWithIdentifier:@"messageCell" forIndexPath:indexPath];
    cell.nameLabel.text = @"萨缪";
    cell.nameLabel.font = [UIFont systemFontOfSize:13];
    cell.imageLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"122.jpg"]];
    return cell;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 13;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}




/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end

