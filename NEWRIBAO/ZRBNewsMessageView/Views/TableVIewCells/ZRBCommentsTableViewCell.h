//
//  ZRBCommentsTableViewCell.h
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/11/22.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZRBLongCommentsJSONModel.h"
@interface ZRBCommentsTableViewCell : UITableViewCell

- (void)setMessage:(ZRBCommentsJSONModel *)message;

- (CGFloat)heightForModel:(ZRBCommentsJSONModel *)message;

@property (nonatomic, assign) CGFloat contentSize;

@property (nonatomic, assign) CGFloat timeSize;


@property (nonatomic, assign) CGFloat nameSize;

@property (nonatomic, assign) CGFloat reply_toSize;

@property (nonatomic, assign) CGFloat flodReply_toSize;

@property (nonatomic, strong) UIButton * expandButton;
@end
