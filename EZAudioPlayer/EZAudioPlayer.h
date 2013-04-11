//
//  AudioPlayer.h
//
//  Created by Ed Rackham on 09/04/2013.
//  Copyright (c) 2013 edrackham.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol EZAudioPlayerDelegate <NSObject>
@optional
- (void)audioDidFinishPlaying;
- (void)dialogWasCancelled;
@end

@interface EZAudioPlayer : UIView <AVAudioPlayerDelegate>

@property (assign, nonatomic) id <EZAudioPlayerDelegate> delegate;
@property (strong, nonatomic, setter = setFileURL:) NSURL *fileURL;
@property (assign, nonatomic) BOOL autoPlay;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *currentPositionLabel;
@property (strong, nonatomic) IBOutlet UILabel *totalDurationLabel;
@property (strong, nonatomic) IBOutlet UISlider *trackProgressSlider;
@property (strong, nonatomic) IBOutlet UIButton *playButton;
@property (strong, nonatomic) IBOutlet UIButton *pauseButton;
@property (strong, nonatomic) IBOutlet UIButton *stopButton;


+ (EZAudioPlayer *)show;
+ (EZAudioPlayer *)showAndPlayWithFileURL:(NSURL *)fileURL;
- (IBAction)play:(id)sender;
- (IBAction)pause:(id)sender;
- (IBAction)stop:(id)sender;
- (IBAction)close:(id)sender;
- (IBAction)trackProgressDidChange:(id)sender;

@end
