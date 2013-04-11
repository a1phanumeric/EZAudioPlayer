//
//  ViewController.m
//  EZAudioPlayerDemo
//
//  Created by Ed Rackham on 11/04/2013.
//  Copyright (c) 2013 edrackham.com. All rights reserved.
//

#import "ViewController.h"
#import "EZAudioPlayer.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playAudio:(id)sender {
    EZAudioPlayer *audioPlayer = [EZAudioPlayer showAndPlayWithFileURL:
                                  [[NSBundle mainBundle] URLForResource:@"Djent" withExtension:@"mp3"]];
    [[audioPlayer titleLabel] setText:@"Djent!"];
    [[audioPlayer subtitleLabel] setText:@"Djent is a genre of music which relies on intense time signatures and heavy riffs."];
    
}
@end
