//
//  SourcesMusicPlayer.h
//  TuiTuiYYC
//
//  Created by ZhiF_Zhu on 2020/9/23.
//  Copyright © 2020 朱洁珊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

NS_ASSUME_NONNULL_BEGIN

@interface SourcesMusicPlayer : NSObject<AVAudioPlayerDelegate>{
    SystemSoundID _sound;//音效
}

@property (strong,nonatomic)AVAudioPlayer *player;
//@property (strong,nonatomic)AVAudioPlayer *playBack;

@property (nonatomic,assign) NSTimeInterval  currentPlayTime;//暂停时播放位置的偏移量
@property (nonatomic,assign) BOOL  isPause;
/*背景音乐*/
+ (instancetype)shareMusicManage;
- (void)playMusic:(NSString *)mscName;
- (void)startMusic;
- (void)pauseMusic;
- (void)stopMusic;

/*音效*/
- (void)playSound:(NSString *)soundStr;

@end

NS_ASSUME_NONNULL_END
