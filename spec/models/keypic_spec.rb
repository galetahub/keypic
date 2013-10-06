# encoding: utf-8
require 'spec_helper'

describe Keypic do
  it "should be a module" do
    Keypic.should be_a(Module)
  end

  context "configuration" do
    it "should read default config values" do
      Keypic.configuration.endpoint.should == "http://ws.keypic.com"
      Keypic.configuration.form_id.should == "secret_token_here"
    end

    it "should set config value" do
      Keypic.configure do |c|
        c.endpoint = "endpoint"
        c.form_id = "form_id"
      end

      Keypic.configuration.endpoint.should == "endpoint"
      Keypic.configuration.form_id.should == "form_id"
    end
  end
end