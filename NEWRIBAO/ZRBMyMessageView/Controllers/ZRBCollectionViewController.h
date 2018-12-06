//
//  ZRBCollectionViewController.h
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/12/6.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZRBCollectionManager.h"
@interface ZRBCollectionViewController : UIViewController 

@property (nonatomic, strong) NSMutableArray * collectionIdMutArray;

@property (nonatomic, assign) NSString * collectionIdString;

//单例
+ (ZRBCollectionViewController *)sharedViewController;

@property (nonatomic, strong) NSMutableArray * titleMutArray;

@property (nonatomic, strong) NSMutableArray * imageMutArray;

- (void)fetchCollectionNewsDataFromCollectionManager;

@end
