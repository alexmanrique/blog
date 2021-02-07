---
layout: single
title: "Installing Jekyll in Macbook Air M1"
date: 2021-02-05 19:08:53 +0200
categories: development
comments: true
lang: en
tags: jekyll, m1, macbook
image: 
---

This post will be a little bit different cause I will add the commands that I used to get Jekyll running on my Macbook Air m1.

## Trying to run Jekyll using ARM
 

The first thing I did was trying to install a Ruby version that is compatible with ARM and to achieve this I installed `rbenv` to be able to pick a recent version easily.

```console
$ brew install rbenv
```

To verify that rbenv is set up properly, I used the `type` command, which displays more information about the rbenv command:

```console
$ type rbenv
```

Then with the next command I init the `rbenv` environment.

```console
$ rbenv init
```

```console
$ eval "$(rbenv init -)"
```

After running the previous command I added this `eval` into my `.zshrc` file. I added it using `vi` command. This way I don't have to run this command every time I open a terminal.

```console
$ cd 
$ vi .zshrc   
```

With the following commands, I installed a version that is compatible with arm64 (Apple silicon)

```console
$ rbenv install 2.7.2
```

```console
$ rbenv global 2.7.2
```

Running the following command we can see that the installed version of Ruby is an arm64 version. 

```console
$ ruby -v
ruby 2.7.2p137 (2020-10-01 revision 5445e04352) [arm64-darwin20]
```

Then after installing the Ruby version, I tried to run `bundle install` into the directory that I have this blog Jekyll application, but the results were not the ones I expected.  

```console
$ arch -x86_64 bundle install

Error: Cannot install under Rosetta 2 in ARM default prefix (/opt/homebrew)!
To rerun under ARM use:
    arch -arm64 brew install ...
To install under x86_64, install Homebrew into /usr/local.
```

Trying to run the command to start the Jekyll application locally there were some undefined symbols for the arm64 architecture. 

```console
$ bundle exec jekyll serve

Undefined symbols for architecture arm64:
  "_ffi_call", referenced from:
      _ffi_raw_call in raw_api.o
      _ffi_java_raw_call in java_raw_api.o
  "_ffi_closure_trampoline_table_page", referenced from:
      _ffi_trampoline_table_alloc in closures.o
  "_ffi_prep_cif_machdep", referenced from:
      _ffi_prep_cif_core in prep_cif.o
  "_ffi_prep_cif_machdep_var", referenced from:
      _ffi_prep_cif_core in prep_cif.o
  "_ffi_prep_closure_loc", referenced from:
      _ffi_prep_closure in prep_cif.o
      _ffi_prep_raw_closure_loc in raw_api.o
      _ffi_prep_java_raw_closure_loc in java_raw_api.o
ld: symbol(s) not found for architecture arm64
clang: error: linker command failed with exit code 1 (use -v to see invocation)
make[3]: *** [libffi.la] Error 1
make[2]: *** [all-recursive] Error 1
make[1]: *** [all] Error 2
make: ***
```

Also, I didn't get lucky when trying to run the following commands.

```console
$ arch -x86_64 bundle update
arch: posix_spawnp: bundle: Bad CPU type in executable
```

```console
$ arch -x86_64 bundle install
arch: posix_spawnp: bundle: Bad CPU type in executable
```

## Running Jekyll using arch x86_64

In the previous section, we have seen how I struggled to try to run Jekyll on my Apple Silicon processor. The good news is that I found a workaround, using the `arch -x86_64` before the command that downloads and executes the `homebrew` installation shellscript.   

```console
$ arch -x86_64 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
> All the following commands where executed in the root folder of my jekyll project on my laptop

Then I installed the <a href="https://rubygems.org/gems/bundler">bundler</a> and <a href="https://rubygems.org/gems/jekyll">jekyll</a> gems using the following command:

```console
$ arch -x86_64 gem install --user-install bundler jekyll
Successfully installed bundler-2.2.8
Parsing documentation for bundler-2.2.8
Done installing documentation for bundler after 1 seconds
Successfully installed jekyll-4.2.0
Parsing documentation for jekyll-4.2.0
Installing ri documentation for jekyll-4.2.0
Done installing documentation for jekyll after 0 seconds
2 gems installed
```
The next step was to execute the `bundle update` command:
```console
$ bundle update
Fetching gem metadata from https://rubygems.org/...........
Resolving dependencies...........................
Using concurrent-ruby 1.1.8 (was 1.1.7)
Using multi_json 1.15.0
Using public_suffix 3.1.1
Using bundler 2.2.8
Using coffee-script-source 1.11.1
Using execjs 2.7.0
Using colorator 1.1.0
Using unf_ext 0.0.7.7
Using eventmachine 1.2.7
Using http_parser.rb 0.6.0
Using ffi 1.14.2 (was 1.13.1)
Fetching faraday-net_http 1.0.1
Using multipart-post 2.1.1
...
Fetching minima 2.5.1
Installing jekyll-theme-slate 0.1.1
Installing jekyll-theme-tactile 0.1.1
Installing jekyll-theme-merlot 0.1.1
Installing jekyll-theme-minimal 0.1.1
Installing jekyll-theme-time-machine 0.1.1
Installing minima 2.5.1
Installing jekyll-theme-midnight 0.1.1
Fetching github-pages 211 (was 207)
Installing github-pages 211 (was 207)
Bundle updated!
Post-install message from dnsruby:
Installing dnsruby...
  For issues and source code: https://github.com/alexdalitz/dnsruby
  For general discussion (please tell us how you use dnsruby): https://groups.google.com/forum/#!forum/dnsruby
Post-install message from sass:

Ruby Sass has reached end-of-life and should no longer be used.

* If you use Sass as a command-line tool, we recommend using Dart Sass, the new
  primary implementation: https://sass-lang.com/install

* If you use Sass as a plug-in for a Ruby web framework, we recommend using the
  sassc gem: https://github.com/sass/sassc-ruby#readme

* For more details, please refer to the Sass blog:
  https://sass-lang.com/blog/posts/7828841
```

The next command to execute was `bundle install` to install all of the required gems from this blog on my local laptop:

```console
$ bundle install
Using concurrent-ruby 1.1.8
Using i18n 0.9.5
Using multi_json 1.15.0
Using activesupport 3.2.22.5
Using public_suffix 3.1.1
Using addressable 2.7.0
Using bundler 2.2.8
Using coffee-script-source 1.11.1
Using execjs 2.7.0
Using coffee-script 2.4.1
...
Using jekyll-theme-primer 0.5.4
Using jekyll-theme-slate 0.1.1
Using jekyll-theme-tactile 0.1.1
Using jekyll-theme-time-machine 0.1.1
Using jekyll-titles-from-headings 0.5.3
Using jemoji 0.12.0
Using kramdown-parser-gfm 1.1.0
Using minima 2.5.1
Using unicode-display_width 1.7.0
Using terminal-table 1.8.0
Using github-pages 211
Using jekyll-include-cache 0.2.1
Bundle complete! 8 Gemfile dependencies, 90 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
```

## Up and running

Now when I execute the bundle command to run Jekyll in my local I got it up and running!

```console
$ bundle exec jekyll serve --drafts
Configuration file: blog/_config.yml
            Source: blog
       Destination: blog/_site
 Incremental build: disabled. Enable with --incremental
      Generating... 
      Remote Theme: Using theme mmistakes/minimal-mistakes
       Jekyll Feed: Generating feed for posts
                    done in 20.305 seconds.
 Auto-regeneration: enabled for 'blog'
    Server address: http://127.0.0.1:4000/blog/
  Server running... press ctrl-c to stop.
```

## Conclusion

In this post, we have seen the process that I followed to have running Jekyll on my Macbook Air m1. I hope that this post can help you getting it up and running faster than I did and not having to look for on the internet for responses to my problem a whole afternoon. 