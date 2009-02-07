//
//  NSMainMenuController.h
//  iConMerge
//
//  Created by Daniel Leping on 2/1/09.
//  Copyright 2009 Mocra. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface NSMainMenuController : NSObject {
	IBOutlet NSAnyImageView* imageView1;
	IBOutlet NSAnyImageView* imageView2;
	IBOutlet NSSaveableImageView* imageView3;
	
	IBOutlet NSMenuItem* menuItemOpenMain;
	IBOutlet NSMenuItem* menuItemOpenOverlay;
	IBOutlet NSMenuItem* menuItemSaveICNS;
	IBOutlet NSMenuItem* menuItemSaveCI;
}

- (IBAction) swapAction:sender;
- (IBAction) mergeAction:sender;
- (IBAction) openAction:sender;
- (IBAction) saveAction:sender;
- (IBAction) windowClose:sender;

@end
