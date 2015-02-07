//
//  vcAdd.h
//  Lab03
//
//  Created by Alejandra B on 03/02/15.
//  Copyright (c) 2015 alebautista. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface vcAdd : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *btnSave;
@property (strong, nonatomic) IBOutlet UITextField *txtName;
@property (strong, nonatomic) IBOutlet UITextField *txtStatus;
@property (strong, nonatomic) IBOutlet UITextField *txtVideo;
@property (strong, nonatomic) IBOutlet UIImageView *imgPhoto;
- (IBAction)btnImg:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnBack;
@property (strong, nonatomic) IBOutlet UILabel *lblGuardar;
@property (strong, nonatomic) IBOutlet UILabel *lblId;

@end
