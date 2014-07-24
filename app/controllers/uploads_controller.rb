# encoding: utf-8
require "open3"
require 'tapp'


class UploadsController < ApplicationController
  before_action :set_upload, only: [:show, :edit, :update, :destroy]

  # GET /uploads
  # GET /uploads.json
  def index
    @uploads = Upload.all
  end

  # GET /uploads/1
  # GET /uploads/1.json
  def show
  end

  # GET /uploads/new
  def new
    @upload = Upload.new
  end

  # GET /uploads/1/edit
  def edit
  end

  # POST /uploads
  # POST /uploads.json
  def create
    @upload = Upload.new(upload_params)

		puts '***** upload_params ********** TAPP ********** TAPP ********** TAPP *****'
		@upload.tapp
		puts '***** upload_params ********** TAPP ********** TAPP ********** TAPP *****'

    respond_to do |format|
      if @upload.save
				puts '***** Upload was successfully *****'
        format.html { redirect_to :action => 'new', notice: 'Upload was successfully created.' }
        #format.html { redirect_to @upload, notice: 'Upload was successfully created.' }
        #format.json { render :show, status: :created, location: @upload }
      else
				puts '***** Upload was NGNGNGNGNGNGNGNG *****'
        format.html { render :new }
        #format.json { render json: @upload.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /uploads/1
  # PATCH/PUT /uploads/1.json
  def update
    respond_to do |format|
      if @upload.update(upload_params)
        format.html { redirect_to @upload, notice: 'Upload was successfully updated.' }
        format.json { render :show, status: :ok, location: @upload }
      else
        format.html { render :edit }
        format.json { render json: @upload.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /uploads/1
  # DELETE /uploads/1.json
  def destroy
    @upload.destroy
    respond_to do |format|
      format.html { redirect_to uploads_url, notice: 'Upload was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_upload
      @upload = Upload.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def upload_params
			
			#puts '*******************************' + params[:filename].to_s + '*******************************'
			#if params[:filename].present?
			#	puts '***** params[:filename].present *****'

      params.require(:upload).permit(:userid, :filename, :datelog)
			
			#end
    end
end
