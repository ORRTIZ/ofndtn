# ofndtn
Apache OFBiz - Theme Integration Solution for the Foundation front-end framework.

### For the OFBiz backend
This theme is intended for 'back-end' OFBiz applications. It is being developed and tested against Apache OFBiz&trade; - trunk and utilizes the [ZURB Foundation front-end framework](http://foundation.zurb.com).

**Installation instructions**

Just put the following in the svn:externals properties of the themes folder of your OFBiz implementation for a checkout:

ofndtn              https://github.com/ORRTIZ/ofndtn/trunk

After having updated the hot-deploy folder (to execute the checkout from the repository), you'll need to build OFBiz again (./ant build) and load the seed, seed-initial and  - optionally- demo datasets.

