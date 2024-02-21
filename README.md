# MainModuleAndBonus
Practiced image rendering pagination and bonus lectures
Learning Outcomes
How to navigate between features without breaking modularity or introducing common anti-patterns
How to develop, test and use Composers in the Composition Root
How to develop and test selection handlers
How to use autoreleasepool to release autoreleased instances during tests

Dependencies Lifestyle
When managing dependencies from the Composition Root properly, you have much more control over the lifetime of the dependencies.

And it’s the Composer’s job to compose/manage components, including their lifetime.

For example, the Composers use the WeakRefVirtualProxy to avoid retain cycles in the Composition, without leaking those details into modules outside the Composition Root.

Moreover, the SceneDelegate (another component part of the Composition Root) creates and shares a single instance of the HTTPClient and CoreDataFeedStore infrastructure across the features.

As your app grows, you can also manage dependencies with a DI container in the Composition Root.

But the features don’t know about it - which makes the features easier to develop, maintain, test, extend, and reuse.

Using a single shared instance is a composition detail which can save memory, battery, and other device resources. This is such an important concept, that it was formalized into a “Lifestyle pattern” called the “Singleton Lifestyle” (don’t confuse this with the Singleton design pattern).

It’s important to note that instances with a Singleton Lifestyle usually need to be thread-safe as they’re shared among many consumers. Immutable types and stateless service are thread-safe by definition, so they are usually great candidates for a Singleton Lifestyle.


Common logging challenges
Logging/Monitoring is important but, of course, it comes with challenges.

Here are some good points about the danger of logging by Jeff Atwood:

Logging means more code, which obscures your application code.
Logging isn’t free, and logging a lot means constantly writing to disk.
The more you log, the less you can find.
If it’s worth saving to a log file, it’s worth showing in the user interface.
Moreover, logging can really complicate your codebase and the overall system design. Logging in every module will couple the modules to logger libraries. And attempts to solve the coupling with Dependency Injection leads to Constructor Over Injection. A common attempt to solve this problem is to make globally accessible logger instances through Singletons, but it also leads to unnecessary coupling, race conditions, performance issues, and anti-patterns such as Service Locator and Ambient Context.

“...developers tend to apply Ambient Context for loggers because they need logging in almost every class in their application. Injecting it in the constructor could easily lead to constructors with too many Dependencies. This is indeed a code smell called Constructor Over-injection...”—Dependency Injection Principles, Practices, and Patterns by Mark Seemann and Steven van Deursen
Also, the more logs you add, the harder it is to find issues in the middle of all the noise. So when you can, replace logging with automated tests to prevent regressions automatically.

For example, in this episode we used log statements to find issues and optimize data consumption and allocations in the app. But we removed the log statements once we fixed the issues. Of course, we also added automated tests to prevent regressions.

Finally, those challenges shouldn’t prevent you from logging/monitoring your apps. Logging is important and in some cases, even a requirement. But you need to find a clean way to implement it without overcomplicating your codebase.

With good system design as you’ve been learning in this program, you can easily implement logging/monitoring and other cross-cutting concerns in a clean way, without polluting all your modules.

