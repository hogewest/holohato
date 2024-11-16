class JobsController < ApplicationController
  def index
    @jobs = Job.order(id: :desc).page(params[:p])
  end
end
