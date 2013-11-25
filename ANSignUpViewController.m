//
//  ANSignUpViewController.m
//  EnTreasure
//
//  Created by Anirudh narla on 11/23/13.
//  Copyright (c) 2013 Anirudh Narla. All rights reserved.
//

#import "ANSignUpViewController.h"
#import "RNBlurModalView.h"
#import <Parse/Parse.h>
#import "MBProgressHUD.h"

@interface ANSignUpViewController ()

@end

@implementation ANSignUpViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    // Set up Camera
    
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate = self;
    self.imagePicker.editing = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)SignUp:(id)sender {
    
    NSString *email = [self.email.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *password = [self.password.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *mobile = [self.mobileNumber.text   stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
   
    NSString *fullname = [self.FName.text   stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    
    
    if(mobile.length == 0)
    {
        
        
        NSString *errorString = @"The Mobile you entered is incorrect";
        
        RNBlurModalView *modal = [[RNBlurModalView alloc] initWithViewController:self title:@"Oops!!" message:errorString];
        [modal show];
        
        
        
    }
    
    else if(fullname.length == 0)
    {

        
        NSString *errorString = @"The Name you entered is incorrect";
        
        RNBlurModalView *modal = [[RNBlurModalView alloc] initWithViewController:self title:@"Oops!!" message:errorString];
        [modal show];
        
    }
    
    else if(password.length == 0)
    {
        NSString *errorString = @"The password you entered is incorrect";
        
        RNBlurModalView *modal = [[RNBlurModalView alloc] initWithViewController:self title:@"Oops!!" message:errorString];
        [modal show];
        
    }
    
    else if(email.length == 0)
    {
        NSString *errorString = @"The email you entered is incorrect";
        
        RNBlurModalView *modal = [[RNBlurModalView alloc] initWithViewController:self title:@"Oops!!" message:errorString];
        [modal show];
        
    }
    
    else{
        
   
        
        NSData *mediaData= UIImageJPEGRepresentation(self.profileImage.image, 0.5f);
    
    PFFile *dataFile = [PFFile fileWithName:@"profile.png" data:mediaData];
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            
            
            
            
            
    [dataFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        if(error)
            
        {
            NSString *errorString = [error userInfo][@"error"];
            
            
            RNBlurModalView *modal = [[RNBlurModalView alloc] initWithViewController:self title:@"Oops!!" message:errorString];
            [modal show];
            
        }
        
        else
        {
            
            // Setting the username on Parse.com
            PFUser *user = [PFUser user];
            user.username = email;
            user.password = password;
            user.email = email;
            user[@"FName"]=fullname;
            user[@"mphone"]= mobile;
            user[@"imgURL"]= dataFile.url;
            
            // other fields can be set just like with PFObject
            //user[@"phone"] = @"415-392-0202";
            
            [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (!error) {
                    [self.navigationController popToRootViewControllerAnimated:YES];
                      [self.tabBarController setSelectedIndex:0];
                    
                    
                } else {
                    NSString *errorString = [error userInfo][@"error"];
                    
                    
                    RNBlurModalView *modal = [[RNBlurModalView alloc] initWithViewController:self title:@"Oops!!" message:errorString];
                    [modal show];
                    
                    
                    // Show the errorString somewhere and let the user try again.
                }
            }];
        }
        
        
        
        
    }];
            dispatch_async(dispatch_get_main_queue(), ^{
               
              
                
            });
                       
        });
    }

    
}

  
     
       // [self dismissViewControllerAnimated:NO completion:nil];
        

    
    


- (IBAction)chooseImage:(id)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"Edit Photo" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo",@"Choose Existing", nil];
    
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    
    [actionSheet showInView:self.view];
    
    
}


// To handle ActionSheet


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        
            
        case 0:
            self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:self.imagePicker animated:NO completion:Nil];
            break;
            
        case 1:
            self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:self.imagePicker animated:NO completion:Nil];
            
            
            break;
            
            
            
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    
    // NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImage *newImage = [self resizeImage:image towidth:320.0f toHeight:580.0f];
    
    
    
    self.profileImage.image = newImage;
    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
  
}


-(UIImage*) resizeImage:(UIImage*) image towidth:(float) width toHeight:(float) height
{
    float actualHeight = image.size.height;
    float actualWidth = image.size.width;
    float imgRatio = actualWidth/actualHeight;
    float maxRatio = width/height;
    
    if(imgRatio!=maxRatio){
        if(imgRatio < maxRatio){
            imgRatio = width/ actualHeight;
            actualWidth = imgRatio * actualWidth;
            actualHeight = height;
        }
        else{
            imgRatio = width / actualWidth;
            actualHeight = imgRatio * actualHeight;
            actualWidth = width;
        }
    }
    CGRect rect = CGRectMake(0.0, 0.0, actualWidth, actualHeight);
    UIGraphicsBeginImageContext(rect.size);
    [image drawInRect:rect];
    UIImage *resizedImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resizedImg;
    
    
}

@end
