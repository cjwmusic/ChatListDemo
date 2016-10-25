//
//  WKChatListItem.h
//  ChatListDemo
//
//  Created by Wu Kong on 24/10/2016.
//  Copyright © 2016 wukong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WKChatListItem : NSObject

@property (nonatomic, strong) NSString *userNick;
@property (nonatomic, strong) NSString *lastMessage;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *avatarUrlString;


+ (WKChatListItem *)itemWithDictionary:(NSDictionary *)JSON;

@end
