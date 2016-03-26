class LinksController < ApplicationController
  before_action :authenticate_admin!, except: [:index, :create, :refresh]
  before_action :set_link, only: [:show, :edit, :update, :destroy]

  # GET /links
  # GET /links.json
  def index
    @links = Link.order(created_at: :desc)
    @link = Link.new
  end

  def refresh
    @links = Link.order(created_at: :desc)
  end

  # GET /links/1
  # GET /links/1.json
  def show
  end

  # GET /links/new
  def new
    @link = Link.new
  end

  # GET /links/1/edit
  def edit
  end

  # POST /links
  # POST /links.json
  def create
    @links = Link.order(created_at: :desc)
    @link = Link.new(link_params)

      if @link.valid?
        @link.url = short_url(params[:link][:url])
        respond_to do |format|
          if Link.exists?(url: @link.url)
            flash[:alert] = "This URL already exists."
            format.js
          else 
            @link.save
            flash[:notice] = "Success!"
            format.js
          end
        end
      else
        flash[:alert] = "This URL is invalid."
      end
  end

  # PATCH/PUT /links/1
  # PATCH/PUT /links/1.json
  def update
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to @link, notice: 'Link was successfully updated.' }
        format.json { render :show, status: :ok, location: @link }
      else
        format.html { render :edit }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1
  # DELETE /links/1.json
  def destroy
    @link.destroy
    respond_to do |format|
      format.html { redirect_to links_url, notice: 'Link was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def link_params
      params.require(:link).permit(:url)
    end

    def short_url(url)
      url.gsub!(/^(.*?:\/\/)?(www\.)?/, '')
      url.gsub!(/(\/[\w\W\.]*)*\/?$/, '')
      return url
    end
end
