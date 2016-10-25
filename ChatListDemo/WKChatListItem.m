//
//  WKChatListItem.m
//  ChatListDemo
//
//  Created by Wu Kong on 24/10/2016.
//  Copyright © 2016 wukong. All rights reserved.
//

#import "WKChatListItem.h"

@implementation WKChatListItem

+ (WKChatListItem *)itemWithDictionary:(NSDictionary *)JSON {
    
    WKChatListItem *item = nil;
    
    if (JSON) {
        item = [[WKChatListItem alloc] init];
        if (JSON[@"avatar"]) {
            item.avatarUrlString = JSON[@"avatar"];
        }
        
        if (JSON[@"lastMessage"]) {
            item.lastMessage = JSON[@"lastMessage"];
        }
        
        if (JSON[@"time"]) {
            item.time = JSON[@"time"];
        }
        
        if (JSON[@"userName"]) {
            item.userNick = JSON[@"userName"];
        }
    }

    return item;
}

@end
