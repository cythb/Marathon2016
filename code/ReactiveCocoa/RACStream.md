-startWith: 
将数据加到steam前。使用了-concat:方法来完成工作。

+empty: 
抽象方法

+return:
抽象方法

-bind:
抽象方法

+concat:
依赖：
	+empty
	-concat

-concat:
抽象方法

-map:
依赖：
	-flattenMap:
-mapReplace:
依赖：
	-map:

－flatten:
依赖：
	-flattenMap:
-flattenMap:
依赖：
	-bind:
通过block对value进行包装

-take:
依赖：
	-bind:
返回几次流

-takeUntilBlock:
依赖：
	-bind:
如果block返回的值是true，停止执行

-takeWhileBlock:
依赖：
	-takeUntilBlock:
如果是true,返回值
如果是false，返回nil

-skip:
先跳过N次，再反悔数据

-skipUntilBlock:
一直跳过直到block返回true

-skipWhileBlock:
block返回false时，返回数据

-filter:
依赖
	-flattenMap
如果block返回true就返回值

-ignore:
依赖：
	-filter:
忽略某个值

-zipWith:
抽象方法

+zip:reduce:
依赖：
	+zip
	+reduceEach:

+zip:
依赖：
	-zipWith
	-join

-scanWithStart:reduce:
依赖：
	-scanWithStart:reduceWithIndex:
	
-scanWithStart:reduceWithIndex:

-reduceEach:


// ???
+ (instancetype)join:(id<NSFastEnumeration>)streams block:(RACStream * (^)(id, id))block
- (instancetype)reduceEach:(id (^)())reduceBlock