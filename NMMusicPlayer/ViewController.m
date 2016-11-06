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
    self.sliderDuration.userInteractionEnabled = NO;
    self.sliderDuration.minimumValue = 0;
    self.sliderDuration.value= 0;
    //_sliderDuration=[[UISlider alloc]initWithFrame:CGRectMake(130, 690,240, 25)];
    //blueSlider.backgroundColor=[UIColor blueColor];
    //[_sliderDuration addTarget:self action:@selector(changeBlueColor:) forControlEvents:UIControlEventValueChanged];
    _sliderDuration.thumbTintColor = [UIColor blackColor];
    
    _sliderDuration.minimumTrackTintColor = [UIColor orangeColor];
_sliderDuration.maximumTrackTintColor = [UIColor redColor];
    


}
-(void)startTimer{
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(udateDurationSlider) userInfo:nil repeats:YES];
    
}
-(void)udateDurationSlider{
    if (self.sliderDuration.value == audioplayer.duration) {
        timer = nil;
    }
    self.sliderDuration.value = audioplayer.currentTime;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)initialzeAudioPlayer{
    
    BOOL status = false;
    //NSURL *musicURL = [[NSBundle mainBundle]URLForResource:@"myMusic" withExtension:@"mp3"];
    NSURL *musicURL = [[NSBundle mainBundle]URLForResource:@"myMusic" withExtension:@"mp3"];
    if (musicURL != nil) {
        NSError *error;
        audioplayer = [[AVAudioPlayer alloc]initWithContentsOfURL:musicURL error:&error];
        if (error != nil) {
            NSLog(@"%@",error.localizedDescription);
        }
        else{
            status = true;
        }
    }
    
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:musicURL options:nil];
    
    NSArray *titles = [AVMetadataItem metadataItemsFromArray:asset.commonMetadata withKey:AVMetadataCommonKeyTitle keySpace:AVMetadataKeySpaceCommon];
    NSArray *artists = [AVMetadataItem metadataItemsFromArray:asset.commonMetadata withKey:AVMetadataCommonKeyArtist keySpace:AVMetadataKeySpaceCommon];
    NSArray *albumNames = [AVMetadataItem metadataItemsFromArray:asset.commonMetadata withKey:AVMetadataCommonKeyAlbumName keySpace:AVMetadataKeySpaceCommon];
    
    AVMetadataItem *title = [titles objectAtIndex:0];
    AVMetadataItem *artist = [artists objectAtIndex:0];
    AVMetadataItem *albumName = [albumNames objectAtIndex:0];
    
    
    NSArray *keys = [NSArray arrayWithObjects:@"commonMetadata", nil];
    [asset loadValuesAsynchronouslyForKeys:keys completionHandler:^{
        NSArray *artworks = [AVMetadataItem metadataItemsFromArray:asset.commonMetadata
                                                           withKey:AVMetadataCommonKeyArtwork
                                                          keySpace:AVMetadataKeySpaceCommon];
        
        for (AVMetadataItem *item in artworks) {
            if ([item.keySpace isEqualToString:AVMetadataKeySpaceID3]) {
                //                NSDictionary *d = [item.value copyWithZone:nil];
                
                NSData *data = [item.value copyWithZone:nil];
                UIImage *image = [UIImage imageWithData:data];
                
                self.myImageView.image = image;
            } else if ([item.keySpace isEqualToString:AVMetadataKeySpaceiTunes]) {
                self.myImageView.image = [UIImage imageWithData:[item.value copyWithZone:nil]];
            }
        }
    }];
    
    
    
    return status;
}
- (IBAction)ActionPlay:(id)sender {
    UIButton *button = sender;
    if ([button.titleLabel.text isEqualToString:@"play"]) {
        if (isPlaying) {
            [audioplayer play];
            
        }
        else {
            //if ([self initializeAudioPlayer]) {
            if ([self initialzeAudioPlayer]) {
                
            
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
