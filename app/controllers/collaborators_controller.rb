class CollaboratorsController < ApplicationController

  def create
    @wiki = Wiki.friendly.find(params[:wiki_id])
    @collaborator = @wiki.collaborators.build(collaborator_params)

    if @collaborator.save
      flash[:notice] = "Collaborator was saved."
    else
      flash[:error] = "There was an error saving collaborator. Please try again."
    end

    redirect_to edit_wiki_path(@wiki)
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
    params.require(:collaborator).permit(:user_id, :wiki_id)
  end
end