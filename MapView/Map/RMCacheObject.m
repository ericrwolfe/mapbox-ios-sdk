//
//  RMCacheObject.m
//
// Copyright (c) 2008-2009, Route-Me Contributors
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// * Redistributions of source code must retain the above copyright notice, this
//   list of conditions and the following disclaimer.
// * Redistributions in binary form must reproduce the above copyright notice,
//   this list of conditions and the following disclaimer in the documentation
//   and/or other materials provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.

#import "RMCacheObject.h"
#import "RMTileCache.h"

@implementation RMCacheObject

@synthesize cachedObject;
@synthesize cacheKey;
@synthesize tile;
@synthesize timestamp;

+ (id)cacheObject:(id)anObject forTile:(RMTile)aTile withCacheKey:(NSString *)aCacheKey
{
    return [[[self alloc] initWithObject:anObject forTile:aTile withCacheKey:aCacheKey] autorelease];
}

- (id)initWithObject:(id)anObject forTile:(RMTile)aTile withCacheKey:(NSString *)aCacheKey
{
    if (!(self = [super init]))
        return nil;

    cachedObject = [anObject retain];
    cacheKey = [aCacheKey retain];
    tile = aTile;
    timestamp = [NSDate new];

    return self;
}

- (void)dealloc
{
    [cachedObject release]; cachedObject = nil;
    [cacheKey release]; cacheKey = nil;
    [timestamp release]; timestamp = nil;
    [super dealloc];
}

- (void)touch
{
    [timestamp autorelease];
    timestamp = [NSDate new];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: tile='%d %d %d (%@)', cache key='%@'>", NSStringFromClass([self class]), tile.x, tile.y, tile.zoom, [RMTileCache tileHash:tile], cacheKey];
}

@end
