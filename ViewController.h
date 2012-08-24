//
//  ViewController.h
//  Stiri
//
//  Created by Alex Clapa on 05.07.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreFoundation/CoreFoundation.h>
#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>

@interface ViewController : UIViewController
{
    NSMutableArray *toateStirile;
    IBOutlet UITableView *tableViewOutlet;
    UIActivityIndicatorView *spinner;
    IBOutlet UILabel *lastUpdateTimeLabel;
    NSMutableDictionary *cititaSauNu;
    UIBarButtonItem *saveButton;
    BOOL trebuieDescarcat;
}

- (void)refreshFeed;
- (void)saveNews;

@property (retain, nonatomic) UIBarButtonItem *saveButton;
@property (retain, nonatomic) NSMutableDictionary *cititaSauNu;
@property (retain, nonatomic) IBOutlet UILabel *lastUpdateTimeLabel;
@property (retain, nonatomic) UIActivityIndicatorView *spinner;
@property (retain, nonatomic) IBOutlet UITableView *tableViewOutlet;
@property (retain, nonatomic) NSMutableArray *toateStirile;
@property BOOL trebuieDescarcat;

@end
