//
//  WKChatListCell.m
//  ChatListDemo
//
//  Created by Wu Kong on 24/10/2016.
//  Copyright © 2016 wukong. All rights reserved.
//

#import "WKChatListCell.h"
#import "HexColor.h"
#import "UIImageView+WebCache.h"

@interface WKChatListCell()

//用户头像
@property (nonatomic, strong) UIImageView *avatarView;
//用户昵称
@property (nonatomic, strong) UILabel *userNickLabel;
//最新的消息
@property (nonatomic, strong) UILabel *lastMessageLabel;
//更新时间
@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation WKChatListCell

#pragma mark -
#pragma mark Getters

- (UIImageView *)avatarView {
    if (!_avatarView) {
        _avatarView = [[UIImageView alloc] init];
        _avatarView.layer.cornerRadius = 21;
        _avatarView.layer.masksToBounds = YES;
        _avatarView.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    return _avatarView;
}

- (UILabel *)userNickLabel {
    if (!_userNickLabel) {
        _userNickLabel = [[UILabel alloc] init];
        _userNickLabel.font = [UIFont systemFontOfSize:14];
        _userNickLabel.textColor = [UIColor colorWithHexString:@"#555555"];
    }
    
    return _userNickLabel;
}

- (UILabel *)lastMessageLabel {
    if (!_lastMessageLabel) {
        _lastMessageLabel = [[UILabel alloc] init];
        _lastMessageLabel.font = [UIFont systemFontOfSize:14];
        _lastMessageLabel.textColor = [UIColor colorWithHexString:@"#909090"];
    }
    
    return _lastMessageLabel;
}

-(UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.textColor = [UIColor colorWithHexString:@"#BDBDBD"];
        _timeLabel.textAlignment = NSTextAlignmentRight;
    }
    
    return _timeLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];

        [self.contentView addSubview:self.avatarView];
        [self.contentView addSubview:self.lastMessageLabel];
        [self.contentView addSubview:self.userNickLabel];
        [self.contentView addSubview:self.timeLabel];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.avatarView.frame = CGRectMake(12, 10, 42, 42);
    self.userNickLabel.frame = CGRectMake(12 + 42 + 20, 12, 200, 14);
    self.lastMessageLabel.frame = CGRectMake(12 + 42 + 20, 12 + 14 + 10, 250, 14);
    self.timeLabel.frame = CGRectMake(self.frame.size.width - 150 - 12, 12, 150, 12);
}

- (void)setItem:(WKChatListItem *)item {
    [self.avatarView sd_setImageWithURL:[NSURL URLWithString:item.avatarUrlString ?: @""] completed:nil];
    self.userNickLabel.text = item.userNick ?: @"";
    self.lastMessageLabel.text = item.lastMessage ?: @"";
    self.timeLabel.text = item.time ?: @"";
}

@end
