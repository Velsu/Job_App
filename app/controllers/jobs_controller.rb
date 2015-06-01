class JobsController < ApplicationController
	before_action :set_job, except: [:new, :create, :index]

	def index
		if params[:category].blank?
			@jobs = Job.all.order(created_at: :desc)
		else
			@category_id = Category.find_by(name: params[:category]).id 
			@jobs = Job.where("category_id=?", @category_id).order(created_at: :desc)
		end
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
		if @job.update_attributes(job_params)
			redirect_to @job
		else
			render 'edit'
		end
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
		params.require(:job).permit(:title, :description, :company, :url,
			                        :category_id)
	end
end
