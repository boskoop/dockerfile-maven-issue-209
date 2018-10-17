# `${project.build.directory}` in dockerfile-maven-plugin

## Issue

See: https://github.com/spotify/dockerfile-maven/issues/209

Use the following commands in order to reproduce the issue:
```
$ mvn clean package
$ mvn dockerfile:build
```

This will result in the following error:
```
[ERROR] ADD failed: stat /var/lib/docker/tmp/docker-builderXXXXXXXXX/<path-to-project>/target/dockerfile-maven-issue-209-1.0-SNAPSHOT.jar: no such file or directory
[WARNING] An attempt failed, will retry 1 more times
org.apache.maven.plugin.MojoExecutionException: Could not build image
    at com.spotify.plugin.dockerfile.BuildMojo.buildImage (BuildMojo.java:208)
    at com.spotify.plugin.dockerfile.BuildMojo.execute (BuildMojo.java:110)
    at com.spotify.plugin.dockerfile.AbstractDockerMojo.tryExecute (AbstractDockerMojo.java:259)
    at com.spotify.plugin.dockerfile.AbstractDockerMojo.execute (AbstractDockerMojo.java:248)
    at org.apache.maven.plugin.DefaultBuildPluginManager.executeMojo (DefaultBuildPluginManager.java:134)
    at org.apache.maven.lifecycle.internal.MojoExecutor.execute (MojoExecutor.java:208)
...
Caused by: com.spotify.docker.client.exceptions.DockerException: ADD failed: stat /var/lib/docker/tmp/docker-builderXXXXXXXXX/<path-to-project>/target/dockerfile-maven-issue-209-1.0-SNAPSHOT.jar: no such file or directory
    at com.spotify.plugin.dockerfile.LoggingProgressHandler.handleError (LoggingProgressHandler.java:105)
    at com.spotify.plugin.dockerfile.LoggingProgressHandler.progress (LoggingProgressHandler.java:63)
    at com.spotify.docker.client.DefaultDockerClient$BuildProgressHandler.progress (DefaultDockerClient.java:305)
    at com.spotify.docker.client.ProgressStream.tail (ProgressStream.java:77)
    at com.spotify.docker.client.DefaultDockerClient$ResponseTailReader.call (DefaultDockerClient.java:2734)
    at com.spotify.docker.client.DefaultDockerClient$ResponseTailReader.call (DefaultDockerClient.java:2718)
    at java.util.concurrent.FutureTask.run (FutureTask.java:264)
    at java.util.concurrent.ThreadPoolExecutor.runWorker (ThreadPoolExecutor.java:1135)
    at java.util.concurrent.ThreadPoolExecutor$Worker.run (ThreadPoolExecutor.java:635)
    at java.lang.Thread.run (Thread.java:844)
...
...
[ERROR] ADD failed: stat /var/lib/docker/tmp/docker-builderXXXXXXXXX/<path-to-project>/target/dockerfile-maven-issue-209-1.0-SNAPSHOT.jar: no such file or directory
```

## Workaround

If you replace the `JAR_FILE` argument in the pom.xml with a hardcoded `target` folder, the build runs just fine:

```
          <buildArgs>
            <JAR_FILE>target/${project.build.finalName}.jar</JAR_FILE>
          </buildArgs>
```

