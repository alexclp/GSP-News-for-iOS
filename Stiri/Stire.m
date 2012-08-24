//
//  Stire.m
//  Stiri
//
//  Created by Alex Clapa on 05.07.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Stire.h"

@implementation Stire

@synthesize titlul2, descriere2, link2, linkImagine;

+ (Stire *)stirecuTitlul:(NSString *)titlul descriere:(NSString *)descrierea linkStire:(NSString *)link siLinkImagine:(NSData *)linkImagine 
{
    Stire *stire = [[Stire alloc] init];
    stire.titlul2 = titlul;
    stire.descriere2 = descrierea;
    stire.link2 = link;
    stire.linkImagine = linkImagine;
    // stire.linkImagine = linkImagine;
    // data = linkImagine;
    return stire;
}

+ (NSArray *)convertNewsToArray:(Stire *)stire
{
    // NSData *imageData = UIImageJPEGRepresentation(stire.linkImagine, 1.0);
    NSMutableArray *arr = [[[NSMutableArray alloc] init] autorelease];
    [arr addObject:stire.titlul2];
    [arr addObject:stire.descriere2];
    [arr addObject:stire.link2];
    [arr addObject:stire.linkImagine];
    
    return [NSArray arrayWithArray:arr];
}

+ (Stire *)convertArrayToStire:(NSArray *)array
{
    Stire *stre = [[[Stire alloc] init] autorelease];
    stre.titlul2 = [array objectAtIndex:0];
    stre.descriere2 = [array objectAtIndex:1];
    stre.link2 = [array objectAtIndex:2];
    stre.linkImagine = [array objectAtIndex:3];
    
    return stre;
}

@end
