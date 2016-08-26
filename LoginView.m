//
//  SignInView.m
//  dnd_mailer
//
//  Created by Mykola Tarasov on 8/17/16.
//  Copyright © 2016 Mykola Tarasov. All rights reserved.
//

#import "LoginView.h"
#import "MainMenu.h"
#import <Parse/PFUser.h>
#import "MBProgressHUD.h"

@interface LoginView ()
@property(strong, nonatomic) NSMutableArray* UIElements;
@property(weak, nonatomic) UIFont* defaultFont;

@end

@implementation LoginView

static NSString* emailPlaceholder = @"Enter email address";
static NSString* passwordPlaceholder = @"Enter password";


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    
    self.navigationController.navigationBar.topItem.title = @"";
    self.title = @"Login to your account";
    self.UIElements = [[NSMutableArray alloc] init];
    self.UIElements = [self createNameFields];
    
    self.signInButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                    target:self
                                                                    action:@selector(doneAction:)];
    
    self.navigationItem.rightBarButtonItem = self.signInButton;
    
    _defaultFont = [UIFont fontWithName:@"Helvetica" size:16];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)rememberUser:(id)sender {
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    if(_rememberMe.on) {
        [defaults setObject:@"on" forKey:@"rememberMeSwitch"];
        
        NSString* email = self.emailField.text;
        [defaults setObject:email forKey:@"emailText"];
        
        NSString *password = self.passwordField.text;
        [defaults setObject:password forKey:@"passwordText"];
    } else {
        [defaults setObject:@"off" forKey:@"rememberMeSwitch"];
        [defaults setObject:@"" forKey:@"emailText"];
        [defaults setObject:@"" forKey:@"passwordText"];
    }
    [defaults synchronize];
    
}

- (void) doneAction:(UIButton*) button {
    NSString* email = _emailField.text;
    NSString* password = _passwordField.text;
    
    UIAlertController *alert = nil;
    if (email.length <= 0 && password.length <= 0) {
        alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                    message:@"Please enter your email address and password!"
                                             preferredStyle:UIAlertControllerStyleAlert];
    } else if (email <= 0) {
        alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                message:@"Please enter your email address!"
                                                                preferredStyle:UIAlertControllerStyleAlert];
    } else if (password <= 0) {
        alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                    message:@"Please enter your password!"
                                             preferredStyle:UIAlertControllerStyleAlert];
    } else {
        
        if (email <= 0) {
            alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                        message:@"Please enter your email address!"
                                                 preferredStyle:UIAlertControllerStyleAlert];
        }
        if (password.length < 2) {
            alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                        message:@"Password must be greater than 8 characters!"
                                                 preferredStyle:UIAlertControllerStyleAlert];
        }
    
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        if (alert) {
            [alert addAction:actionOk];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
        
        // Show progress
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.label.text = @"Logging in...";
        [hud showAnimated:YES];
        
        [PFUser logInWithUsernameInBackground:email password:password block: ^(PFUser *user, NSError* error) {
            // Stop the spinner
            [hud hideAnimated:YES];
            
            if (user != nil) {
                dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
                    //Background Thread
                    dispatch_async(dispatch_get_main_queue(), ^(void){
                        MainMenu* mainMenu = [self.storyboard instantiateViewControllerWithIdentifier:@"MainMenu"];
                        [self.navigationController pushViewController:mainMenu animated:YES];
                    });
                });
                
            } else {
                UIAlertController * failureAlert = nil;
                if (error.code == 101) {
                    failureAlert = [UIAlertController alertControllerWithTitle:@"Error"
                                                            message:@"Invalid username/password"
                                                     preferredStyle:UIAlertControllerStyleAlert];
                } else {
                    failureAlert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                       message:@"Login failed"
                                                                preferredStyle:UIAlertControllerStyleAlert];
                }
                [failureAlert addAction:[UIAlertAction actionWithTitle:@"Ok"
                                                                 style:UIAlertActionStyleDefault
                                                               handler:nil]];
                [self presentViewController:failureAlert animated:YES completion:nil];
            }
        }];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 15;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString* title = @"";
    return title;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 45.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 500.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    }
    
    if (indexPath.row == 0) {
        UITextField *tf = (UITextField*)cell.accessoryView;
        tf = [self.UIElements objectAtIndex:0];
        cell.textLabel.text = @"Email";
        cell.accessoryView = cell.editingAccessoryView = tf;
    } else if (indexPath.row == 1) {
        UITextField *tf = (UITextField*)cell.accessoryView;
        tf = [self.UIElements objectAtIndex:1];
        cell.textLabel.text = @"Password";
        cell.accessoryView = cell.editingAccessoryView = tf;
    } else if (indexPath.row == 2) {
        _rememberMe = (UISwitch*)cell.accessoryView;
        _rememberMe = [[UISwitch alloc] init];
        cell.textLabel.text = @"Remember me";
        cell.accessoryView = cell.editingAccessoryView = _rememberMe;
        
         NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
        if ([[defaults valueForKey:@"rememberMeSwitch"] isEqualToString:@"on"]) {
            [_rememberMe setOn:YES animated:NO];
            NSString *email = [defaults stringForKey:@"emailText"];
            NSString *password = [defaults stringForKey:@"passwordText"];
            
            self.emailField.text = email;
            self.passwordField.text = password;
        } else {
            [_rememberMe setOn:NO animated:NO];
        }
        
        if (self.emailField.text.length > 0
            && self.passwordField.text.length > 0) {
            self.signInButton.enabled = YES;
        } else {
            self.signInButton.enabled = NO;
        }
        
        [_rememberMe addTarget:self action:@selector(rememberUser:)
              forControlEvents:UIControlEventValueChanged];
    }
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
   if ([textField isEqual:self.emailField]) {
        [self.passwordField becomeFirstResponder];
        [self.emailField resignFirstResponder];
    } else {
        [self.passwordField resignFirstResponder];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    textField.placeholder = @"";
    textField.borderStyle = UITextBorderStyleRoundedRect;
    self.signInButton.enabled = NO;
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
    textField.borderStyle = UITextBorderStyleNone;
    self.title = @"Login to your account";
    if (textField.text.length <= 0) {
        if ([textField isEqual:self.emailField]) {
            textField.placeholder = emailPlaceholder;
        } else if ([textField isEqual:self.passwordField]) {
            textField.placeholder = passwordPlaceholder;
        }
    }
    if (self.emailField.text.length > 0
        && self.passwordField.text.length > 0) {
        self.signInButton.enabled = YES;
    } else {
        self.signInButton.enabled = NO;
    }
}


#pragma mark - Private methods

- (NSMutableArray*) createNameFields {
    
    CGRect frame = CGRectMake(0, 0, self.tableView.bounds.size.width/2, 40);
    
    // email field
    self.emailField = [[UITextField alloc] initWithFrame:frame];
    self.emailField.font = _defaultFont;
    self.emailField.backgroundColor =[UIColor whiteColor];
    self.emailField.placeholder = emailPlaceholder;
    self.emailField.textAlignment = NSTextAlignmentLeft;
    self.emailField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.emailField.keyboardType = UIKeyboardTypeEmailAddress;
    self.emailField.returnKeyType = UIReturnKeyDone;
    self.emailField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.emailField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.emailField.delegate = self;
    self.emailField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    // password field
    self.passwordField = [[UITextField alloc] initWithFrame:frame];
    self.passwordField.font = _defaultFont;
    self.passwordField.backgroundColor = [UIColor whiteColor];
    self.passwordField.placeholder = passwordPlaceholder;
    self.passwordField.textAlignment = NSTextAlignmentLeft;
    self.passwordField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.passwordField.keyboardType = UIKeyboardTypeNamePhonePad;
    self.passwordField.returnKeyType = UIReturnKeyDone;
    self.passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passwordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.passwordField.delegate = self;
    self.passwordField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.passwordField.secureTextEntry = YES;
    
    // create an array with all fields
    self.UIElements = [NSMutableArray arrayWithObjects: self.emailField, self.passwordField, nil];
    
    return self.UIElements;
}

@end
