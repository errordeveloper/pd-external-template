#!/usr/bin/ruby
require ('set');
require ('optparse');

options = {};

mode = Set.new();

## The default taget will need to
## be set to automatically somehow
options[:targets] = Set["pd_linux"];

## Suppose everyone will want "-lm"
options[:with] = Set["m"];

## Perhaps this is a safe default
options[:prefix] = "/usr/local/";
options[:install] = "#{options[:prefix]}/pd-extarnals";

options[:cflags] = Set["-Wall", "-W", "-g"];

makefile_env = ENV["PD_EXTERNAL_MAKEFILE"];

makefile_def = "pd_object.mk";

makefile = ! makefile_env.nil?? makefile_env : makefile_def ;

p makefile

## Steps:
# 1. Create empty project from template (optional)
# 2. Compile

op = OptionParser.new do |opt|

  opt.on("--lib <mylib>", String,
         "the name of shared object"
        ) { |n| options[:mylib] = n } ;

  opt.on("--with <libs>", String,
         "comma separated list of libraries (e.g. sndfile,ev,zmq) [default: \"#{options[:with].to_a.join(",")}\"]"
        ) { |n| options[:with] = n.split(",").to_set } ;
  opt.on("--cflags flags", String,
         "comma separated list of CFLAGS (e.g., \"-W,-g,-Wall\") [default: \"#{options[:cflags].to_a.join(",")}\"]"
        ) { |n| options[:cflags] = n.split(",").to_set } ;
  opt.on("--targets rype>", String,
         "comma separated list of tagets (e.g. pd_linux,pd_i386)"
        ) { |n| options[:targets] = n.split(",").to_set } ;

  opt.on("--pd-prefix <path>", String,
         "path to pd (e.g. /usr/local/)"
        ) { |n| options[:prefix] = n } ;

  opt.on("--install <path>", String,
         "path to install directory (e.g. /usr/local/lib/pd-extarnals/)"
        ) { |n| options[:install] = n } ;

  opt.on("--bundle <list>", String,
         "files you wish to bundle with the object library"
        ) { |n| options[:bundle] = n.split } ;

  opt.on("--do-create", nil,
         "create empty project from template") { mode << :create } ;

  opt.on("--do-compile", nil,
         "compile given code") { mode << :compile } ;

  opt.on("--do-install", nil,
         "install compiled object") { mode << :install } ;

end

op.parse! ARGV

p options

if mode.empty?

  puts "You should supply one of the `--do-*` arguments to start with!"
  puts op.summarize
  exit -1

end

if mode.include?(:create)
  puts "Shall I implement this?"
  exit 0
end

if mode.include?(:compile)

make = "make -f #{makefile}"

  "make #{options[:mylib]} -f #{makefile}";

  #if mode.include?(:install)

    ## Move it there right away!
  #end
  #exit 0
end

if mode.include?(:install)

  ## Try to locate the files here ...
end

##
#LIBRARY_NAME = template
#
## add your .c source files, one object per file, to the SOURCES
## variable, help files will be included automatically, and for GUI
## objects, the matching .tcl file too
#SOURCES = mycobject.c
#
## list all pd objects (i.e. myobject.pd) files here, and their helpfiles will
## be included automatically
#PDOBJECTS = mypdobject.pd
#
## example patches and related files, in the 'examples' subfolder
#EXAMPLES = bothtogether.pd
#
## manuals and related files, in the 'manual' subfolder
#MANUAL = manual.txt
#
## if you want to include any other files in the source and binary tarballs,
## list them here.  This can be anything from header files, test patches,
## documentation, etc.  README.txt and LICENSE.txt are required and therefore
## automatically included
#EXTRA_DIST =
#
## -I"$(PD_INCLUDE)/pd" supports the header location for 0.43
#CFLAGS = -I../../modules/pd/include/ -Wall -W -g
#LDFLAGS =
#LIBS = -lzmq
#
# where to install the library, overridden below depending on platform
#
#prefix = /usr/local
#libdir = $(prefix)/lib
#pkglibdir = $(libdir)/pd-externals
#objectsdir = $(pkglibdir)
