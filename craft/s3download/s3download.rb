#!ruby
# coding: utf-8

require 'sinatra'
require "sinatra/reloader" if development?
require 'thin'
require 'yaml'
require 'aws-sdk'

config = YAML.load_file('config.yml')

s3 = AWS::S3.new(
  access_key_id: config['access_key_id'],
  secret_access_key: config['secret_access_key'],
  region: config['region']
)

bucket = s3.buckets[config['bucket']]

get '/:filename' do
  basename = File.basename(params[:filename])
  data = bucket.objects[basename]
  content_type "text/html"
  attachment basename
  return data.read
end
