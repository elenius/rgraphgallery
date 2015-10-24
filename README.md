R Graph Gallery
=========

Based on [Jekyll](https://jekyllrb.com) to produce a personal *R Graph Gallery* on [github pages](https://pages.github.com/).

[rgraphgallery](https://github.com/elenius/rgraphgallery) is based on: [najetey/GridGallery](https://github.com/nadjetey/GridGallery) that is  based on [codrips/GridGallery](https://github.com/codrops/GridGallery), see the article [Google Grid Gallery](http://tympanus.net/codrops/2014/03/21/google-grid-gallery/). See also more information on [jekyllthemes.org](http://jekyllthemes.org/themes/gridgallery/).

# How to use

Dependent on [`R`](www.r-project.org).

  1. Fork this repository
  2. Update `url` in [`_config.yml`](_config.yml) to  https://username.github.io/rgrapgallery
  3. Update `code.path` in [`create_gallery.R`](create_gallery.R) to  https://username.github.io/rgrapgallery/tree/gh-pages/R-plots
  4. Put your R-code that creates the plot in [`R-plots`](/R-plots)
  5. Run [`create_gallery.R`](create_gallery.R)
  6. Push to your github branch gh-pages
  7. View the result on https://username.github.io/rgrapgallery
  
# Demo

[https://elenius.github.io/rgraphgallery]([https://elenius.github.io/rgraphgallery])

# Licence

My contribution is mainly in the `R`-code: [/R](/R) and [/R-Plots](/R-plots) folders, see [LICENCE](LICENCE).



