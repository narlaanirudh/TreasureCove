//
//  ANSecondViewController.m
//  EnTreasure
//
//  Created by Anirudh narla on 11/23/13.
//  Copyright (c) 2013 Anirudh Narla. All rights reserved.
//

#import "ANSecondViewController.h"
#import "RNBlurModalView.h"
#import "MBProgressHUD.h"

@interface ANSecondViewController ()

@end

@implementation ANSecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.currentUser = [PFUser currentUser];
    
    self.description.delegate = self;
    
    
    self.navigationController.navigationBarHidden = YES;
	// Do any additional setup after loading the view, typically from a nib.
    
    
    //Designing the textview slightly
    
    [self.description.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
    [self.description.layer setBorderWidth:2.0];
    
    //Designing the textfields
    
    [self.pName.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
    [self.pName.layer setBorderWidth:2.0];
    
    [self.category.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
    [self.category.layer setBorderWidth:2.0];
    
    //The rounded corner part, where you specify your view's corner radius:
    self.description.layer.cornerRadius = 5;
    self.description.clipsToBounds = YES;
    
    
    self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.geocoder = [[CLGeocoder alloc] init];
}

-(void)viewWillAppear:(BOOL)animated
{
    
    if(self.image == NULL)
    {
        self.imagePicker = [[UIImagePickerController alloc] init];
        self.imagePicker.delegate = self;
        self.imagePicker.editing = NO;
        
        //TODO change to camera again
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:self.imagePicker animated:NO completion:Nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    self.image=nil;
     [self.tabBarController setSelectedIndex:0];
    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
   
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    
    // NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImage *newImage = [self resizeImage:image towidth:640.0f toHeight:1136.0f];
    
    self.image = newImage;
    self.pImage.image=newImage;
    
    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
    
}




- (IBAction)sendData:(id)sender {
    
    NSString *pName = [self.pName.text   stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *category= [self.category.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *description = [self.description.text   stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *bidDays = [self.bidDays.text   stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    
    
    if(pName.length == 0)
    {
        
        
        NSString *errorString = @"The Product Name you entered is incorrect";
        
        RNBlurModalView *modal = [[RNBlurModalView alloc] initWithViewController:self title:@"Oops!!" message:errorString];
        [modal show];
        
        
        
    }
    
    else if(category.length == 0)
    {
        
        
        NSString *errorString = @"The Category you entered is incorrect";
        
        RNBlurModalView *modal = [[RNBlurModalView alloc] initWithViewController:self title:@"Oops!!" message:errorString];
        [modal show];
        
    }
    
    else if(description.length == 0)
    {
        NSString *errorString = @"Please enter a Description";
        
        RNBlurModalView *modal = [[RNBlurModalView alloc] initWithViewController:self title:@"Oops!!" message:errorString];
        [modal show];
        
    }
    
    else if(category.length == 0)
    {
        NSString *errorString = @"The email you entered is incorrect";
        
        RNBlurModalView *modal = [[RNBlurModalView alloc] initWithViewController:self title:@"Oops!!" message:errorString];
        [modal show];
        
    }
    
    else{
        
        NSData *mediaData= UIImagePNGRepresentation(self.image);
        
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
                
                
                
                PFObject *message1 = [PFObject objectWithClassName:@"products"];
                message1[@"ProductName"] =pName;
                message1[@"Category"]=category;
                message1[@"Description"] = description;
                message1[@"bidDays"]=bidDays;
                NSLog(@"%@",dataFile.url);
                message1[@"imgURL"]= dataFile.url;
                message1[@"condition"]=self.condition.text;
                PFUser *currentUser = [PFUser currentUser];
                message1[@"UserID"]= currentUser.objectId;
               
                message1[@"SenderName"]= [currentUser objectForKey:@"FName"];
                
               
                message1[@"lat"]=self.lat;
                message1[@"lon"]=self.lon;
                message1[@"address"]=self.Address;
                NSNumber *temp = @0;
               message1[@"maxBid"] =temp;
                
                    
                [message1 saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (error) {
                        NSString *errorString = [error userInfo][@"error"];
                        
                        
                        RNBlurModalView *modal = [[RNBlurModalView alloc] initWithViewController:self title:@"Oops!!" message:errorString];
                        [modal show];
                        
                        
                    }
                    
                    else{
                        self.image = NULL;
                        
                        
                        self.pName.text = @"";
                        self.category.text=@"";
                        self.condition.text=@"";
                        
                        self.bidDays.text = @"7";
                        self.description.text=@"Please enter the description here";
                                                [self.locationManager stopUpdatingLocation];
                    
                    }
                }];
                    // Do something...
                

            }
          
        }];
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [self.tabBarController setSelectedIndex:0];
            });
        });
        
    }
    
    
}




- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    textView.text=@"";
    
    return YES;
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
    
    UIImageJPEGRepresentation(<#UIImage *image#>, <#CGFloat compressionQuality#>)
    
    return resizedImg;
    
    
}

    
- (IBAction)getData:(id)sender {
    
    NSLog(@"Trying to change color");
    
    self.locationButton.tintColor = [UIColor greenColor];
    
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [self.locationManager  startUpdatingLocation ];
    
    
}


#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
   // NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
    
        
        
        
        
    
    
    //self.placemark = [[CLPlacemark alloc]init];
    self.lon = [NSString stringWithFormat:@"%.5f", currentLocation.coordinate.longitude];
    self.lat = [NSString stringWithFormat:@"%.5f", currentLocation.coordinate.latitude];
    
    //NSLog(@"Resolving the Address");
    [self.geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        //NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
        if (error == nil && [placemarks count] > 0) {
            self.placemark = [placemarks lastObject];
            self.Address= [NSString stringWithFormat:@"%@ %@\n%@ %@",
                                  self.placemark.thoroughfare,
                                  self.placemark.locality,
                                 self.placemark.administrativeArea,
                                 self.placemark.country];
        } else {
            NSLog(@"%@", error.debugDescription);
        }
    } ];
    }
}
    @end
    

