//
//  TableViewController.m
//  MultiThreads
//
//  Created by itang on 2020/9/5.
//  Copyright © 2020 learn. All rights reserved.
//

#import "TableViewController.h"

// 知识点
@interface KnowledgePoint : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *className;

+ (instancetype)instanceWithTitle:(NSString *)title className:(NSString *)className;

@end

@implementation KnowledgePoint

+ (instancetype)instanceWithTitle:(NSString *)title :(NSString *)className {
    KnowledgePoint *point = KnowledgePoint.new;
    point.className = className;
    point.title = title;
    
    return point;
}

@end

@interface TableViewController ()

@property (strong, nonatomic) NSArray *dataArray;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupData];
    
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"reuseIdentifier"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)setupData {
    self.dataArray = @[
        [KnowledgePoint instanceWithTitle:@"栅栏" :@"GCDBarrierVC"],
    ];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    KnowledgePoint *point = self.dataArray[indexPath.row];
    cell.textLabel.text = point.title;
        
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    KnowledgePoint *point = self.dataArray[indexPath.row];
    UIViewController *vc = [NSClassFromString(point.className) new];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
