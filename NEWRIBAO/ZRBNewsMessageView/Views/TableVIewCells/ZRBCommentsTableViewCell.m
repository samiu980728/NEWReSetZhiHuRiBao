//
//  ZRBCommentsTableViewCell.m
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/11/22.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import "ZRBCommentsTableViewCell.h"
#import <Masonry.h>

@interface ZRBCommentsTableViewCell ()


@end

@implementation ZRBCommentsTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ( self == [super initWithStyle:style reuseIdentifier:reuseIdentifier] ){
        _numOfLineSNumInt = 0;
        [self createUI];
        
    }
    return self;
}

- (void)createUI
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changHeight:) name:@"changHeightNoti" object:nil];
    self.idMutArray = [[NSMutableArray alloc] init];
    self.AlongHeigtCellMutArray = [[NSMutableArray alloc] init];
    self.reply_toAuthorLabel = [[UILabel alloc] init];
    self.reply_toLabel = [[UILabel alloc] init];
    self.timeLabel = [[UILabel alloc] init];
    self.contentLabel = [[UILabel alloc] init];
    self.nameLabel = [[UILabel alloc] init];
    self.approvalButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.avatarImage = [[UIImageView alloc] init];
    self.expandButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.avatarImage.layer.cornerRadius = 25;
    self.avatarImage.layer.masksToBounds = YES;
    
    [self.approvalButton setImage:[UIImage imageNamed:@"8.png"] forState:UIControlStateNormal];
    
    self.reply_toAuthorLabel.numberOfLines = 0;
    
    self.reply_toLabel.numberOfLines = 0;
    self.timeLabel.numberOfLines = 0;
    self.contentLabel.numberOfLines = 0;
    self.nameLabel.numberOfLines = 0;
    
    self.timeLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width ;
    self.nameLabel.preferredMaxLayoutWidth = 60;
//    self.contentLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width ;
    
    [self.timeLabel sizeToFit];
    [self.nameLabel sizeToFit];
    [self.contentLabel sizeToFit];
    
    //[self.contentView addSubview:self.reply_toAuthorLabel];
    [self.contentView addSubview:self.reply_toLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.approvalButton];
    [self.contentView addSubview:self.avatarImage];
    [self.contentView addSubview:_expandButton];

    [self.expandButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentLabel.mas_right).offset(-40);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
        make.top.mas_equalTo(self.reply_toLabel.mas_bottom);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-5);
    }];
    
    [self.avatarImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(5);
        make.right.mas_equalTo(self.contentView.mas_left).offset(58);
        make.bottom.mas_equalTo(self.contentView.mas_top).offset(65);
        make.top.mas_equalTo(self.contentView.mas_top).offset(10);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avatarImage.mas_right).offset(10);
        make.top.mas_equalTo(self.contentView.mas_top).offset(10);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-150);
        //改了
        make.height.mas_equalTo(20);
        
        //没改之前
        //make.bottom.mas_equalTo(self.contentView.mas_top).offset(30);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //改之前
        make.top.mas_equalTo(self.nameLabel.mas_bottom);
        make.left.mas_equalTo(self.avatarImage.mas_right).offset(10);
        make.right.mas_equalTo(-20);
    }];
    
    [self.reply_toLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentLabel.mas_bottom);
        make.left.mas_equalTo(self.avatarImage.mas_right).offset(10);
        make.right.mas_equalTo(-20);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.reply_toLabel.mas_bottom);
        //改之前
        make.left.mas_equalTo(self.avatarImage.mas_right).offset(10);
        make.right.mas_equalTo(-10);
        
        make.height.mas_equalTo(20);
#pragma mark  疑问下面这个一加 就不行啦 没有自适应的作用
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-10);
    }];
    
    [self.approvalButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentLabel.mas_right).offset(-40);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
        make.top.mas_equalTo(self.contentView.mas_top);
        make.bottom.mas_equalTo(self.contentView.mas_top).offset(30);
    }];
    //下一步  照片网络请求错误  看看到底咋回事
    _ifSetMessageFlag = 0;
  //  dispatch_async(dispatch_get_main_queue(), ^{
    //});
    NSInteger num = _reply_toLabel.numberOfLines;
    NSLog(@"num = %li",num);
}

- (void)changeNumberOfLines
{
//    if ( _expandButton.selected ){
    _reply_toLabel.numberOfLines = 2;
//    }
//    else{
//        _reply_toLabel.numberOfLines = 0;
//    }
}

-(void)zeroToChangeNumberOfLines
{
    _reply_toLabel.numberOfLines = 0;
}

//还是 不行 在setMessage尝试打印numberOfLines 看看 通知传值传成功了没
- (void)setMessage:(ZRBCommentsJSONModel *)message
{
    if ( _expandButton.selected ){
        NSLog(@"asdas");
    }
    else if ( !_expandButton.selected ){
    
        NSLog(@"asd1232112");
        
    }
    //[self.lock lock];
    NSLog(@"111_reply_toLabel.nu = %li",_reply_toLabel.numberOfLines);
    _contentSize = 0;
    _nameSize = 0;
    _timeSize = 0;
    _reply_toSize = 0;
    _flodReply_toSize = 0;
    self.reply_toLabel.text = @"";
    ZRBReplyToJSONModel * storyModel = [message valueForKey:@"reply_to"];
    NSString * replyContentStr = [NSString stringWithFormat:@"%@",[storyModel valueForKey:@"content"]];
    NSString * replyAuthorStr = [NSString stringWithFormat:@"%@",[storyModel valueForKey:@"author"]];
    
    replyContentStr = [replyContentStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    replyContentStr = [replyContentStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    replyContentStr = [replyContentStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    replyAuthorStr = [replyAuthorStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    replyAuthorStr = [replyAuthorStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    replyAuthorStr = [replyAuthorStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    
    NSString * allReplyStr = [[NSString alloc] init];
    NSString * contString = [NSString stringWithFormat:@"%@",[message valueForKey:@"content"]];
    
    contString = [contString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    contString = [contString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    contString = [contString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    self.contentLabel.font = [UIFont systemFontOfSize:16];
    self.contentLabel.text = contString;
    _contentSize = [contString boundingRectWithSize:CGSizeMake(326, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size.height;
    NSLog(@"_contentLabel.text = %@",_contentLabel.text);
    NSLog(@"_contentSize = %li",(long)_contentSize);
    
    NSLog(@"replyContentStr = %@",replyContentStr);
    NSLog(@"replyAuthorStr = %@",replyAuthorStr);
    
    self.reply_toLabel.font = [UIFont systemFontOfSize:16];
    
    if ( ![[NSString stringWithFormat:@"%@",replyContentStr] isEqualToString:@"(null)"] ){
        self.reply_toLabel.textColor = [UIColor grayColor];
        //这里还没有把字符串添加进去
        allReplyStr = [NSString stringWithFormat:@"//%@: %@",replyAuthorStr,replyContentStr];
        self.reply_toLabel.font = [UIFont systemFontOfSize:16];
        self.reply_toLabel.text = allReplyStr;
        NSLog(@"allReplyStr = %@",allReplyStr);
        
        
        
        //知道问题出在哪了！！！！
        //在这里必须在 attributes 中也要加_numOfLineSNumInt 这个条件！！！ 不然每次计算的都是这些文字的总高度
        //按326 宽度来算！！！  所以有的时候计算numberOfLines的确对了 但是返回的高度还是原来的高度！！！
        //笨办法: 因为此时已经能得到正确的numberOfLines 了
        //所以判断 如果numOfLines == 2 那么直接返回一个固定的高度给_reply_toSize
        //如果 numberOfLines == 0 那么再计算他的实际高度！！！！
        
        
        
        
        
        
        
        
        
        
        
        
        _reply_toSize = [allReplyStr boundingRectWithSize:CGSizeMake(326, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size.height;
        CGFloat realReplySize = _reply_toSize;
        NSInteger skt = _reply_toLabel.numberOfLines;
        NSLog(@"skt = %li",_reply_toLabel.numberOfLines);
        NSLog(@"realReplySize = %.2f",realReplySize);
        
        if ( realReplySize > 50 ){
                NSLog(@"122realReplySize = %.2f",realReplySize);
                [_expandButton setTitle:@"展开" forState:UIControlStateNormal];
                [_expandButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [_expandButton setBackgroundColor:[UIColor yellowColor]];
                _flodReply_toSize = _reply_toSize;
//            if ( !_expandButton.selected ){
//            _reply_toSize = 50;
//            }
            //另一个方法  直接改变 _reply_toSize
            }
        else if (realReplySize < 50){
            
        }
    }
    NSString * naStr = [NSString stringWithFormat:@"%@",[message valueForKey:@"author"]];
    _nameSize = [naStr boundingRectWithSize:CGSizeMake(80, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size.height;
    self.nameLabel.text = naStr;
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSTimeZone * timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    
    NSString * realTimeStr = [NSString stringWithFormat:@"%@",[message valueForKey:@"time"]];
    NSTimeInterval time = [realTimeStr doubleValue];
    NSDate * detailDate = [NSDate dateWithTimeIntervalSince1970:time];
    
    NSString * confromTimespStr = [formatter stringFromDate:detailDate];
    NSLog(@"confromTimespStr = %@",confromTimespStr);
    
    self.timeLabel.font = [UIFont systemFontOfSize:13];
    _timeSize = [confromTimespStr boundingRectWithSize:CGSizeMake(300, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.height;
    self.timeLabel.text = confromTimespStr;
    CGFloat allSize = _timeSize + _contentSize + _nameSize + _reply_toSize;
    NSLog(@"allSize = %li",(long)allSize);
    
    NSMutableAttributedString * finalContentStr = [[NSMutableAttributedString alloc] init];
    NSAttributedString * contentString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",[message valueForKey:@"content"]] attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16], NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    NSMutableAttributedString * finalNameStr = [[NSMutableAttributedString alloc] init];
    NSAttributedString * nameString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",[message valueForKey:@"author"]] attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16], NSForegroundColorAttributeName: [UIColor blackColor]}];
    NSMutableAttributedString * finalTimeStr = [[NSMutableAttributedString alloc] init];
    
    NSAttributedString * timeString = [[NSAttributedString alloc] initWithString:confromTimespStr attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13], NSForegroundColorAttributeName: [UIColor grayColor]}];
    [finalTimeStr appendAttributedString:timeString];
    [finalNameStr appendAttributedString:nameString];
    [finalContentStr appendAttributedString:contentString];
    NSString * urlStr = [NSString stringWithFormat:@"%@",[message valueForKey:@"avatar"]];
    [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL * url = [NSURL URLWithString:urlStr];
    NSData * imageData = [NSData dataWithContentsOfURL:url];
    UIImage * avatarImage = [UIImage imageWithData:imageData];
    self.avatarImage.image = avatarImage;
    
    self.approvalButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.approvalButton setTitle:[NSString stringWithFormat:@"%@",[message valueForKey:@"likes"]] forState:UIControlStateNormal];
    [self.approvalButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    NSLog(@"self.avatarImage.image = %@",self.avatarImage.image);
    //[self.lock unlock];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"changHeightNoti" object:nil];
}

- (void)changHeight:(NSNotification *)noti
{
//    NSDictionary * dict = [noti object];
//    NSInteger numberOfLines = [[dict valueForKey:@"numberOfLines"] integerValue];
//    _numOfLineSNumInt = numberOfLines;
//    self.reply_toLabel.numberOfLines = numberOfLines;
}

- (CGFloat)heightForModel:(ZRBCommentsJSONModel *)message
{
    //[self.lock lock];
    [self setMessage:message];
    [self layoutIfNeeded];
    
    //CGFloat cellHeight = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 100;
    
    
    //这也有可能需要变
    CGFloat allHeight = _contentSize + _timeSize + _nameSize + _reply_toSize + 30;
    
    NSLog(@"allHeight = %li",(long)allHeight);
    //[self.lock unlock];
    return allHeight;
}

//问学姐不加时间标签 的约束 下面高了一节怎么办


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
