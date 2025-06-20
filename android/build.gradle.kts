// Top-level build file for Kotlin DSL with necessary plugin versions

buildscript {
    repositories {
        google()
        mavenCentral()
    }

    dependencies {
        // ✅ Android Gradle Plugin (AGP)
        classpath("com.android.tools.build:gradle:8.3.0")

        // ✅ Kotlin Gradle Plugin (version must match your Firebase/Kotlin deps)
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:2.1.0")
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// ✅ Custom build output directory setup (preserved from your original)
val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

// ✅ Ensure subprojects evaluate after ":app"
subprojects {
    project.evaluationDependsOn(":app")
}

// ✅ Clean task
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
