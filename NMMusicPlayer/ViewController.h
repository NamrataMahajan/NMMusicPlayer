//
//  ViewController.h
//  NMMusicPlayer
//
//  Created by Namrata on 03/11/16.
//  Copyright © 2016 Namrata Mahajan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController
{
    AVAudioPlayer *audioplayer;
    BOOL isPlaying;
}
@property (strong, nonatomic) IBOutlet UIButton *PlayButton;

- (IBAction)ActionPlay:(id)sender;
- (IBAction)Actionstop:(id)sender;

@end

