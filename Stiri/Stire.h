//
//  Stire.h
//  Stiri
//
//  Created by Alex Clapa on 05.07.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stire : NSObject
{
    NSString *titlul2, *descriere2, *link2;
    NSData  *linkImagine;
}

@property (copy, nonatomic) NSString *titlul2, *descriere2, *link2;
@property (nonatomic, retain) NSData *linkImagine;
 
 
+ (Stire *)stirecuTitlul:(NSString *)titlul 
               descriere:(NSString *)descrierea 
               linkStire:(NSString *)link 
           siLinkImagine:(NSData *)linkImagine; 

+ (NSArray *)convertNewsToArray:(Stire *)stire;
+ (Stire *)convertArrayToStire:(NSArray *)array;

@end
