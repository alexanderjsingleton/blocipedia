class WikisController < ApplicationController
  # def index
  #   @wikis = Wiki.all
  #     authorize @wikis
  # end

  def index
    # puts "this is the#{current_user.role}"
    if user_signed_in? && current_user.role == 'premium'
      @private_wikis = Wiki.where("user_id = ? AND private = ?", current_user.id, true)
    end
    @public_wikis = Wiki.where("private = ?", false)
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    if request.path != wiki_path(@wiki)
      redirect_to @wiki, status: :moved_permanently
    end
  end

  def new
    @wiki = Wiki.new
      authorize @wiki
  end

  def edit
    @wiki = Wiki.find(params[:id])
      authorize @wiki
  end

  def create
    @wiki = Wiki.new(params.require(:wiki).permit(:title, :body, :private))
    @wiki.user = current_user
      authorize @wiki
    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to @wiki
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def update
     @wiki = Wiki.find(params[:id])
      authorize @wiki
     if @wiki.update_attributes(params.require(:wiki).permit(:title, :body))
       flash[:notice] = "Wiki was updated."
       redirect_to @wiki
     else
       flash[:error] = "There was an error saving the post. Please try again."
       render :edit
     end
   end

end
