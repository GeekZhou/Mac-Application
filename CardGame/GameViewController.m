//
//  GameViewController.m
//  CardGame
//
//  Created by Danny Deng on 5/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()

@end

@implementation GameViewController
@synthesize pdfView = _pdfView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
        NSURL *url = [NSURL URLWithString:@"http://www.csc.liv.ac.uk/~michele/CARDS/b01.pdf"];
        PDFDocument *pdfDoc = [[PDFDocument alloc] initWithURL:url];
        [_pdfView setDocument:pdfDoc];

    }
    
    return self;
}

@end
