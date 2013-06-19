# Author:: Mukta Aphale (<mukta.aphale@clogeny.com>)
# Copyright:: Copyright (c) 2013 Opscode, Inc.

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'chef/knife/cloud/command'

describe Chef::Knife::Cloud::Command do

  it "Should ask for compulsory properties to be set" do
    expect {Chef::Knife::Cloud::Command.new}.to raise_error
  end

  it "Should create instance with correct params" do
    pending "Revisit compulsory params"
    @instance = Chef::Knife::Cloud::Command.new('app', 'service')
    @instance.app.should == 'app'
    @instance.service.should == 'service'
    @instance.ui.class.should == Chef::Knife::UI
  end

  it "Should run with correct method calls" do
    @instance = Chef::Knife::Cloud::Command.new('app', 'service')
    @instance.stub(:exec_command)
    @instance.should_receive(:validate!).ordered
    @instance.should_receive(:before_handler).ordered
    @instance.should_receive(:exec_command).ordered
    @instance.should_receive(:after_handler).ordered
    @instance.should_receive(:custom_arguments).ordered
    @instance.run
  end

end

