---
layout: single
title: "Migrating to Java 17 and Spring Boot 3.3.5 using Claude Code and Cursor"
date: 2026-02-19 09:08:53 +0200
categories: development
comments: true
lang: en
tags: java spring-boot migration claude cursor
image: https://images.unsplash.com/photo-1461749280684-dccba630e2f6?w=1200&h=600&fit=crop
---

{:refdef: style="text-align: center;"}
![Java Code Migration](https://images.unsplash.com/photo-1461749280684-dccba630e2f6?w=1200&h=600&fit=crop)
{: refdef}

{:refdef: style="text-align: center;font-size:9px"}
Photo by <a href="https://unsplash.com/@lucabravo?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Luca Bravo</a> on <a href="https://unsplash.com/s/photos/code-programming?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
{: refdef}

I recently completed the migration of my [Spring Boot example repository](https://github.com/alexmanrique/spring-boot-application-example) from Java 8 and Spring Boot 1.4.3 to Java 17 and Spring Boot 3.3.5. This repository is a popular example project on GitHub with **36 stars** and **89 forks**, serving as a reference implementation for developers learning Spring Boot best practices. This was a significant migration that involved updating multiple components of the technology stack. In this post, I'll share my experience, the challenges encountered, and how AI tools like Claude Code (using Claude Pro) and Cursor facilitated the process.

## Why migrate?

The original repository was using quite outdated technologies:
- **Java 8** (released in 2014)
- **Spring Boot 1.4.3** (released in 2016)
- **JUnit 4** (old version of the testing framework)
- **Maven 3.3.3** (old version of the dependency manager)

Migrating to more recent versions brings multiple benefits:
- **Performance improvements**: Java 17 includes significant performance and efficiency improvements
- **Security**: More recent versions include important security patches
- **New language features**: Records, pattern matching, text blocks, among others
- **Better support**: Older versions no longer receive security updates
- **Modern ecosystem**: Compatibility with more recent libraries and tools

## The migration process

The migration was carried out in several strategic commits that allowed keeping the project functional at each step:

### 0. Preparation: Planning and maximizing test coverage

Before touching any migration code, I followed a structured approach using **plan mode** in Claude Code. This involved creating a detailed migration plan upfront, breaking down the entire process into manageable steps and identifying potential challenges before starting.

**Using Plan Mode:**
Plan mode is particularly valuable for non-trivial tasks like this migration. It forces you to:
- Think through the entire process before executing
- Identify dependencies between different migration steps
- Anticipate breaking changes and compatibility issues
- Create a clear roadmap with checkpoints

The plan mode helped me structure the migration into logical phases:
1. Preparation (test coverage)
2. Dependency updates
3. Framework migrations
4. Configuration updates
5. CI/CD updates
6. Verification and cleanup

**Maximizing test coverage:**

One of the first things I did was **maximize test coverage** to the highest possible level. This was a critical decision that paid off significantly during the migration.

Why was this important?
- **Safety net**: Comprehensive tests act as a safety net, catching regressions immediately when something breaks during migration
- **Confidence**: High test coverage gives confidence that the application behavior remains unchanged after migration
- **Faster debugging**: When tests fail, they pinpoint exactly what broke, making debugging much faster
- **Documentation**: Tests serve as living documentation of expected behavior

I expanded the test suite with new tests for services, mappers, and controllers that weren't previously covered. This included:
- New test classes for `CarService`, `DriverService`, and various mappers
- Additional test cases for edge cases and boundary conditions
- Tests for domain value objects like `GeoCoordinate`

Having this comprehensive test suite in place before starting the migration was invaluable. Every time I made a change, the tests would immediately tell me if something broke, allowing me to fix issues incrementally rather than discovering them all at once at the end.

### 1. Updating pom.xml

The most fundamental change was updating the `pom.xml`:

```xml
<!-- Before -->
<java.version>1.8</java.version>
<version>1.4.3.RELEASE</version>

<!-- After -->
<java.version>17</java.version>
<version>3.3.5</version>
```

**Main changes:**
- **Spring Boot**: From 1.4.3 to 3.3.5 (a jump of 2 major versions)
- **Java**: From 1.8 to 17
- **Maven Wrapper**: From 3.3.3 to 3.9.6
- **Guava**: From 21.0 to 33.3.1-jre
- **Swagger**: Migration from Springfox to SpringDoc OpenAPI (Springfox is not compatible with Spring Boot 3)

### 2. Migration from JUnit 4 to JUnit 5

One of the most laborious parts was migrating all tests from JUnit 4 to JUnit 5:

**Changes in annotations:**
```java
// Before (JUnit 4)
@RunWith(SpringJUnit4ClassRunner.class)
@Test(expected = EntityNotFoundException.class)
@Before

// After (JUnit 5)
@ExtendWith(SpringExtension.class)
@Test
@BeforeEach
```

**Changes in assertions:**
```java
// Before
import static org.junit.Assert.assertEquals;

// After
import static org.junit.jupiter.api.Assertions.assertEquals;
```

### 3. Security configuration update

Spring Security changed significantly between versions. Deprecated classes were removed such as:
- `MessageSecurityWebApplicationInitializer`
- `RootConfiguration`

And `SecurityConfiguration` was updated to use the new Spring Security 6 API.

### 4. Migration from Swagger to SpringDoc

Springfox Swagger is not compatible with Spring Boot 3, so we migrated to SpringDoc OpenAPI:

```xml
<!-- Before -->
<dependency>
    <groupId>io.springfox</groupId>
    <artifactId>springfox-swagger2</artifactId>
</dependency>

<!-- After -->
<dependency>
    <groupId>org.springdoc</groupId>
    <artifactId>springdoc-openapi-starter-webmvc-ui</artifactId>
    <version>2.6.0</version>
</dependency>
```

### 5. GitHub Actions update

The CI/CD workflow also needed to be updated:

```yaml
# Before
- name: Set up JDK 11
  uses: actions/setup-java@v4
  with:
    java-version: '11'

# After
- name: Set up JDK 17
  uses: actions/setup-java@v4
  with:
    java-version: '17'
```

### 6. Additional improvements

During the migration I also took the opportunity to:
- **Add JaCoCo** for code coverage
- **Expand the test suite** with new tests for services and mappers
- **Update the README** with clearer instructions and build and coverage badges

## Challenges encountered

### 1. Breaking changes in Spring Security

Security configuration changed significantly. The new API requires a different approach to configure authentication and authorization.

### 2. Springfox incompatibility

Springfox is not compatible with Spring Boot 3, which required a complete migration to SpringDoc. Although the migration is relatively straightforward, it requires configuration changes.

### 3. Changes in JUnit

Migrating from JUnit 4 to JUnit 5 requires changes in multiple files. Although most are mechanical changes, it's important to understand the conceptual differences between both versions.

### 4. Changes in Hibernate dependencies

The specific `hibernate-java8` dependency was removed since Java 8+ is now the standard. The H2 database version was also updated.

## How Claude Code and Cursor facilitated the process

For this migration, I used **Claude Code** (with Claude Pro subscription) and **Cursor** as my AI coding assistants. These tools made the migration significantly more efficient:

**Note:** Claude Pro provides access to more advanced models with better code understanding and generation capabilities, which proved particularly valuable for this complex migration task.

### 1. Plan mode for structured approach

Before starting the migration, I used **plan mode** in Claude Code to create a comprehensive migration strategy. Plan mode is designed for non-trivial tasks (3+ steps or architectural decisions) and forces you to think through the entire process before executing.

The plan mode helped me:
- Break down the migration into logical, manageable phases
- Identify dependencies between different migration steps
- Anticipate breaking changes and compatibility issues upfront
- Create a clear roadmap with checkpoints for verification
- Reduce ambiguity by writing detailed specs before implementation

This structured approach prevented me from getting lost in the complexity of the migration and ensured I didn't miss critical steps. Whenever something unexpected happened, I could stop, re-plan, and adjust the strategy rather than continuing blindly.

### 2. Automatic problem identification

The tools quickly identified compatibility issues and suggested specific solutions for each case.

### 3. Assisted refactoring

Migrating tests from JUnit 4 to JUnit 5 was much faster with assisted refactoring. The tools suggested the correct changes in each file.

### 4. Dependency updates

The tools helped identify which dependencies needed updating and which were compatible with the new versions.

### 5. Test code generation

New tests were generated to improve coverage, following JUnit 5 best practices.

### 6. Automatic documentation

The tools helped update the README with correct information about the new versions and how to run the project.

## Results

After the migration:

✅ **Fully functional project** with Java 17 and Spring Boot 3.3.5  
✅ **All tests passing** with JUnit 5  
✅ **CI/CD updated** and working correctly  
✅ **Improved code coverage** with JaCoCo  
✅ **Updated documentation** with clear instructions  

## Lessons learned

1. **Use plan mode for complex migrations**: For non-trivial tasks like this migration, using plan mode to create a detailed strategy upfront is invaluable. It helps break down the work into manageable phases, identify dependencies, and anticipate challenges before starting.

2. **Maximize test coverage before migrating**: One of the most important steps is to maximize test coverage to the highest possible level BEFORE starting any migration work. This creates a safety net that catches regressions immediately and makes debugging much faster.

3. **Incremental migrations**: Performing the migration in small, manageable commits facilitates debugging and rollback if necessary.

4. **Tests as a safety net**: Having a comprehensive test suite helps identify problems quickly during migration, but it's crucial to build this safety net BEFORE you start migrating.

5. **AI tools as accelerators**: AI tools can significantly accelerate the process, but it's important to review and understand the changes.

6. **Documentation during the process**: Updating documentation while migrating helps keep the project maintainable.

7. **CI/CD from the start**: Updating the CI/CD pipeline at the beginning ensures all changes are automatically validated.

## Conclusion

The migration from Java 8 to Java 17 and Spring Boot 1.4.3 to 3.3.5 was a complex but necessary process. Although it requires time and effort, the benefits in terms of performance, security, and maintainability make it worthwhile.

Using AI tools like Claude Code (with Claude Pro) and Cursor made the process more efficient and less error-prone. The advanced capabilities of Claude Pro, with its deeper understanding of code context and better refactoring suggestions, were particularly helpful for navigating the breaking changes between major framework versions. However, it's important to understand the changes and not completely rely on the tools without reviewing and understanding what they're doing.

If you're considering a similar migration, I recommend:
- Planning the process well
- Making incremental changes
- Using AI tools as assistants, not as replacements for your knowledge
- Keeping tests updated throughout the process
- Documenting important changes

Have you performed similar migrations? What challenges did you encounter? Share your experience in the comments.

## References

- [Project repository](https://github.com/alexmanrique/spring-boot-application-example)
- [Spring Boot Migration Guide](https://github.com/spring-projects/spring-boot/wiki/Spring-Boot-3.0-Migration-Guide)
- [Java 17 Features](https://openjdk.org/projects/jdk/17/)
- [JUnit 5 User Guide](https://junit.org/junit5/docs/current/user-guide/)
