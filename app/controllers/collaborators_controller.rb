class CollaboratorsController < ApplicationController

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaboration.new( user_id: collaborator_params[:user_id], wiki_id: params[:wiki_id] )
    if @collaborator.save
      flash[:notice] = "Collaborator was saved."
    else
      flash[:error] = "There was an error saving collaborator. Please try again."
    end

    redirect_to edit_wiki_path(@wiki)
  end

 
   def show
    @wiki = Wiki.find(params[:id])
    @users = User.all.reject { |u| u.id == current_user.id }
    @collaborators = @wiki.collaborators

    authorize @wiki
    # if request.path != wiki_path(@wiki)
    #   redirect_to @wiki, status: :moved_permanently
    # end
  end

  def destroy
    @wiki = Wiki.friendly.find(params[:wiki_id])
    @collaborator = @wiki.collaborators.find(params[:id])

    if @collaborator.destroy
      flash[:notice] = "Collaborator was removed from wiki."
    else
      flash[:error] = "There was an error removing collaborator. Please try again."
    end

    redirect_to edit_wiki_path(@wiki)
  end


  

  
  private

  def collaborator_params
    params.require(:collaboration).permit(:user_id, :wiki_id)
  end
end