//
//  ViewController.m
//  NMMusicPlayer
//
//  Created by Namrata on 03/11/16.
//  Copyright © 2016 Namrata Mahajan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    isPlaying = false;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)initializeAudioPlayer {
    BOOL status = false;
    NSURL *musicURL = [[NSBundle mainBundle]URLForResource:@"myMusic" withExtension:@"mp3"];
    if (musicURL != nil) {
        NSError *error;
        audioplayer = [[AVAudioPlayer alloc]initWithContentsOfURL:musicURL error:&error];
        if (error != nil) {
            NSLog(@"%@",error.localizedDescription);
            
        }
        else
        {
            status = true;
        
    }
}
return status;
}

- (IBAction)ActionPlay:(id)sender {
    UIButton *button = sender;
    if ([button.titleLabel.text isEqualToString:@"play"]) {
        if (isPlaying) {
            [audioplayer play];
            
        }
        else {
            if ([self initializeAudioPlayer]) {
                [audioplayer play];
                isPlaying = true;
                
            }
            else{
                NSLog(@"something went wrong while initialize audio player.");
                
            }
        }
        [button setTitle:@"pause" forState:UIControlStateNormal];
      //  [button setTintColor:[UIColor yellowColor]];
        
    }
    else if ([button.titleLabel.text isEqualToString:@"pause"]){
        
        [audioplayer pause];
        
        [button setTitle:@"play" forState:UIControlStateNormal];
        
        
    }
}

- (IBAction)Actionstop:(id)sender {
    [audioplayer stop];
    isPlaying = false;
    [self.PlayButton setTitle:@"play" forState:UIControlStateNormal];
    
}
@end
