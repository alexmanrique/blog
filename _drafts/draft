OutOfMemory error - How to find a memory leak in Java

In this post we are going to talk about how to find a memory leak in Java. 

You don’t look actively to memory leaks in your Java code if there are no symptoms that lead you to think that you have a memory leak. It’s a common unknown unknown between java developers that are starting his/her career in software development. 

One of the symptoms is that you see that your application is not behaving as expected, it stops without a particular reason, or you have to restart everyday this application cause the memory usage increases without limit. Another symptom is that you find in your logs Out-of-memory heap error.

Common reasons for a memory leak can be resource that is not released:
 
// example of resource that is not released

A reference to an object is not released

// example of object that is not released

Maps keeping references alive because equals and hashcode are not implemented.

Inner classes that reference outer classes can leak. (make them static to avoid).
//  example of inner class that references and outer class

How to fix this problems?

You should use a tool like VisualVM to visualize the memory usage of your application. You can download it from the following link https://visualvm.github.io/ 

Once you have downloaded it you can open the application and attach VisualVM to your application.

Next step is to perform the operation that causes the bad performance. Inspect the Monitor and the memory pools tab. The objects leaked will be in the old gen pool.
 
One thing that you can do is to comment parts of the code that might be the root cause of your problem to see if the memory leak disappears. 

You should look for unclosed PreparedStatements if you have code that accesses to the database, you should check OutputBufferSteam, File, InputBufferStream and ensure that you are closing them.

Make sure to use properly code that has autoclosable if you are using Java 7 or later, opening the resource with the try catch with resources capability this way you will not need to close explicitly

Heap dumps can help you to investigate if there’s a memory leak in your code , they allow you to see how many instances of classes are open and how much space they utilize.  

 

