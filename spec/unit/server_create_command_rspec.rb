# Author:: Mukta Aphale (<mukta.aphale@clogeny.com>)
# Copyright:: Copyright (c) 2013 Opscode, Inc.

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'chef/knife/cloud/server/create_command'

describe Chef::Knife::Cloud::ServerCreateCommand do

  it "Should ask for compulsory properties to be set" do
    expect {Chef::Knife::Cloud::ServerCreateCommand.new}.to raise_error
  end

  it "Should run with correct method calls" do
    @instance = Chef::Knife::Cloud::ServerCreateCommand.new('app', 'service')
    @instance.should_receive(:validate!)
    @instance.should_receive(:custom_arguments)
    @instance.stub(:exec_command)
    @instance.run
  end

end
