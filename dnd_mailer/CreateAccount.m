//
//  CreateAccount.m
//  dnd_mailer
//
//  Created by Mykola Tarasov on 8/16/16.
//  Copyright © 2016 Mykola Tarasov. All rights reserved.
//

#import "CreateAccount.h"
#import "MainMenu.h"

@interface CreateAccount ()

@end

@implementation CreateAccount

static NSString* namePlaceholder = @"Enter full name";
static NSString* emailPlaceholder = @"Enter email address";
static NSString* passwordPlaceholder = @"Enter password";
static NSString* retypePasswordPlaceholder = @"Retype password";


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Create new account";
    
    self.saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                    target:self
                                                                    action:@selector(saveAction:)];

    self.navigationItem.rightBarButtonItem = self.saveButton;
    self.saveButton.enabled = NO;
    
    self.nameField.placeholder = namePlaceholder;
    self.nameField.delegate = self;
    self.emailField.placeholder = emailPlaceholder;
    self.emailField.delegate = self;
    self.passwordField.placeholder = passwordPlaceholder;
    self.passwordField.delegate = self;
    self.retypePasswordField.placeholder = retypePasswordPlaceholder;
    self.retypePasswordField.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) saveAction:(UIButton*) button {
    //NSString* firstName = self.firstNameField.text;
    //NSString* lastName = self.lastNameField.text;
    //NSString* email = self.emailField.text;
   
    // will put additional code here later
    
    MainMenu* mainMenu = [self.storyboard instantiateViewControllerWithIdentifier:@"MainMenu"];
    [self.navigationController pushViewController:mainMenu animated:YES];
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual:self.nameField]) {
        [self.emailField becomeFirstResponder];
        [self.nameField resignFirstResponder];
    } else if ([textField isEqual:self.emailField]) {
        [self.passwordField becomeFirstResponder];
        [self.emailField resignFirstResponder];
    } else if ([textField isEqual:self.passwordField]) {
        [self.retypePasswordField becomeFirstResponder];
        [self.passwordField resignFirstResponder];
    } else {
        [self.retypePasswordField resignFirstResponder];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    textField.placeholder = @"";
    self.saveButton.enabled = NO;
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSString* name = self.nameField.text;
    self.title = self.nameField.text.length > 0 ? name : @"Create new account";
    if (self.nameField.text.length > 0
        && self.emailField.text.length > 0
        && self.passwordField.text.length > 0
        && self.retypePasswordField.text.length > 0) {
        self.saveButton.enabled = YES;
    } else {
        self.saveButton.enabled = NO;
    }
    if (textField.text.length <= 0) {
        if ([textField isEqual:self.nameField]) {
            textField.placeholder = namePlaceholder;
        } else if ([textField isEqual:self.emailField]) {
            textField.placeholder = emailPlaceholder;
        } else if ([textField isEqual:self.passwordField]) {
            textField.placeholder = passwordPlaceholder;
        } else {
            textField.placeholder = retypePasswordPlaceholder;
        }
    }
    if ([self.saveButton isEnabled]) {
        //userFullName = self.title;
    }
}

@end
