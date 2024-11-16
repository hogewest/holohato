class JobsController < ApplicationController
  def index
    @state = params[:state]
    cond = {}
    if @state.present?
      cond[:state] = @state
    end

    @jobs = Job.where(cond).order(id: :desc).page(params[:p])
  end
end
