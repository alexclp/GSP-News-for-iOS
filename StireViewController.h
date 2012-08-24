//
//  StireViewController.h
//  Stiri
//
//  Created by Alex Clapa on 05.07.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"
#import "FacebookLikeView.h"

@interface StireViewController : UIViewController
{
    IBOutlet UILabel *label;
    NSString *descriere;
    IBOutlet UIWebView *webView;
    NSString *link;
    Facebook *_facebook;
}
@property (nonatomic, copy) NSString *link; 
@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (retain, nonatomic) IBOutlet UILabel *label;
@property (copy, nonatomic) NSString *descriere;
@property (nonatomic, retain) IBOutlet FacebookLikeView *facebookLikeView;
@end
