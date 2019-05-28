require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_valid(:email).when("Hello@World.com")}
  it { should_not have_valid(:email).when(nil)}
end
