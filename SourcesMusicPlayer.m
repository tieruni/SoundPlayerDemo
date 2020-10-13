//
//  SourcesMusicPlayer.m
//  TuiTuiYYC
//
//  Created by ZhiF_Zhu on 2020/9/23.
//  Copyright © 2020 朱洁珊. All rights reserved.
//

#import "SourcesMusicPlayer.h"

@implementation SourcesMusicPlayer

+ (instancetype)shareMusicManage{
    static dispatch_once_t onceToken;
    static SourcesMusicPlayer *manage;
    
    dispatch_once(&onceToken, ^{
        manage = [[SourcesMusicPlayer alloc] init];
        manage.isPause = [[NSUserDefaults standardUserDefaults] boolForKey:@"MscState"];
        
    });
    
    return manage;
}

- (void)playMusic:(NSString *)mscName{
    /*获取资源路径*/
    NSString *path = [[NSBundle mainBundle] pathForResource:mscName ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:path];
    /*设置播放器*/
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    _player.volume = 0.8;//音量
    _player.numberOfLoops = -1;//0表示只播放一次,1表示播放2次，依此类推，负数表示无限循环
        
    if (self.isPause == NO) {
        [self startMusic];//播放
    }else{
        [self pauseMusic];
    }
    
}

- (void)startMusic{
    /*开始播放*/
    _player.currentTime = self.currentPlayTime;
    [_player play];

    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"MscState"];

    _player.delegate = self;
}

- (void)pauseMusic{
    /*暂停播放*/
    self.currentPlayTime = _player.currentTime;
    [_player pause];
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"MscState"];
    
}

- (void)stopMusic{
    /*停止播放*/
    [_player stop];
    
    /*将播放器释放*/
    _player=nil;
//    _playBack=nil;
}

#pragma mark -- delegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    //背景音乐播放完后需要做的操作
    
}

//添加音效
-(SystemSoundID)loadSound:(NSString *)soundFileNAme{//(soundFileNAme传值用)
    //需要制定声音的文件路径，这个方法需要加载不同的音效
    NSString *path = [[NSBundle mainBundle]pathForResource:soundFileNAme ofType:nil];
    //将路径字符串转换为url
    NSURL *url = [NSURL fileURLWithPath:path];
    //初始化音效(url - CFURLRefSystemSoundID)
    SystemSoundID soundId;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url),&soundId);
    return soundId;
}

//调用音效效果
- (void)playSound:(NSString *)soundStr{
    _sound = [self loadSound:soundStr];
    if (!self.isPause) {
        AudioServicesPlaySystemSound(_sound);
    }
}

@end
