//
//  AudioPlayer.m
//
//  Created by Ed Rackham on 09/04/2013.
//  Copyright (c) 2013 edrackham.com. All rights reserved.
//

#import "EZAudioPlayer.h"
#import "MBProgressHUD.h"
#import <QuartzCore/QuartzCore.h>

@implementation EZAudioPlayer{
    BOOL            _readyToPlay;
    AVAudioPlayer   *_audioPlayer;
    NSTimer         *_playTimer;
    BOOL            _isPaused;
}

+ (EZAudioPlayer *)show{
    CGRect bounds = [[UIScreen mainScreen] bounds];
    EZAudioPlayer *dialog = [[EZAudioPlayer alloc] initWithFrame:CGRectMake(0, 0, bounds.size.width, bounds.size.height)];
    [dialog setAlpha:0.0];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:dialog];
    [UIView animateWithDuration:0.3 animations:^{
        [dialog setAlpha:1.0];
    }];
    return dialog;
}

+ (EZAudioPlayer *)showAndPlayWithFileURL:(NSURL *)fileURL{
    EZAudioPlayer *dialog = [EZAudioPlayer show];
    [dialog setAutoPlay:YES];
    [dialog setFileURL:fileURL];
    return dialog;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *nib    = [[NSBundle mainBundle] loadNibNamed:@"EZAudioPlayer" owner:self options:nil];
        self            = [nib objectAtIndex:0];
        [self setFrame:frame];
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"DisabledBg.png"]]];
        [_contentView setCenter:self.center];
        #if __has_include(<QuartzCore/QuartzCore.h>)
        [_contentView.layer setCornerRadius:10.0f];
        #endif
    }
    return self;
}


#pragma mark - Custom Setters

- (void)setFileURL:(NSURL *)fileURL{
    _fileURL = fileURL;
    
    [MBProgressHUD showHUDAddedTo:self animated:YES];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        _audioPlayer    = [[AVAudioPlayer alloc] initWithContentsOfURL:_fileURL error:NULL];
        [_audioPlayer setDelegate:self];
        
        [_trackProgressSlider setMaximumValue:_audioPlayer.duration];
        [_currentPositionLabel setText:[NSString stringWithFormat:@"%02d:%02d",
                                        (int)((int)(_audioPlayer.currentTime)) / 60,
                                        (int)((int)(_audioPlayer.currentTime)) % 60]];
        [_totalDurationLabel setText:[NSString stringWithFormat:@"/ %02d:%02d",
                                      (int)((int)(_audioPlayer.duration)) / 60,
                                      (int)((int)(_audioPlayer.duration)) % 60]];
        _readyToPlay = YES;
        
        [MBProgressHUD hideHUDForView:self animated:YES];
        
        if(_autoPlay){
            [self play:nil];
        }
    });
    
}

- (void)updateTimeAndTrackProgress:(id)sender{
    _trackProgressSlider.value = _audioPlayer.currentTime;
    [_currentPositionLabel setText:[NSString stringWithFormat:@"%02d:%02d",
                                    (int)((int)(_audioPlayer.currentTime)) / 60,
                                    (int)((int)(_audioPlayer.currentTime)) % 60]];
}

- (void)close:(id)sender{
    [self stop:nil];
    [UIView animateWithDuration:0.3 animations:^{
        [self setAlpha:0.0];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)showPauseButton{
    [UIView animateWithDuration:0.3 animations:^{
        [_playButton setCenter:CGPointMake(_playButton.center.x - (_playButton.frame.size.width / 2), _playButton.center.y)];
        [_stopButton setCenter:CGPointMake(_stopButton.center.x + (_stopButton.frame.size.width / 2), _stopButton.center.y)];
        [_pauseButton setAlpha:1.0];
    }];
}

- (void)hidePauseButton{
    [UIView animateWithDuration:0.3 animations:^{
        [_playButton setCenter:CGPointMake(_playButton.center.x + (_playButton.frame.size.width / 2), _playButton.center.y)];
        [_stopButton setCenter:CGPointMake(_stopButton.center.x - (_stopButton.frame.size.width / 2), _stopButton.center.y)];
        [_pauseButton setAlpha:0.0];
    }];
}

- (IBAction)play:(id)sender {
    if(!_readyToPlay){
        NSLog(@"Not ready to play");
        return;
    }
    if(![_audioPlayer isPlaying]){
        if(!_isPaused){
            [self showPauseButton];
        }
        _isPaused = NO;
        [_playTimer invalidate];
        _playTimer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(updateTimeAndTrackProgress:) userInfo:nil repeats:YES];
        [_audioPlayer play];
    }
}

- (IBAction)pause:(id)sender {
    if([_audioPlayer isPlaying]){
        [_audioPlayer stop];
        [_playTimer invalidate];
        _playTimer = nil;
        _isPaused = YES;
    }
}

- (IBAction)stop:(id)sender {
    if([_audioPlayer isPlaying] || _isPaused){
        [self hidePauseButton];
        [_audioPlayer stop];
        [_playTimer invalidate];
        _playTimer = nil;
        _isPaused = NO;
        [_trackProgressSlider setValue:0.0];
        [_audioPlayer setCurrentTime:0.0];
    }
}

- (IBAction)trackProgressDidChange:(id)sender {
    [_trackProgressSlider setMaximumValue:_audioPlayer.duration];
    [_audioPlayer setCurrentTime:_trackProgressSlider.value];
    [_currentPositionLabel setText:[NSString stringWithFormat:@"%02d:%02d",
                                    (int)((int)(_audioPlayer.currentTime)) / 60,
                                    (int)((int)(_audioPlayer.currentTime)) % 60]];
}
@end
