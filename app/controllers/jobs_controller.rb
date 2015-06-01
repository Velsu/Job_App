class JobsController < ApplicationController
	before_action :set_job, except: [:new, :create, :index]

	def index
		@jobs = Job.all.order(created_at: :desc)
	end

	def show
	end

	def edit
	end

	def new
		@job = Job.new
	end

	def create
		@job = Job.create(job_params)

		if @job.save
			redirect_to @job, notice: "Saved successfully"
		else
			render 'new'
		end
	end

	def update
	end

	def destroy
		if @job.destroy
			redirect_to root_url, notice: "Job deleted"
		end
	end


	private

	def set_job
		@job = Job.find(params[:id])
	end

	def job_params
		params.require(:job).permit(:title, :description, :company, :url)
	end
end
