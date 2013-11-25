//
//  ANSignUpViewController.h
//  EnTreasure
//
//  Created by Anirudh narla on 11/23/13.
//  Copyright (c) 2013 Anirudh Narla. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ANSignUpViewController : UIViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>


@property (weak, nonatomic) IBOutlet UIImageView *profileImage;

@property (weak, nonatomic) IBOutlet UITextField *FName;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;

@property (nonatomic,strong) UIImagePickerController *imagePicker;

@property (weak, nonatomic) IBOutlet UITextField *mobileNumber;



- (IBAction)SignUp:(id)sender;


- (IBAction)chooseImage:(id)sender;

@end
