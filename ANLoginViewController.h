//
//  ANLoginViewController.h
//  EnTreasure
//
//  Created by Anirudh narla on 11/23/13.
//  Copyright (c) 2013 Anirudh Narla. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ANLoginViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;



- (IBAction)login:(id)sender;

@end
