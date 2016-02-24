//
//  SJRootViewController.m
//  SJMedia
//
//  Created by shejun.zhou on 16/2/24.
//  Copyright © 2016年 shejun.zhou. All rights reserved.
//

#import "SJRootViewController.h"
#import "SJAudioQueueServicesViewController.h"

@interface SJRootViewController ()

@property (nonatomic, strong) NSMutableArray *dataSources;

@end

@implementation SJRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSources count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SJRootTableViewCellIdentifier" forIndexPath:indexPath];
    
    // Configure the cell...
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", _dataSources[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (0 == indexPath.row) {
//        UIStoryboard *s = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        SJAudioQueueServicesViewController *audio = [s instantiateViewControllerWithIdentifier:NSStringFromClass([SJAudioQueueServicesViewController class])];
        SJAudioQueueServicesViewController *audio = [[SJAudioQueueServicesViewController alloc] init];
        [self.navigationController pushViewController:audio animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setLayoutManager:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}

#pragma mark - 

- (NSMutableArray *)dataSources {
    if (!_dataSources) {
        _dataSources = [[NSMutableArray alloc] init];
        [_dataSources addObject:@"AudioQueueServices"];
    }
    return _dataSources;
}
@end
