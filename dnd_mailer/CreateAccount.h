//
//  CreateAccount.h
//  dnd_mailer
//
//  Created by Mykola Tarasov on 8/16/16.
//  Copyright © 2016 Mykola Tarasov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateAccount : UITableViewController <UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate>

@property (retain, nonatomic) UITextField *nameField;
@property (retain, nonatomic) UITextField *emailField;
@property (retain, nonatomic) UITextField *passwordField;
@property (retain, nonatomic) UITextField *retypePasswordField;

@property(retain, nonatomic) UIBarButtonItem* doneButton;

@end
