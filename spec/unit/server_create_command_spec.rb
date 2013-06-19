# Author:: Mukta Aphale (<mukta.aphale@clogeny.com>)
# Copyright:: Copyright (c) 2013 Opscode, Inc.

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'chef/knife/cloud/server/create_command'

describe Chef::Knife::Cloud::ServerCreateCommand do

  it "Should ask for compulsory properties to be set" do
    expect {Chef::Knife::Cloud::ServerCreateCommand.new}.to raise_error(ArgumentError)
  end

  it "Should run with correct method calls" do
    @instance = Chef::Knife::Cloud::ServerCreateCommand.new('app', 'service')
    @instance.stub(:create_server_dependencies)
    @instance.stub(:create)
    @instance.should_receive(:validate!).ordered
    @instance.should_receive(:before_handler).ordered

    @instance.should_receive(:exec_command).ordered
    @instance.should_receive(:create_server_dependencies).ordered
    @instance.should_receive(:create).ordered

    @instance.should_receive(:bootstrap).ordered
    @instance.should_receive(:before_bootstrap).ordered
    @instance.should_receive(:after_bootstrap).ordered

    @instance.should_receive(:after_handler).ordered

    @instance.should_receive(:custom_arguments).ordered
    @instance.run
  end

  it "Should delete_server_dependencies on failure executing command" do
    @instance = Chef::Knife::Cloud::ServerCreateCommand.new('app', 'service')
    @instance.stub(:create_server_dependencies)
    @instance.stub(:create).and_raise(Chef::Knife::Cloud::CloudExceptions::ServerCreateError)

    @instance.should_receive(:delete_server_dependencies)
    @instance.ui.should_receive(:fatal)
    expect {@instance.run}.to raise_error(Chef::Knife::Cloud::CloudExceptions::ServerCreateError)
  end
end
