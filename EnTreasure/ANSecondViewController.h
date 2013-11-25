//
//  ANSecondViewController.h
//  EnTreasure
//
//  Created by Anirudh narla on 11/23/13.
//  Copyright (c) 2013 Anirudh Narla. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ANSecondViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextFieldDelegate,UITextViewDelegate,CLLocationManagerDelegate>

@property (nonatomic,strong) UIImagePickerController *imagePicker;
@property (weak, nonatomic) IBOutlet UIButton *locationButton;

@property(strong,nonatomic) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UITextField *condition;

@property(nonatomic,strong) UIImage *image;
@property (weak, nonatomic) IBOutlet UITextField *pName;
@property (weak, nonatomic) IBOutlet UITextField *category;
@property (weak, nonatomic) IBOutlet UIImageView *pImage;
@property (weak, nonatomic) IBOutlet UITextView *description;
- (IBAction)getData:(id)sender;

@property(nonatomic,strong) PFUser *currentUser;

- (IBAction)sendData:(id)sender;

-(UIImage*) resizeImage:(UIImage*) image towidth:(float) width toHeight:(float) height;

@property (weak, nonatomic) IBOutlet UIButton *getLocation;
@property (weak, nonatomic) IBOutlet UITextField *bidDays;
@property(strong,nonatomic) PFGeoPoint *point;

@property(strong,nonatomic) CLGeocoder *geocoder;
@property(strong,nonatomic) CLPlacemark *placemark;

@property(strong,nonatomic) NSString *lat;
@property(strong,nonatomic) NSString *lon;

@property(strong,nonatomic) NSString *Address;




@end
