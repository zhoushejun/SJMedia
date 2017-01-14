//
//  SJAudioQueueServicesViewController.m
//  SJMedia
//
//  Created by shejun.zhou on 16/2/24.
//  Copyright © 2016年 shejun.zhou. All rights reserved.
//

#import "SJAudioQueueServicesViewController.h"
#import "FSAudioStream.h"

@interface SJAudioQueueServicesViewController ()

@property (nonatomic, strong) FSAudioStream *audioStream;
@property (nonatomic, strong) UIButton *playButton;

@end

@implementation SJAudioQueueServicesViewController

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


/**
 *  取得本地文件路径
 *
 *  @return 文件路径
 */
-(NSURL *)getFileUrl{
    NSString *urlStr=[[NSBundle mainBundle]pathForResource:@"bupan.mp3" ofType:nil];
    NSURL *url=[NSURL fileURLWithPath:urlStr];
    return url;
}

-(NSURL *)getNetworkUrl{
    NSString *urlStr=@"http://play.baidu.com....xx.mp3";//没找到可以播放的网络音乐地址
    NSURL *url=[NSURL URLWithString:urlStr];
    return url;
}

/**
 *  创建FSAudioStream对象
 *
 *  @return FSAudioStream对象
 */
-(FSAudioStream *)audioStream{
    if (!_audioStream) {
        NSURL *url=[self getFileUrl];
//        NSURL *url=[self getNetworkUrl];
        
        //创建FSAudioStream对象
        _audioStream=[[FSAudioStream alloc]initWithUrl:url];
        _audioStream.onFailure=^(FSAudioStreamError error,NSString *description){
            NSLog(@"播放过程中发生错误，错误信息：%@",description);
        };
        _audioStream.onCompletion=^(){
            NSLog(@"播放完成!");
        };
        [_audioStream setVolume:0.5];//设置声音
    }
    return _audioStream;
}

- (void)tappedPlayButtonAction:(UIButton *)sender {
    if (![self.audioStream isPlaying]) {
        [self.audioStream play];
        [sender setTitle:@"停止" forState:UIControlStateNormal];
    }
    else {
        [sender setTitle:@"播放" forState:UIControlStateNormal];
        [self.audioStream stop];
    }
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
