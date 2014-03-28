Facebook Tweaks + Cocoapods issue
=================================

### Premise

If I add [Tweaks](https://github.com/facebook/Tweaks) manually instead than with CocoaPods it links, that's why I'm opening the issue on this repo.

### Issue

I experienced an unexpected behaviour using Tweaks through CocoaPods in a project with user defined [build configurations](https://developer.apple.com/library/ios/recipes/xcode_help-project_editor/articles/basingbuildconfigurationsonconfigurationfiles.html):

**Given** a project using Tweaks through CocoaPods, with a user defined build configuration, and calling `FBTweakInline` at least once.

**When** building for the user defined build configuration.

**Expected result** the build process succeeds.

**Actual result** the build process fails during linking.

### Digging into it

When building on a custom build configuration, meaning not the stock Debug and Release, the process fails during the linking, with this error:

```
Undefined symbols for architecture i386:
  "__FBTweakIdentifier", referenced from: ...
ld: symbol(s) not found for architecture i386
clang: error: linker command failed with exit code 1 (use -v to see invocation)
```

I noticed that between [`FBTweakEnabled.h`](https://github.com/facebook/Tweaks/blob/master/FBTweak/FBTweakEnabled.h), [`FBTweakInline.m`](https://github.com/facebook/Tweaks/blob/master/FBTweak/FBTweakInline.m), and [`FBTweakInlineInternal.h`](https://github.com/facebook/Tweaks/blob/master/FBTweak/FBTweakInlineInternal.h) they use `#if`s and `#ifdef`s based on `DEBUG` and `FB_TWEAK_ENABLED` to enable Tweaks. This made me think about the Preprocessors Macros.

I then went to check the Pods target settings and noticed that despite my custom build configuration was made by duplicating Debug, the DEBUG macro wasn't set. This is an issue [already addressed](https://github.com/CocoaPods/CocoaPods/issues/854#issuecomment-14844198) by you guys.

So I added this to my `Podfile`:

```ruby
xcodeproj "NAME.xcodeproj", { 'Beta' => :debug }
```

Now the project builds, but **only** when modelling from Debug.

If I manually, or through the `post_install` hook, add `FB_TWEAK_ENABLED=1` to my custom build configuration it builds. Even if I skip the `xcodeproj` set step.

But then if I set `FB_TWEAK_ENABLED=0` it doesn't build anymore.

I made [this demo repo](https://github.com/mokagio/TweaksBuildConfigurationsDemo) to reproduce the issue. Just play around with the [`Podfile`](https://github.com/mokagio/TweaksBuildConfigurationsDemo/blob/master/Podfile) and the [`post_install`](https://github.com/mokagio/TweaksBuildConfigurationsDemo/blob/master/post_install.rb) hook to see it in action.
