//
//  ViewController.m
//  Stiri
//
//  Created by Alex Clapa on 05.07.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "Stire.h"
#import "StireViewController.h"
#import "SMXMLDocument.h"
#import "Reachability.h"


@interface ViewController ()

@end

@implementation ViewController

@synthesize tableViewOutlet, spinner, lastUpdateTimeLabel, cititaSauNu, saveButton, trebuieDescarcat;

@synthesize toateStirile;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.title = NSLocalizedString(@"gsp.ro", @"");
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        titleLabel.text = self.title;
        titleLabel.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:22];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor whiteColor];
        [titleLabel sizeToFit];
        self.navigationItem.titleView = titleLabel;
        [titleLabel release];
    }
    return self;
}

- (void)refreshFeed
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];    
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    
    if (internetStatus != NotReachable) {
    
        [self.spinner startAnimating];
        self.toateStirile = [[[NSMutableArray alloc] init] autorelease];
    
    

    
        // self.cititaSauNu = [[NSMutableDictionary alloc] init];
    
        NSError *error;
        NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://www.gsp.ro/rss.xml"]];
        SMXMLDocument *document = [SMXMLDocument documentWithData:data error:&error];
        [data release];
        // verificam erorile
    
        if(error) {
            return;
        }
    
        // NSMutableArray *result = [[NSMutableArray alloc] init];
    
        SMXMLElement *items = document.root;
    
        // incepem parsarea
    
        items = [items childNamed:@"channel"];
    
        for(SMXMLElement *item in [items childrenNamed:@"item"]) {
        
            // [self.cititaSauNu addObject:[NSNumber numberWithBool:NO]];
        
            NSString *titlu = [item valueWithPath:@"title"];
            NSString *description = [item valueWithPath:@"description"];
            NSMutableString *url;
            if ([item childNamed:@"enclosure"]!=nil)
            {    
            url = [NSMutableString stringWithString:[[item childNamed:@"enclosure"]attributeNamed:@"url"]];
            [url replaceOccurrencesOfString:@"/imagini/" withString:@"/thumbs/thumb_173_x_144/" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [url length])];
            }
            /*
            Stire *st = [Stire stirecuTitlul:titlu
                                   descriere:description 
                                   linkStire:[item valueWithPath:@"link"]
                               siLinkImagine:[UIImage imageWithData:
                                              [NSData dataWithContentsOfURL:
                                               [NSURL URLWithString: url]]]];
            */
            if (url.length!=0)
            {
            Stire *st = [Stire stirecuTitlul:titlu
                                   descriere:description 
                                   linkStire:[item valueWithPath:@"link"]
                               siLinkImagine:
                                              [NSData dataWithContentsOfURL:
                                               [NSURL URLWithString: url]]];
            
            
            UIImage *testImage = [UIImage imageWithData:
                                  [NSData dataWithContentsOfURL:
                                   [NSURL URLWithString: url]]];
            
            // imageView.image = testImage;
            
            
        
            [self.toateStirile addObject:st];
            }
            //     [self.cititaSauNu setObject:[[NSNumber alloc] initWithBool:NO] forKey:titlu];
            if([self.cititaSauNu objectForKey:titlu] == nil)
            [self.cititaSauNu setObject:@"FALSE" forKey:titlu];
        
            // inainte de modificari:
            [NSURL URLWithString: [[item childNamed:@"enclosure"]
                               attributeNamed:@"url"]];
            /*
             NSMutableString * url = [NSMutableString stringWithString:[[item childNamed:@"enclosure"]attributeNamed:@"url"]];
             [url replaceOccurrencesOfString:@"/imagini/" withString:@"/thumbs/thumb_173_x_144/" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [url length])];
             */
            // st.imageLink = [NSString stringWithString:url];	
        }
        // dam reload data tabelului
    
        [self.tableViewOutlet reloadData];
    
        // obtinem ora curenta
    
        NSDate *currentDate = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd 'at' HH:mm"];
        NSString *formattedDateString = [dateFormatter stringFromDate:currentDate];
    
        NSString *textAfisare = [[NSString alloc] init];
    
        textAfisare = [NSString stringWithFormat:@"Ultima actualizare %@", formattedDateString];
    
        // self.lastUpdateTimeLabel.text = @"Ultima actualizare : ";
        // scriem ora obtinuta intr-un label

    
        self.lastUpdateTimeLabel.text = textAfisare;
        
        // luam din plist-ul UserReadNews stirile citite
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];

        NSString *readNews = [documentsDirectory stringByAppendingPathComponent:@"UserReadNews.plist"];


        
        [self.spinner stopAnimating];
        
    } else {
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Eroare"
                              message: @"Conexiune Internet indisponibila"
                              delegate: nil
                              cancelButtonTitle:@"OK, arata stirile salvate"
                              otherButtonTitles:nil];
        [alert show];
        [alert release];
        
        // incarcam stirile salvate local
        
        NSLog(@"am incarcat stiri");
        
        // NSString *path =[[NSString alloc] initWithString:@"/toateStirile.plist"];
        
        // self.toateStirile = [[NSMutableArray alloc] initWithContentsOfFile:path];
        // self.toateStirile = [NSMutableArray arrayWithContentsOfFile:path];
        // NSLog(@"%@", self.toateStirile);
        
        
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *appFile = [documentsDirectory stringByAppendingPathComponent:@"NewsFeed.plist"];
        
        NSString *readNews = [documentsDirectory stringByAppendingPathComponent:@"UserReadNews.plist"];
        NSString *lastTimeSaved = [documentsDirectory stringByAppendingPathComponent:@"LastTimeLoadedPath.plist"];
                
        NSArray * file = [NSArray arrayWithContentsOfFile:appFile];
        NSMutableArray * copy = [[NSMutableArray alloc] init];
        
        for (NSArray *a in file) {
            [copy addObject:[Stire convertArrayToStire:a]];
        }
        
        self.toateStirile = copy;
        
        self.cititaSauNu = [NSMutableDictionary dictionaryWithContentsOfFile:readNews];
        
        self.lastUpdateTimeLabel.text = [NSString stringWithContentsOfFile:lastTimeSaved
                                                                  encoding:NSUTF8StringEncoding
                                                                     error:nil];
        
        [self.tableViewOutlet reloadData];
    }
    
    // [textAfisare release];
    
    self.trebuieDescarcat = NO;
    
        
}

- (void)saveNews
{
    
    /*
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:@"MyFile.txt"];
    
    NSLog(@"%@", appFile);
    
    
    [self.toateStirile writeToFile:@"/toateStirile.plist" atomically:YES];
    [self.saveButton setEnabled:NO];
     
    
    [@"test" writeToFile:appFile atomically:YES encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"%@",documentsDirectory);
    */
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:@"NewsFeed.plist"];
    
    NSMutableArray *copy = [[NSMutableArray alloc] init];
    for (Stire *stire in self.toateStirile) {
        [copy addObject:[Stire convertNewsToArray:stire]];
    }
    
    NSLog(@"path : %@", appFile);
    
    NSString *readNews = [documentsDirectory stringByAppendingPathComponent:@"UserReadNews.plist"];
    NSString *lastTimeLoadedPath = [documentsDirectory stringByAppendingPathComponent:@"LastTimeLoadedPath.plist"];
    
    NSDate *lastDate = [NSDate date];
    NSDateFormatter * formatedDate = [[NSDateFormatter alloc] init];
    [formatedDate setDateFormat:@"HH:mm:ss"];
    
    self.lastUpdateTimeLabel.text = [@"Last saved at " stringByAppendingString:[formatedDate stringFromDate:lastDate]];
    
    [self.cititaSauNu writeToFile:readNews atomically:YES];
    [copy writeToFile:appFile atomically:YES];
    
    NSDate *lastTimeSavedNews = [NSDate date];
    NSDateFormatter * formated = [[NSDateFormatter alloc] init];
    [formatedDate setDateFormat:@"HH:mm:ss"];
    
    // self.lastUpdateTimeLabel.text = [@"Loaded at " stringByAppendingString:[formated stringFromDate:lastTimeSavedNews]];
    
    NSString *toWrite = [@"Loaded at " stringByAppendingString:[formated stringFromDate:lastTimeSavedNews]];
    
    [toWrite writeToFile:lastTimeLoadedPath 
              atomically:YES
                encoding:NSUTF8StringEncoding
                   error:nil];
    
    /*
    UIImage *testImage = [UIImage imageNamed:@"redwhite.jpg"];
    
    NSData *imageData = UIImageJPEGRepresentation(testImage, 1.0);
    
    
    [imageData writeToFile:appFile atomically:YES];
    
    NSData *dataImageFromFile = [NSData dataWithContentsOfFile:appFile];
    UIImage *imageFromFile = [UIImage imageWithData:dataImageFromFile];
    self.imageView.image = imageFromFile;
    
    NSLog(@"Path - %@", appFile);
    
    */
    
    // [copy release];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.cititaSauNu = [[NSMutableDictionary alloc] init];
    [self.cititaSauNu setObject:@"aa" forKey:@"bb"];
    NSLog(@"Dictionarul este : %@",self.cititaSauNu);
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"soccer.jpg"]];
    self.view.backgroundColor = background;
    [background release];
    // [self refreshFeed];
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc]
                               initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                               target:self
                               action:@selector(refreshFeed)];
    self.navigationItem.rightBarButtonItem = refreshButton;
    [refreshButton release];
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveNews)];
    
    self.navigationItem.leftBarButtonItem = saveButton;
    // [saveButton release];
    
    // spinner
    self.spinner = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];
    //   //NSLog(@"Latime %f Lungime: %f",self.view.bounds.size.width/2.0,self.view.bounds.size.height/2.0);  
    [self.spinner setCenter:CGPointMake(self.view.bounds.size.width/2.0, self.view.bounds.size.height/2.0)]; 
    self.spinner.autoresizingMask=UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin;
    [self.view addSubview:self.spinner];
    // [self.spinner startAnimating];
    // [self changeNavigationButtonColorToColor:[UIColor colorWithRed:184.0/256.0 green:16/256.0 blue:16/256.0 alpha:1.0]];
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"dictionar in view will disappear = %@", self.cititaSauNu);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.spinner startAnimating];
    NSLog(@"citita sau nu %@", self.cititaSauNu);
    [self.tableViewOutlet reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if(self.trebuieDescarcat) 
        [self refreshFeed];
    [self.tableViewOutlet setHidden:NO];
    [self.spinner stopAnimating];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.toateStirile.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"NewsCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    Stire *str = [self.toateStirile objectAtIndex:indexPath.row];
    cell.backgroundColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor colorWithWhite:2 alpha:0.9];
	cell.textLabel.text = str.titlul2;
    cell.detailTextLabel.text = str.descriere2;
    // NSLog(@"Citita sau nu: %@",[self.cititaSauNu objectForKey:str.titlul2]);

    cell.imageView.image = [UIImage imageWithData:str.linkImagine];
    NSLog(@"citita sau nu deasupra de if = %@", self.cititaSauNu);
    if([[self.cititaSauNu objectForKey:str.titlul2] isEqual:@"TRUE"]) {
        // [cell.textLabel textColor:[UIColor blueColor]];
        cell.textLabel.textColor= [UIColor blueColor];
        // NSLog(@"va schimba culoarea");
    } else {
        cell.textLabel.textColor = [UIColor blackColor];
    }
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Stire *str = [self.toateStirile objectAtIndex:indexPath.row];
	StireViewController *svc = [[StireViewController alloc] init];
    svc.descriere = str.descriere2;
    svc.link = str.link2;
    
    [self.cititaSauNu setObject:@"TRUE" forKey:str.titlul2];
    // NSLog(@"dictionary : %@", self.cititaSauNu);
    
    // Stire *ultimaStire = [self.toateStirile objectAtIndex:toateStirile.count + 1];
    svc.title=str.titlul2;
    [self.navigationController pushViewController:svc animated:YES];
    [svc release];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
 //   return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;
}

- (void)dealloc
{
    [tableViewOutlet release];
    [super dealloc];
}
   
@end
