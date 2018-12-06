//
//  ZRBCollectionViewController.m
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/12/6.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import "ZRBCollectionViewController.h"

@interface ZRBCollectionViewController ()

@end

@implementation ZRBCollectionViewController
static ZRBCollectionViewController * viewController = nil;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    _viewController = [[SecondaryMessageViewController alloc] init];
//    _viewController.collectionDelegete = self;
    //self.viewController.delegate = self;
    [self fetchCollectionNewsDataFromCollectionManager];
}

+ (ZRBCollectionViewController *)sharedViewController
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        viewController = [[self alloc] init];
    });
    return viewController;
}

//- (void)giveIdCollectionToViewController:(NSString *)idString
//{
//    _collectionIdString = idString;
//}

- (void)fetchCollectionNewsDataFromCollectionManager
{
    _titleMutArray = [[NSMutableArray alloc] init];
    _imageMutArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < _collectionIdMutArray.count; i++) {
        _collectionIdString = _collectionIdMutArray[i];
        [[ZRBCollectionManager sharedManager] fetchNewCollectionDataWithidString:_collectionIdString Succeed:^(ZRBCollectiionJSONModel *mainMessageJSONModel) {
            NSString * titleString = [NSString stringWithFormat:@"%@",mainMessageJSONModel.title];
            NSURL * imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",mainMessageJSONModel.image]];
            NSData * imageData = [NSData dataWithContentsOfURL:imageUrl];
            UIImage * image = [UIImage imageWithData:imageData];
            [_titleMutArray addObject:titleString];
            [_imageMutArray addObject:image];
        } error:^(NSError *error) {
            NSLog(@"error :   %@",error);
        }];
    }
    
}

//- (NSMutableArray *)collectionIdMutArray
//{
//    if ( !_collectionIdMutArray ){
//        _collectionIdMutArray = [[NSMutableArray alloc] init];
//    }
//    return _collectionIdMutArray;
//}

- (NSMutableArray *)titleMutArray
{
    if ( !_titleMutArray ){
        _titleMutArray = [[NSMutableArray alloc] init];
    }
    return _titleMutArray;
}

- (NSMutableArray *)imageMutArray
{
    if ( !_imageMutArray ){
        _imageMutArray = [[NSMutableArray alloc] init];
    }
    return _imageMutArray;
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
