//
//  SignInView.h
//  dnd_mailer
//
//  Created by Mykola Tarasov on 8/17/16.
//  Copyright © 2016 Mykola Tarasov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginView : UITableViewController <UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate>
@property (retain, nonatomic) UITextField *emailField;
@property (retain, nonatomic) UITextField *passwordField;
@property(retain, nonatomic) UIBarButtonItem* signInButton;
@property(retain, nonatomic) UISwitch* rememberMe;

@end
