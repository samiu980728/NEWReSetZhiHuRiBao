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

@property (nonatomic, strong) UILabel * timeLabel;

@property (nonatomic, strong) UILabel * avatarImageLabel;

@property (nonatomic, strong) UILabel * nameLabel;

@property (nonatomic, strong) UILabel * contentLabel;

@property (nonatomic, strong) UILabel * approvalLabel;

@property (nonatomic, strong) UIButton * approvalButton;

@property (nonatomic, strong) UIImageView * avatarImage;

@property (nonatomic, strong) UILabel * reply_toLabel;

@property (nonatomic, strong) UILabel * reply_toAuthorLabel;
@end

@implementation ZRBCommentsTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ( self == [super initWithStyle:style reuseIdentifier:reuseIdentifier] ){
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    self.reply_toAuthorLabel = [[UILabel alloc] init];
    self.reply_toLabel = [[UILabel alloc] init];
    self.timeLabel = [[UILabel alloc] init];
    self.contentLabel = [[UILabel alloc] init];
    self.nameLabel = [[UILabel alloc] init];
    self.approvalButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.avatarImage = [[UIImageView alloc] init];
    
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
        make.bottom.mas_equalTo(self.contentView.mas_top).offset(30);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //改之前
        #pragma mark   为什么这里加上70 就OK 了？？？？ 不加70 + 1 的话评论就会隐藏一部分！！！！！！
//        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(10);
        make.top.mas_equalTo(self.nameLabel.mas_bottom);
        make.left.mas_equalTo(self.avatarImage.mas_right).offset(10);
        make.right.mas_equalTo(-20);
        //make.bottom.mas_equalTo(self.timeLabel.mas_top);
        //改之前
//        make.bottom.mas_equalTo(self.timeLabel.mas_top).offset(-10);
    }];
    
//    [self.reply_toAuthorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.contentLabel.mas_bottom);
//        make.left.mas_equalTo(self.avatarImage.mas_right).offset(10);
//        make.right.mas_equalTo(self.reply_toLabel.mas_left);
//    }];
    
    [self.reply_toLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentLabel.mas_bottom);
        make.left.mas_equalTo(self.avatarImage.mas_right).offset(10);
        make.right.mas_equalTo(-20);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.reply_toLabel.mas_bottom);
        //改之前
        #pragma mark   为什么这里加上70 就OK 了？？？？ 不加70 + 1 的话评论就会隐藏一部分！！！！！！
//        make.top.mas_equalTo(self.contentLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(self.avatarImage.mas_right).offset(10);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(self.reply_toLabel.mas_bottom).offset(20);
        //改之前
        #pragma mark   为什么这里加上70 就OK 了？？？？ 不加70 + 1 的话评论就会隐藏一部分！！！！！！
//        make.bottom.mas_equalTo(-10).offset(-20);
    }];
    
    [self.approvalButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentLabel.mas_right).offset(-40);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
        make.top.mas_equalTo(self.contentView.mas_top);
        make.bottom.mas_equalTo(self.contentView.mas_top).offset(30);
    }];
    //下一步  照片网络请求错误  看看到底咋回事
}

- (void)setMessage:(ZRBCommentsJSONModel *)message
{
    
    //下一步 点击头视图 上移
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    _reply_toSize = 0;
    self.reply_toLabel.text = @"";
    ZRBReplyToJSONModel * storyModel = [message valueForKey:@"reply_to"];
    NSString * replyContentStr = [NSString stringWithFormat:@"%@",[storyModel valueForKey:@"content"]];
    NSString * replyAuthorStr = [NSString stringWithFormat:@"%@",[storyModel valueForKey:@"author"]];
    
    NSString * allReplyStr = [[NSString alloc] init];
    NSLog(@"replyContentStr = %@",replyContentStr);
    NSLog(@"replyAuthorStr = %@",replyAuthorStr);
    
    self.reply_toLabel.font = [UIFont systemFontOfSize:16];
    
    if ( ![[NSString stringWithFormat:@"%@",replyContentStr] isEqualToString:@"(null)"] ){
        self.reply_toLabel.textColor = [UIColor grayColor];
        //这里还没有把字符串添加进去
        allReplyStr = [NSString stringWithFormat:@"//%@: %@",replyAuthorStr,replyContentStr];
        self.reply_toLabel.text = allReplyStr;
        NSLog(@"allReplyStr = %@",allReplyStr);
        
        _reply_toSize = [allReplyStr boundingRectWithSize:CGSizeMake(326, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size.height;
    }

    NSString * contString = [NSString stringWithFormat:@"%@",[message valueForKey:@"content"]];
    self.contentLabel.text = contString;
    self.contentLabel.font = [UIFont systemFontOfSize:16];
    _contentSize = [contString boundingRectWithSize:CGSizeMake(326, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size.height;
    NSLog(@"_contentLabel.text = %@",_contentLabel.text);
    NSLog(@"_contentSize = %li",(long)_contentSize);
    
    NSString * naStr = [NSString stringWithFormat:@"%@",[message valueForKey:@"author"]];
//    self.nameLabel.font
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
    
    //时间戳转时间
    NSString * confromTimespStr = [formatter stringFromDate:detailDate];
    NSLog(@"confromTimespStr = %@",confromTimespStr);
    
    self.timeLabel.font = [UIFont systemFontOfSize:13];
    _timeSize = [confromTimespStr boundingRectWithSize:CGSizeMake(300, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.height;
    self.timeLabel.text = confromTimespStr;
    CGFloat allSize = _timeSize + _contentSize + _nameSize;
    NSLog(@"allSize = %li",(long)allSize);
    
    
    
    //NSLog(@"message = %@",message);
    NSMutableAttributedString * finalContentStr = [[NSMutableAttributedString alloc] init];
    NSAttributedString * contentString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",[message valueForKey:@"content"]] attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16], NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    //[finalContentStr appendAttributedString:contentString];
    //self.contentLabel.attributedText = finalContentStr;
    
    NSMutableAttributedString * finalNameStr = [[NSMutableAttributedString alloc] init];
    NSAttributedString * nameString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",[message valueForKey:@"author"]] attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16], NSForegroundColorAttributeName: [UIColor blackColor]}];
    //[finalNameStr appendAttributedString:nameString];
    //self.nameLabel.attributedText = finalNameStr;
    
    NSMutableAttributedString * finalTimeStr = [[NSMutableAttributedString alloc] init];
    
    NSAttributedString * timeString = [[NSAttributedString alloc] initWithString:confromTimespStr attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13], NSForegroundColorAttributeName: [UIColor grayColor]}];
    [finalTimeStr appendAttributedString:timeString];
    [finalNameStr appendAttributedString:nameString];
    [finalContentStr appendAttributedString:contentString];
    
    //self.contentLabel.attributedText = finalContentStr;
    //self.nameLabel.attributedText = finalNameStr;
    //self.timeLabel.attributedText = finalTimeStr;
    
    
//    self.timeLabel.font = [UIFont systemFontOfSize:13];
//    _timeSize = [confromTimespStr boundingRectWithSize:CGSizeMake(300, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.height;
//    self.timeLabel.text = confromTimespStr;
//    CGFloat allSize = _timeSize + _contentSize + _nameSize;
//    NSLog(@"allSize = %li",(long)allSize);

    NSString * urlStr = [NSString stringWithFormat:@"%@",[message valueForKey:@"avatar"]];
    [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL * url = [NSURL URLWithString:urlStr];
    NSData * imageData = [NSData dataWithContentsOfURL:url];
    UIImage * avatarImage = [UIImage imageWithData:imageData];
    self.avatarImage.image = avatarImage;
    
    self.approvalButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.approvalButton setTitle:[NSString stringWithFormat:@"%@",[message valueForKey:@"likes"]] forState:UIControlStateNormal];
    [self.approvalButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
   // NSLog(@"likes = %@",[message valueForKey:@"likes"]);
    NSLog(@"self.avatarImage.image = %@",self.avatarImage.image);

}

- (CGFloat)heightForModel:(ZRBCommentsJSONModel *)message
{
    [self setMessage:message];
    [self layoutIfNeeded];
#pragma mark   为什么这里加上70 就OK 了？？？？ 不加70 + 1 的话评论就会隐藏一部分！！！！！
    
    CGFloat cellHeight = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 100;
    NSLog(@"cellHeight = %li",(long)cellHeight);
    
    CGFloat size = _contentSize + 50;
    NSLog(@"size = %li",(long)size);
    CGFloat allHeight = _contentSize + _timeSize + _nameSize + _reply_toSize + 20;
    return allHeight;
    
    
    return size;
    
    return cellHeight;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
