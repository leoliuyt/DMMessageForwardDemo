# DMMessageForwardDemo
消息转发应用场景

## 消息转发流程

1.调用resolveInstanceMethod:方法，允许用户在此时为该Class动态添加实现。如果有实现了，则调用并返回。如果仍没实现，继续下面的动作。

2.调用forwardingTargetForSelector:方法，尝试找到一个能响应该消息的对象。如果获取到，则直接转发给它。如果返回了nil，继续下面的动作。

3.调用methodSignatureForSelector:方法，尝试获得一个方法签名。如果获取不到，则直接调用doesNotRecognizeSelector抛出异常。

4.调用forwardInvocation:方法，将地3步获取到的方法签名包装成Invocation传入，如何处理就在这里面了。


## respondsToSelector && instancesRespondToSelector区别

`instancesRespondToSelector` 类方法
`respondsToSelector` 实例方法

```
[learnObj.class instancesRespondToSelector:@selector(classFunc)] //NO
[learnObj.class instancesRespondToSelector:@selector(instanceFunc)] //YES
[learnObj.class respondToSelector:@selector(classFunc)] //YES
[learnObj.class respondToSelector:@selector(instanceFunc)] //NO

[learnObj respondToSelector:@selector(instanceFunc)] //YES
[learnObj respondToSelector:@selector(classFunc)] //NO




```

