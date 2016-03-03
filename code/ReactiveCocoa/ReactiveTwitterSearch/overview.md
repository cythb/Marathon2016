这个一个使用ReactiveCocoa的例子。其功能是通过用户输入内容动态的搜索Tweets。下面我将对其目录结构做一个梳理，算作一个总结。

项目的地址是:git@github.com:ColinEberhardt/ReactiveTwitterSearch.git

#`Model`
model由四个类组成。

##`TwitterSearchError`
这个类中定义了一些错误。

##`Tweet`
`Tweet`的model类

##`TwitterSearchService`
`Tweet`的搜索请求类，用来请求数据，输出SignalProducer。以便让viewModel来处理事件。

相关类:`TwitterResponse`

##`TwitterResponse`
`TwitterSearchService`的返回数据的model。

#View
##`TwitterSearchViewController`
demo的主视图，主要由一个搜索框和tableview组成

##`TweetCellView`
用户现实Tweet的视图。

#ViewModel
##`TwitterSearchViewModel`
利用`TwitterSearchService`来请求数据，同时会负责将数据转给`TwitterSearchViewController`进行页面更新。

##`TweetViewModel`
使用`Tweet`存储数据，并负责将数据与`TweetCell`绑定。

#Util
UIKitExtensions
ReactiveCocoaExtensions
TableViewBindingHelper


