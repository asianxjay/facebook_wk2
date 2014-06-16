//
//  mainViewController.m
//  facebook
//
//  Created by Jason Demetillo on 6/14/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "mainViewController.h"
#import "fullViewController.h"

@interface mainViewController ()

@property (strong, nonatomic) IBOutlet UIView *moveForm;
@property (strong, nonatomic) IBOutlet UIView *moveSign;
@property (strong, nonatomic) IBOutlet UITextField *inputUsername;
@property (strong, nonatomic) IBOutlet UITextField *inputPassword;
@property (strong, nonatomic) IBOutlet UIButton *onLoginbutton;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loadingSpin;

- (IBAction)onLoginTap:(id)sender;
- (IBAction)onTap:(id)sender;
- (IBAction)userEdit:(id)sender;
- (IBAction)passwordEdit:(id)sender;

- (void)willShowKeyboard:(NSNotification *)notification;
- (void)willHideKeyboard:(NSNotification *)notification;

- (void)checkLogin;
- (void)checkFields;
- (void)switchLoggingIn:(BOOL)loggingIn;

@end

@implementation mainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willShowKeyboard:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willHideKeyboard:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)checkFields {
    NSString *username = self.inputUsername.text;
    NSString *password = self.inputPassword.text;
    
    [self switchLoggingIn:NO];
    
    if ([username isEqualToString:@"muldoon@ingen.com"] && [password isEqualToString:@"clevergirl"]) {
        
        // clear out the fields
        self.inputUsername.text = @"";
        self.inputPassword.text = @"";
        [self checkLogin];
        
        
        UIViewController *vc = [[fullViewController alloc] init];
        vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        
        [self presentViewController:vc animated:YES completion:nil];
        
        } else {
        // show alert dialog
        UIAlertView *alertView =
        [[UIAlertView alloc]
         initWithTitle: @"Nuh uh uh."
         message: @"You didn't say the magic word."
         delegate:nil
         cancelButtonTitle: @"Ok"
         otherButtonTitles: nil];
        
        [alertView show];
    }
}

- (IBAction)onLoginTap:(id)sender {
    [self.view endEditing:YES];
    
    [self switchLoggingIn:YES];
    
    [self performSelector:@selector(checkFields) withObject:nil afterDelay:2];
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)userEdit:(id)sender {
      [self checkLogin];
}

- (IBAction)passwordEdit:(id)sender {
      [self checkLogin];
}

- (void)willShowKeyboard:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the keyboard height and width from the notification
    // Size varies depending on OS, language, orientation
    CGSize kbSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    NSLog(@"Height: %f Width: %f", kbSize.height, kbSize.width);
    
    // Get the animation duration and curve from the notification
    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;
    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = curveValue.intValue;
    
    // Move the view with the same duration and animation curve so that it will match with the keyboard animation
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(animationCurve << 16)
                     animations:^{
                         self.moveForm.frame = CGRectMake(0, self.view.frame.size.height - kbSize.height - self.moveForm.frame.size.height - 29, self.moveForm.frame.size.width, self.moveForm.frame.size.height);
                         
                         self.moveSign.frame = CGRectMake(0, self.view.frame.size.height - kbSize.height - self.moveSign.frame.size.height - 9, self.moveSign.frame.size.width, self.moveSign.frame.size.height);
                     }
                     completion:nil];
}

- (void)willHideKeyboard:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the animation duration and curve from the notification
    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;
    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = curveValue.intValue;
    
    // Move the view with the same duration and animation curve so that it will match with the keyboard animation
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(animationCurve << 16)
                     animations:^{
                         self.moveForm.frame = CGRectMake(0, self.view.frame.size.height - self.moveForm.frame.size.height - 219, self.moveForm.frame.size.width, self.moveForm.frame.size.height);
                         
                         self.moveSign.frame = CGRectMake(0, self.view.frame.size.height - self.moveSign.frame.size.height - 49, self.moveSign.frame.size.width, self.moveSign.frame.size.height);
                         
                     }
                     completion:nil];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self checkLogin];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)checkLogin {
    NSString *username = self.inputUsername.text;
    NSString *password = self.inputPassword.text;
    
    if ([username isEqualToString:@""] || [password isEqualToString:@""]) {
        self.onLoginbutton.enabled = NO;
        self.onLoginbutton.layer.opacity = 0.5;
    } else {
        self.onLoginbutton.enabled = YES;
        self.onLoginbutton.layer.opacity = 1;
    }
}

- (void)switchLoggingIn:(BOOL)loggingIn {
    if (loggingIn) {
        [self.onLoginbutton setTitle:@"Logging In" forState:UIControlStateDisabled];
        self.onLoginbutton.enabled = NO;
        self.onLoginbutton.layer.opacity = 0.5;
        
        [self.loadingSpin startAnimating];
    } else {
        [self.onLoginbutton setTitle:@"Log In" forState:UIControlStateDisabled];
        self.onLoginbutton.enabled = YES;
        self.onLoginbutton.layer.opacity = 1;
        
        [self.loadingSpin stopAnimating];
    }
}


@end
