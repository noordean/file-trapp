class UploadsController < ApplicationController

  def index
    files = []
    Upload.all.each { |u| u.files.each { |f| files << { file: f, filename: f.filename.to_s } } }
    @files = files.uniq { |f| f[:filename] }
  end

  def new
    @upload = Upload.new
  end

  def create
    @upload = Upload.new(upload_params)

    if @upload.save
      redirect_to root_path
      flash[:success] = "File(s) successfully uploaded"
    else
      redirect_to root_path
      flash[:danger] = "An error occurred. Please try again."
    end
  end

  private

  def upload_params
    params.require(:upload).permit(:name, files: [])
  end
end
