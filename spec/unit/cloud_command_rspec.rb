# Author:: Mukta Aphale (<mukta.aphale@clogeny.com>)
# Copyright:: Copyright (c) 2013 Opscode, Inc.
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Chef::Knife::Cloud::Command do

  it "Should ask for compalsory properties to be set" do
    expect {Chef::Knife::Cloud::Command.new}.to raise_error
  end

  pending "Should create instance with correct params: revisit compalsory params" do
    @instance = Chef::Knife::Cloud::Command.new('app', 'service')
  end

  it "Should run" do
    @instance = Chef::Knife::Cloud::Command.new('app', 'service')
    @instance.should_receive(:validate)
    @instance.should_receive(:custom_arguments)
    @instance.stub(:exec_command)
    @instance.run
  end

end

