//
//  StireViewController.m
//  Stiri
//
//  Created by Alex Clapa on 05.07.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StireViewController.h"
#import "Stire.h"

@interface StireViewController () <FacebookLikeViewDelegate, FBSessionDelegate>

@end

@implementation StireViewController

@synthesize facebookLikeView=_facebookLikeView;

@synthesize label, descriere,webView, link;
/*
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        _facebook = [[Facebook alloc] initWithAppId:@"158575400878173" andDelegate:self];

    }
    return self;
}
*/

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{ 
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
      /*
        self.title = NSLocalizedString(@"Detalii Stire Curenta", @"");
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        titleLabel.text = self.title;
        titleLabel.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:16];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor whiteColor];
        [titleLabel sizeToFit];
        self.navigationItem.titleView = titleLabel;
        [titleLabel release];
       */
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.label.text = self.descriere;
    // NSLog(@"Linkul incarcat este: %@", self.link);
    
    //  [self.webView loadHTMLString:self.link baseURL:nil];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.link]]];
    //Setare Font Titlu fereastra    
     UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
     titleLabel.text = self.title;
     titleLabel.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:16];
     titleLabel.backgroundColor = [UIColor clearColor];
     titleLabel.textColor = [UIColor whiteColor];
     [titleLabel sizeToFit];
     self.navigationItem.titleView = titleLabel;
     [titleLabel release];
     
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _facebook = [[Facebook alloc] initWithAppId:@"158575400878173" andDelegate:self];

    // Do any additional setup after loading the view from its nib.
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"soccer.jpg"]];
    self.view.backgroundColor = background;
    
    
    self.facebookLikeView.href = [NSURL URLWithString:self.link];

    self.facebookLikeView.layout = @"button_count";
    self.facebookLikeView.showFaces = NO;
    
    self.facebookLikeView.alpha = 0;
    [self.facebookLikeView load];

}

- (void)viewDidUnload
{
    [self setLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
   // return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;
}

- (void)dealloc {
    [_facebook release];
    [label release];
    [link release];
    [webView release];
    [super dealloc];
}


#pragma mark FBSessionDelegate methods

- (void)fbDidLogin {
	self.facebookLikeView.alpha = 1;
    [self.facebookLikeView load];
}

- (void)fbDidLogout {
	self.facebookLikeView.alpha = 1;
    [self.facebookLikeView load];
}

#pragma mark FacebookLikeViewDelegate methods

- (void)facebookLikeViewRequiresLogin:(FacebookLikeView *)aFacebookLikeView {
    [_facebook authorize:[NSArray array]];
}

- (void)facebookLikeViewDidRender:(FacebookLikeView *)aFacebookLikeView {
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationDelay:0.5];
    self.facebookLikeView.alpha = 1;
    [UIView commitAnimations];
}

- (void)facebookLikeViewDidLike:(FacebookLikeView *)aFacebookLikeView {
    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Liked"
                                                     message:@"Ai dat like stirii"
                                                    delegate:self 
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil] autorelease];
    [alert show];
}

- (void)facebookLikeViewDidUnlike:(FacebookLikeView *)aFacebookLikeView {
    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Unliked"
                                                     message:@"Ai dat unlike stirii"
                                                    delegate:self 
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil] autorelease];
    [alert show];
}

@end
