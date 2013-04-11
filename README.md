EZAudioPlayer
=============

Easy Audio Player for iOS. Works on both iPhone and iPad.

![EZAudioPlayer](http://i.imgur.com/ofqvMCG.png)

Setup
=====

Include the EZAudioPlayer directory into your project, and link your project with the **AVFoundation** and **QuartzCore** (not 100% necessary) frameworks.

Usage
=====

Simply invoke EZAudioPlayer with the following:

```
EZAudioPlayer *audioPlayer = [EZAudioPlayer showAndPlayWithFileURL:[[NSBundle mainBundle] URLForResource:@"MusicFilename" withExtension:@"mp3"]];
```

And BOOM you have an audio player that immediately hooks into your view.

There's a few other calls, for setting the title and subtitle labels:

```
EZAudioPlayer *audioPlayer = [EZAudioPlayer showAndPlayWithFileURL:[[NSBundle mainBundle] URLForResource:@"MusicFilename" withExtension:@"mp3"]];
[[audioPlayer titleLabel] setText:@"My Title!"];
[[audioPlayer subtitleLabel] setText:@"My Subtitle."];
```

Example
=======

Take a look at the example projet bundled with this repo.

To-Do
=====

- Complete delegate callbacks

Acknowledgements
================

- [matej](https://github.com/matej) for the excellent [MBProgressHUD](https://github.com/jdg/MBProgressHUD) class used within this repo.