//
//  NSAnyImageView.m
//  iConMerge
//
//  Created by Daniel Leping on 1/31/09.
//  Copyright 2009 Mocra. All rights reserved.
//

#import "NSAnyImageView.h"

@implementation NSAnyImageView

- (id)initWithFrame:(NSRect)frame {
  if (self = [super initWithFrame:frame]) {
  }
  return self;
}

- (void) unclearIfPossible {
	if( image == nil ) {
		image = [self image];
	}
}

- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender
{
	NSDragOperation dragOperation = [super draggingEntered:(id <NSDraggingInfo>)sender];
	if( dragOperation != NSDragOperationNone ) {
		dragAcceptedByParent = YES;
		return dragOperation;
	}
  if ((NSDragOperationCopy & [sender draggingSourceOperationMask]) == NSDragOperationCopy) {
		dragAcceptedByParent = NO;
		return [[NSArray arrayWithObjects: NSFilenamesPboardType, nil] count] == 1 ? NSDragOperationCopy : NSDragOperationNone;
	}
  else {
    return NSDragOperationNone;
  }
}

- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender
{
	if( dragAcceptedByParent ) {
		[self unclearIfPossible];
		return [super performDragOperation:(id <NSDraggingInfo>)sender];
	}
	//we have a list of file names in an NSData object
	NSArray *fileArray = [[sender draggingPasteboard] propertyListForType:NSFilenamesPboardType];
	//be caseful since this method returns id.  
	//We just happen to know that it will be an array.
//	NSString *path = [fileArray objectAtIndex:0];
	//assume that we can ignore all but the first path in the list
	//NSImage *newImage = [[NSImage alloc] initWithContentsOfFile:path];
/*	NSImage *newImage = [[NSWorkspace sharedWorkspace] iconForFile:path];
	if (nil == newImage) {
		//we failed for some reason
		//NSRunAlertPanel(@"File Reading Error", [NSString stringWithFormat:@"Sorry, but I failed to open the file at \"%@\"", path], nil, nil, nil);
		return NO;
	}
	//newImage is now a new valid image
	NSSize imageSize = { 256, 256 };
	[newImage setSize:imageSize];
	self.image = newImage;
	[self setNeedsDisplay:YES];    //redraw us with the new image
	[self sendAction:super.action to:super.target];
    return YES;*/
	if( [self loadFile:[fileArray objectAtIndex:0] tryImage:NO] ) {
		[self setNeedsDisplay:YES];
		[self sendAction:super.action to:super.target];
    return YES;
	}
	return NO;
	
}

- (bool) loadFile:(NSString*)filename tryImage:(bool)tryImage {
	[self unclearIfPossible];
	NSImage *newImage = nil;
	if( tryImage ) {
		newImage = [[NSImage alloc] initWithContentsOfFile:filename];
	}
	if( newImage == nil ) {
		newImage = [[NSWorkspace sharedWorkspace] iconForFile:filename];
		if( newImage != nil ) {
			NSSize imageSize = { 256, 256 };
			[newImage setSize:imageSize];
		}

	}
	if ( newImage == nil ) {
		return NO;
	}
	self.image = newImage;
  [[NSNotificationCenter defaultCenter]postNotificationName:NSAnyImageViewDraggedImage object:self];
	return YES;
}

- (bool) loadFile:(NSString*)filename {
	return [self loadFile:filename tryImage:YES];
}

- (bool) clear {
	return image == nil || image == [self image];
}

@end