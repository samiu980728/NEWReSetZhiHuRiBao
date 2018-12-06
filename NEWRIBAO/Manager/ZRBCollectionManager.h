//
//  ZRBCollectionManager.h
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/12/6.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZRBMainJSONModel.h"
#import "ZRBCollectiionJSONModel.h"
typedef void(^ZRBGetLastestNewsHandle)(ZRBCollectiionJSONModel * mainMessageJSONModel);

typedef void(^ErrorHandle)(NSError * error);

@interface ZRBCollectionManager : NSObject

+ (instancetype)sharedManager;

- (void)fetchBeforeCollectionDataWithIdString:(NSString *)idString Succeed:(ZRBGetLastestNewsHandle)succeedBlock error:(ErrorHandle)errorBlock;

- (void)fetchNewCollectionDataWithidString:(NSString *)idString Succeed:(ZRBGetLastestNewsHandle)succeedBlock error:(ErrorHandle)errorBlock;

@end
