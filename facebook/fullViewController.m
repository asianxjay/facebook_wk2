//
//  fullViewController.m
//  facebook
//
//  Created by Jason Demetillo on 6/14/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "fullViewController.h"

@interface fullViewController ()


@property (strong, nonatomic) IBOutlet UIScrollView *scrollFeed;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loadSpin;

-(void)presentFeed;

@end

@implementation fullViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    // set up the scroll view
    self.scrollFeed.contentSize = CGSizeMake(320, 990);
    
    // show spinner first, then hide after 2 secs
    self.scrollFeed.hidden = YES;
    [self performSelector:@selector(presentFeed) withObject:nil afterDelay:2];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)presentFeed {
    [self.loadSpin stopAnimating];
    self.scrollFeed.hidden = NO;
}

@end
