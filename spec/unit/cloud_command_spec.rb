# Author:: Mukta Aphale (<mukta.aphale@clogeny.com>)
# Copyright:: Copyright (c) 2013 Opscode, Inc.

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'chef/knife/cloud/command'

describe Chef::Knife::Cloud::Command do
  before do
    @app = App.new
    @service = Object.new
    @instance = Chef::Knife::Cloud::Command.new(@app, @service)
  end

  it "should ask for compulsory properties to be set" do
    expect {Chef::Knife::Cloud::Command.new}.to raise_error(ArgumentError)
  end

  it "should create instance with correct params" do
    @instance.service.class.should == Object
    @instance.ui.class.should == Chef::Knife::UI
  end

  it "should run with correct method calls" do
    @instance.stub(:exec_command)
    @instance.should_receive(:validate!).ordered
    @instance.should_receive(:before_handler).ordered
    @instance.should_receive(:exec_command).ordered
    @instance.should_receive(:after_handler).ordered
    #@instance.should_receive(:custom_arguments).ordered
    @instance.run
  end

  it "should raise exception to override exec_command" do
    expect {@instance.run}.to raise_error(Chef::Exceptions::Override, "You must override exec_command in #{@instance.to_s}")
  end

end

