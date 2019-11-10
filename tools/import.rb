require 'rubygems';
require 'bundler/setup';
require "jekyll-import";

JekyllImport::Importers::WordpressDotCom.run({
  "source" => "../WordPress.2019-11-04.xml",
  "no_fetch_images" => true,
  "assets_folder" => "assets/images"
});