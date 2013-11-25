//
//  ANFirstViewController.m
//  EnTreasure
//
//  Created by Anirudh narla on 11/23/13.
//  Copyright (c) 2013 Anirudh Narla. All rights reserved.
//

#import "ANFirstViewController.h"
#import <Parse/Parse.h>
#import "MBProgressHUD.h"

@interface ANFirstViewController ()

@end

@implementation ANFirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   // [PFUser logOut];
    
    
    //Making the image look good
    
    [self.profileImage.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
    [self.profileImage.layer setBorderWidth:2.0];
    
    //The rounded corner part, where you specify your view's corner radius:
    self.profileImage.layer.cornerRadius = 5;

    
    
    
    self.navigationController.navigationBar.alpha = 0.01f;
    
    
    
    
    
    
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    PFUser *currentUser = [PFUser currentUser];
    
    if (currentUser) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            NSURL *imageURL = [NSURL URLWithString:[currentUser objectForKey:@"imgURL"]];
            
            NSData *imgData = [[NSData alloc] initWithContentsOfURL:imageURL];
            
            UIImage *image = [[UIImage alloc]initWithData:imgData];
            
            
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                
                
                self.profileImage.image=image;
                self.nameLabel.text = [currentUser objectForKey:@"FName"];
                self.emailLabel.text=currentUser.username;
                self.mobileLabel.text=[currentUser objectForKey:@"mphone"];
                
                
            });
        });
        
    } else {
        [self performSegueWithIdentifier:@"showLogin" sender:self];
    }

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logout:(id)sender {
    
    
    [PFUser logOut];
    
    
    [self performSegueWithIdentifier:@"showLogin" sender:self];
}
- (IBAction)share:(id)sender {
    NSMutableArray *sharingItems = [NSMutableArray new];
    
        [sharingItems addObject:@"I have donated 10 items and I am a Green advocate. Start using entreasure!! "];
   //UIImage *image = [UIImage imageNamed:];
     [sharingItems addObject:[UIImage imageNamed:@"adventurer.png"]];
    [sharingItems addObject:[UIImage imageNamed:@"greatoutdoors.png"]];
    
    
    
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:sharingItems applicationActivities:nil];

[self presentViewController:activityController animated:YES completion:nil];

}
@end
