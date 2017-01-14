//
//  SJRootViewController.m
//  SJMedia
//
//  Created by shejun.zhou on 16/2/24.
//  Copyright © 2016年 shejun.zhou. All rights reserved.
//

#import "SJRootViewController.h"
#import "SJAudioQueueServicesViewController.h"
#import "SJMoviePlayerController.h"
#import "SJMoviePlayerViewController.h"
#import "SJAVAudioRecorderViewController.h"

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
        SJAudioQueueServicesViewController *audio = [[SJAudioQueueServicesViewController alloc] init];
        [self.navigationController pushViewController:audio animated:YES];
    }
    else if (1 == indexPath.row) {
        SJAVAudioRecorderViewController *audioRecorder = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([SJAVAudioRecorderViewController class])];
        [self.navigationController pushViewController:audioRecorder animated:YES];
    }
    else if (2 == indexPath.row) {
        SJMoviePlayerController *moviePlayer = [[SJMoviePlayerController alloc] init];
        [self.navigationController pushViewController:moviePlayer animated:YES];
    }else if (3 == indexPath.row) {
        SJMoviePlayerViewController *moviePlayer = [[SJMoviePlayerViewController alloc] init];
        [self.navigationController pushViewController:moviePlayer animated:YES];
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
        [_dataSources addObject:NSStringFromClass([SJAudioQueueServicesViewController class])];
        [_dataSources addObject:NSStringFromClass([SJAVAudioRecorderViewController class])];
        [_dataSources addObject:NSStringFromClass([SJMoviePlayerController class])];
        [_dataSources addObject:NSStringFromClass([SJMoviePlayerViewController class])];
    }
    return _dataSources;
}
@end
