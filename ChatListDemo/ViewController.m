//
//  ViewController.m
//  ChatListDemo
//
//  Created by Wu Kong on 24/10/2016.
//  Copyright © 2016 wukong. All rights reserved.
//

#import "ViewController.h"
#import "WKChatListCell.h"
#import "WKChatListItem.h"
#import "AFHTTPSessionManager.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) NSMutableArray *dataArray;

#define kCellIdentifier @"kCellIdentifier"

@end

@implementation ViewController

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        _manager.responseSerializer.acceptableContentTypes
        = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", @"text/html", nil];
    }
    
    return _manager;
}



- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 20);
    [self loadData];
}

- (void)loadData {
    
    self.dataArray = @[].mutableCopy;
    
    __weak ViewController *weakSelf = self;
    
    [self.manager GET:@"http://wkmusic.cn/api/chat" parameters:@{}
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        if([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = (NSDictionary *)responseObject;
            if (dic[@"data"] && [dic[@"data"][@"result"] count] > 0) {
                NSArray *arr = dic[@"data"][@"result"];
                [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([obj isKindOfClass:[NSDictionary class]]) {
                        WKChatListItem *item = [WKChatListItem itemWithDictionary:obj];
                        [weakSelf.dataArray addObject:item];
                    }
                }];
                
                [weakSelf.tableView reloadData];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"加载失败: %lu", error.code);
    }];

}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Section %lu , row %lu selected", indexPath.section, indexPath.row);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 62;
}

#pragma mark - 
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WKChatListCell *chatListCell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (!chatListCell) {
        chatListCell = [[WKChatListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
    }
    
    if ([self.dataArray count] > indexPath.row) {
        [chatListCell setItem:[self.dataArray objectAtIndex:indexPath.row]];
    }
    
    return chatListCell;
}

@end
