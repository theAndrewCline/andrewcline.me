# andrewcline.me - WIP
This is my personal website, I did a few interesting things with that I wanted to share.

I set up a build system that leverages Netlify CMS and Elm.

Following this [tutorial](https://www.netlifycms.org/docs/add-to-your-site/), I set up the Netlify CMS admin page.

I then created a small script that would be able to grab all the json committed to the public/static folder from Netlify CMS and bundle it into a single json file.
Voila a static site builder. :tada:

I think Elm is a nice way of writing web apps
I thought it would be interesting to integrate Elm and Netlify CMS from scratch.

This project is bootstrapped from create elm app. 
I may setup a custom webpack config in the future,
but for now use this [file] (https://github.com/theAndrewCline/andrewcline.me/blob/master/ELM-APP.md) for information on starting the application.

