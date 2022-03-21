# image_creation_from_Dockerfile_using_Buildah
Buildah is an open source, Linux-based tool that can build Docker- and Kubernetes-compatible images, and is easy to incorporate into scripts and build pipelines.

### Description

Buildah is open source tool that can be used to build Docker- and Kubernetes-compatible images. Buildah has the ability to create a working container from scratch, but also from a pre-existing Dockerfile. Plus, with it not needing a daemon, you'll never have to worry about Docker daemon issues when building container images.

Here we are going to create a simple buildah image using Dockerfile

### Requirement

- Ubuntu 20 ec2-instance

### Installing Buildah package in ubuntu
~~~sh
sudo apt-get -y update
. /etc/os-release
sudo sh -c "echo 'deb http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/x${ID^}_${VERSION_ID}/ /' > /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list"
wget -nv https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable/x${ID^}_${VERSION_ID}/Release.key -O Release.key
sudo apt-key add - < Release.key
sudo apt-get update -qq
sudo apt-get -qq -y install buildah
~~~
### Buildah install verification / version check
~~~sh
buildah  --version
buildah version 1.19.6 (image-spec 1.0.1-dev, runtime-spec 1.0.2-dev)
~~~
### Dockerfile
~~~sh
FROM httpd:2.4-alpine

COPY ./website/ /usr/local/apache2/htdocs/

CMD ["httpd-foreground"]
~~~

Note : I have downloaded html website from tooplate.com and renamed the website file directory to website.
~~~sh
wget https://www.tooplate.com/zip-templates/2123_simply_amazed.zip
unzip 2123_simply_amazed.zip
mv 2123_simply_amazed/ website
~~~
### Building the image
~~~sh
buildah bud -t htmlapp .
~~~
### Ouput of image build command
~~~sh
STEP 1: FROM httpd:2.4-alpine
✔ docker.io/library/httpd:2.4-alpine
Getting image source signatures
Copying blob 49862cfd7a0a done
Copying blob 716e1aeb0f58 done
Copying blob d097ef3c24fc done
Copying blob 08569d589cc2 done
Copying blob 3d2430473443 [======================================] 2.7MiB / 2.7MiB
Copying blob 40587eeed3b4 done
Copying config 807c74e1d8 done
Writing manifest to image destination
Storing signatures
STEP 2: COPY ./website/ /usr/local/apache2/htdocs/
STEP 3: CMD ["httpd-foreground"]
STEP 4: COMMIT htmlapp
Getting image source signatures
Copying blob 5e03d8cae877 skipped: already exists
Copying blob 39fa062a18ed skipped: already exists
Copying blob f6bdf9d62c65 skipped: already exists
Copying blob 4c18558d3df6 skipped: already exists
Copying blob 04bf0eeeb5f5 skipped: already exists
Copying blob 6764e2c7e971 skipped: already exists
Copying blob 61ac90da9170 done
Copying config 8441383310 done
Writing manifest to image destination
Storing signatures
--> 84413833106
844138331067e4ac96d4454d9639192a540ee317d1e09990beee63213c60c07f
~~~

### Listing the image using below command
~~~sh
buildah images
~~~

### Image list
~~~sh
REPOSITORY                TAG          IMAGE ID       CREATED          SIZE
localhost/htmlapp         latest       844138331067   24 seconds ago   61.2 MB
docker.io/library/httpd   2.4-alpine   807c74e1d84b   4 days ago       57.2 MB
~~~



