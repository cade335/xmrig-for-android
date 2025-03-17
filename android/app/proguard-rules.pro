# Add project specific ProGuard rules here.
# By default, the flags in this file are appended to flags specified
# in /usr/local/Cellar/android-sdk/24.3.3/tools/proguard/proguard-android.txt
# You can edit the include path and order by changing the proguardFiles
# directive in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# Add any project specific keep options here:

# Keep `Companion` object fields of serializable classes.
# This avoids serializer lookup through `getDeclaredClasses` as done for named companion objects.
-if @kotlinx.serialization.Serializable class **
-keepclassmembers class <1> {
    static <1>$Companion Companion;
}

# Keep `serializer()` on companion objects (both default and named) of serializable classes.
-if @kotlinx.serialization.Serializable class ** {
    static **$* *;
}
-keepclassmembers class <1>$<3> {
    kotlinx.serialization.KSerializer serializer(...);
}

# Keep `INSTANCE.serializer()` of serializable objects.
-if @kotlinx.serialization.Serializable class ** {
    public static ** INSTANCE;
}
-keepclassmembers class <1> {
    public static <1> INSTANCE;
    kotlinx.serialization.KSerializer serializer(...);
}

# @Serializable and @Polymorphic are used at runtime for polymorphic serialization.
-keepattributes RuntimeVisibleAnnotations,AnnotationDefault

# Serializer for classes with named companion objects are retrieved using `getDeclaredClasses`.
# If you have any, uncomment and replace classes with those containing named companion objects.
#-keepattributes InnerClasses # Needed for `getDeclaredClasses`.
#-if @kotlinx.serialization.Serializable class
-if @kotlinx.serialization.Serializable class
com.xmrigforandroid.data.serialization.Configuration
{
    static **$* *;
}
-keepnames class <1>$$serializer { # -keepnames suffices; class is kept when serializer() is kept.
    static <1>$$serializer INSTANCE;
}

-keep public class com.horcrux.svg.** {*;}

-keep class com.swmansion.reanimated.** { *; }
-keep class com.facebook.react.turbomodule.** { *; }

# Keep only necessary classes and methods
-keep class com.xmrigforandroid.** { *; }

# Use wildcards to keep entire packages or groups of classes
-keep class com.xmrigforandroid.** { *; }

# Minimize the use of `-keep` rules
# No additional `-keep` rules added

# Enable shrinking and obfuscation
-optimizationpasses 5
-dontusemixedcaseclassnames
-dontskipnonpubliclibraryclasses
-dontpreverify
-verbose
-optimizations !code/simplification/arithmetic,!field/*,!class/merging/*

# Keep necessary annotations and attributes
-keepattributes RuntimeVisibleAnnotations,AnnotationDefault
# Keep necessary classes and methods for the release build
-keep class com.xmrigforandroid.** { *; }
-keep class com.xmrigforandroid.services.** { *; }
-keep class com.xmrigforandroid.utils.** { *; }
-keep class com.xmrigforandroid.workers.** { *; }
-keep class com.xmrigforandroid.data.serialization.** { *; }

# Optimize ProGuard rules for the release build
-optimizations !code/simplification/arithmetic,!field/*,!class/merging/*
-keepattributes Signature,InnerClasses,EnclosingMethod
-dontwarn com.xmrigforandroid.**
-dontwarn com.xmrigforandroid.services.**
-dontwarn com.xmrigforandroid.utils.**
-dontwarn com.xmrigforandroid.workers.**
-dontwarn com.xmrigforandroid.data.serialization.**
