# frozen_string_literal: true

# Controller for Jobs
class JobsController < ApplicationController
  def index
    @user = User.find(params['user_id'])
    @jobs = Job.all
  end
end
