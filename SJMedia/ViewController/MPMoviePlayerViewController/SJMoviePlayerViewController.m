//
//  SJMoviePlayerViewController.m
//  SJMedia
//
//  Created by shejun.zhou on 16/2/24.
//  Copyright © 2016年 shejun.zhou. All rights reserved.
//

#import "SJMoviePlayerViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface SJMoviePlayerViewController ()

//播放器视图控制器
@property (nonatomic,strong) MPMoviePlayerViewController *moviePlayerViewController;
@property (nonatomic, strong) UIButton *playButton;

@end

@implementation SJMoviePlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.playButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    //移除所有通知监控
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - 私有方法
/**
 *  取得本地文件路径
 *
 *  @return 文件路径
 */
-(NSURL *)getFileUrl{
    NSString *urlStr=[[NSBundle mainBundle] pathForResource:@"IMG_1393.mp4" ofType:nil];
    NSURL *url = nil;
    if (urlStr) {
        url=[NSURL fileURLWithPath:urlStr];
    }
    return url;
}

/**
 *  取得网络文件路径
 *
 *  @return 文件路径
 */
-(NSURL *)getNetworkUrl{
    NSString *urlStr=@"http://192.168.1.161/IMG_1393.mp4";
    urlStr=[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url=[NSURL URLWithString:urlStr];
    return url;
}

-(MPMoviePlayerViewController *)moviePlayerViewController{
    if (!_moviePlayerViewController) {
        NSURL *url=[self getFileUrl];
        _moviePlayerViewController=[[MPMoviePlayerViewController alloc]initWithContentURL:url];
        [self addNotification];
    }
    return _moviePlayerViewController;
}

#pragma mark - 控制器通知
/**
 *  添加通知监控媒体播放控制器状态
 */
-(void)addNotification{
    NSNotificationCenter *notificationCenter=[NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackStateChange:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:self.moviePlayerViewController.moviePlayer];
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayerViewController.moviePlayer];
    
}

/**
 *  播放状态改变，注意播放完成时的状态是暂停
 *
 *  @param notification 通知对象
 */
-(void)mediaPlayerPlaybackStateChange:(NSNotification *)notification{
    switch (self.moviePlayerViewController.moviePlayer.playbackState) {
        case MPMoviePlaybackStatePlaying:
            NSLog(@"正在播放...");
            break;
        case MPMoviePlaybackStatePaused:
            NSLog(@"暂停播放.");
            break;
        case MPMoviePlaybackStateStopped:
            NSLog(@"停止播放.");
            break;
        default:
            NSLog(@"播放状态:%li",self.moviePlayerViewController.moviePlayer.playbackState);
            break;
    }
}

/**
 *  播放完成
 *
 *  @param notification 通知对象
 */
-(void)mediaPlayerPlaybackFinished:(NSNotification *)notification{
    NSLog(@"播放完成.%li",self.moviePlayerViewController.moviePlayer.playbackState);
}

- (void)tappedPlayButtonAction:(id)sender {
    self.moviePlayerViewController=nil;//保证每次点击都重新创建视频播放控制器视图，避免再次点击时由于不播放的问题
    //    [self presentViewController:self.moviePlayerViewController animated:YES completion:nil];
    //注意，在MPMoviePlayerViewController.h中对UIViewController扩展两个用于模态展示和关闭MPMoviePlayerViewController的方法，增加了一种下拉展示动画效果
    [self presentMoviePlayerViewControllerAnimated:self.moviePlayerViewController];
}

- (UIButton *)playButton {
    if (!_playButton) {
        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playButton setTitle:@"播放" forState:UIControlStateNormal];
        _playButton.backgroundColor = [UIColor orangeColor];
        _playButton.frame = CGRectMake(100, 100, 100, 44);
        [_playButton addTarget:self action:@selector(tappedPlayButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playButton;
}

@end
