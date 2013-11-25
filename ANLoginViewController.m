//
//  ANLoginViewController.m
//  EnTreasure
//
//  Created by Anirudh narla on 11/23/13.
//  Copyright (c) 2013 Anirudh Narla. All rights reserved.
//

#import "ANLoginViewController.h"
#import "RNBlurModalView.h"

@interface ANLoginViewController ()

@end

@implementation ANLoginViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.email.delegate =self;
    self.password.delegate=self;
    
    
	// Do any additional setup after loading the view.
    }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return true;
}

- (IBAction)logIn:(id)sender {
    
    NSString *username = [self.email.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *password = [self.password.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    
    
    if(username.length == 0 || password.length == 0)
    {
        
        RNBlurModalView *modal = [[RNBlurModalView alloc] initWithViewController:self title:@"Oops!!" message:@"Please enter a valid username/password"];
        [modal show];
        
        
        
    }
    
    
    
    
    else{
        
        [PFUser logInWithUsernameInBackground:username password:password
                                        block:^(PFUser *user, NSError *error) {
                                            if (user) {
                                                [self.navigationController popToRootViewControllerAnimated:YES];
                                            } else {
                                                
                                                NSString *errorString = [error userInfo][@"error"];
                                                UIAlertView *allertView = [[UIAlertView alloc] initWithTitle:@"Error!!" message:errorString delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil , nil ];
                                                [allertView show];
                                                
                                                
                                            }
                                        }];
        
    }
    
    
}

- (IBAction)logout:(id)sender {
    
    
    [PFUser logOut];
    
    
    [self performSegueWithIdentifier:@"showLogin" sender:self];
}

- (IBAction)login:(id)sender {
    
    NSString *username = [self.email.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *password = [self.password.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    
    
    if(username.length == 0 || password.length == 0)
    {
        
        RNBlurModalView *modal = [[RNBlurModalView alloc] initWithViewController:self title:@"Oops!!" message:@"Please enter a valid username/password"];
        [modal show];
        
        
        
    }
    
    
    
    
    else{
        
        [PFUser logInWithUsernameInBackground:username password:password
                                        block:^(PFUser *user, NSError *error) {
                                            if (user) {
                                                [self.navigationController popToRootViewControllerAnimated:YES];
                                            } else {
                                                
                                                NSString *errorString = [error userInfo][@"error"];
                                                UIAlertView *allertView = [[UIAlertView alloc] initWithTitle:@"Error!!" message:errorString delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil , nil ];
                                                [allertView show];
                                                
                                                
                                            }
                                        }];
        
    }
    
}
@end
