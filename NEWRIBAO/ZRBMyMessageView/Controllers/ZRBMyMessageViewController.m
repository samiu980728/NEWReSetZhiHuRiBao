//
//  ZRBMyMessageViewController.m
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/10/28.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import "ZRBMyMessageViewController.h"
#import <Masonry.h>
@interface ZRBMyMessageViewController ()

@end

@implementation ZRBMyMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.userInteractionEnabled = YES;
    [self.view setBackgroundColor:[UIColor darkGrayColor]];
    
    _iNum = 0 ;
//    ZRBMessageVView * messageView = [[ZRBMessageVView alloc] initWithFrame:CGRectMake(-320, 0, 320, [UIScreen mainScreen].bounds.size.height)];
//    messageView.userInteractionEnabled = YES;
//    messageView.backgroundColor = [UIColor whiteColor];
//
////    messageView.frame = CGRectMake(-320, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
//    //messageView.frame = CGRectMake(-320, 0, 320, [UIScreen mainScreen].bounds.size.height);
////    messageView.mainNewsButton.backgroundColor = [UIColor blackColor];
//
//
//#pragma mark 问题： 点击事件无法响应
//    [messageView.mainNewsButton addTarget:self action:@selector(pressMainNewsButton:) forControlEvents:UIControlEventTouchUpInside];
//    [messageView.collectionButton addTarget:self action:@selector(pressCollectionButton:) forControlEvents:UIControlEventTouchUpInside];
//
//    [self.view addSubview:messageView];
    
    
    
    
    
    
    
    
    
    
    
    
    
#pragma mark
//    12.5 按钮那个问题待解决
//    headerView复用问题待解决
//    开始弄点赞动画相关
    
    
    
    
    
    
    
    
    
    
    [self addMenuItems];
    self.view.frame = CGRectMake(-320, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
}

- (void)pressCollectionButton:(UIButton *)idSender
{
    NSLog(@"22333333333");
}

- (void)pressMainNewsButton:(UIButton *)sender
{
    NSLog(@"22333333333");
    //判断是否响应这个代理方法
    if ([self.delegate respondsToSelector:@selector(menuContoller:didSelectitemAtIndex:)]){
        [self.delegate menuContoller:self didSelectitemAtIndex:sender.tag-1];
    }
}

- (void)addMenuItems
{
    UIButton * mainNewsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [mainNewsButton setTitle:@"首页" forState:UIControlStateNormal];
    mainNewsButton.titleLabel.font = [UIFont systemFontOfSize:20];
    mainNewsButton.tag = 1;
    mainNewsButton.backgroundColor = [UIColor whiteColor];
    [mainNewsButton addTarget:self action:@selector(menuItemselected:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mainNewsButton];
    [mainNewsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view).offset(100);
        make.width.mas_equalTo(320);
        make.height.mas_equalTo(40);
    }];
}

//选中菜单
- (void)menuItemselected:(UIButton *)sender
{
    NSLog(@"22333333333");
    //判断是否响应这个代理方法
    if ([self.delegate respondsToSelector:@selector(menuContoller:didSelectitemAtIndex:)]){
        [self.delegate menuContoller:self didSelectitemAtIndex:sender.tag-1];
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

