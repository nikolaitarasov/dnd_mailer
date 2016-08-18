//
//  CreateAccount.h
//  dnd_mailer
//
//  Created by Mykola Tarasov on 8/16/16.
//  Copyright © 2016 Mykola Tarasov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateAccount : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *retypePasswordField;

@property(retain, nonatomic) UIBarButtonItem* saveButton;

@end
