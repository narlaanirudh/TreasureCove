//
//  ANFirstViewController.h
//  EnTreasure
//
//  Created by Anirudh narla on 11/23/13.
//  Copyright (c) 2013 Anirudh Narla. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ANFirstViewController : UIViewController
- (IBAction)logout:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *mobileLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
- (IBAction)share:(id)sender;

@property(weak,nonatomic) PFFile *imgFile;

@end
